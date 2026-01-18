import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationHistoryScreen extends StatefulWidget {
  const DonationHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<DonationHistoryScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  String _searchQuery = "";
  List<Map<String, dynamic>> allDonations = [];
  bool _isLoading = true;
  String _userDisplayName = "Tejas2305";
  String _userEmail = "";

  // Theme colors
  static const Color mainPurple = Color(0xFF5C2C9C);
  static const Color fieldPurple = Color(0xFFB17CDF);
  static const Color bgLight = Color(0xFFEFDBF6);
  static const Color gradientStrong = Color(0xFF9478B9);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _getCurrentUser();
    _fetchDonations();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _getCurrentUser() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      _userEmail = currentUser.email ?? "";
      String displayName = currentUser.displayName ?? "";
      
      if (displayName.isNotEmpty) {
        _userDisplayName = displayName;
      } else if (_userEmail.isNotEmpty) {
        _userDisplayName = _userEmail.split('@')[0];
      } else {
        _userDisplayName = "Tejas2305";
      }
    }
  }

  String _getCurrentTimestamp() {
    DateTime now = DateTime.now().toUtc();
    return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  Future<void> _fetchDonations() async {
    setState(() => _isLoading = true);

    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      QuerySnapshot donationsSnapshot = await _firestore
          .collection('donations')
          .where('userId', isEqualTo: currentUser.uid)
          .limit(50) // Limit to prevent overload
          .get();

      List<Map<String, dynamic>> fetchedDonations = [];

      for (var doc in donationsSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        Map<String, dynamic> donation = {
          'donationId': doc.id,
          'ngo': _getNGOName(data['donationType']),
          'title': _getDonationTitle(data),
          'progress': _getStatusText(data['status'] ?? 'pending'),
          'date': _formatDate(data['submittedAt'] ?? data['createdAt']),
          'status': data['status'] ?? 'pending',
          'donationType': data['donationType'] ?? 'unknown',
          'details': _getDonationDetails(data),
          'location': _truncateText(data['pickupInformation']?['fullAddress'] ?? 'Location not specified', 30),
          'phone': data['pickupInformation']?['phoneNumber'] ?? 'N/A',
          'submissionTimestamp': data['submissionTimestamp'] ?? 'N/A',
          'userDisplayName': data['userDisplayName'] ?? _userDisplayName,
          'createdAt': data['createdAt'],
        };

        fetchedDonations.add(donation);
      }

      // Sort by creation date (newest first)
      fetchedDonations.sort((a, b) {
        var aTime = a['createdAt'];
        var bTime = b['createdAt'];
        
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        
        try {
          DateTime aDate = aTime is Timestamp ? aTime.toDate() : DateTime.parse(aTime.toString());
          DateTime bDate = bTime is Timestamp ? bTime.toDate() : DateTime.parse(bTime.toString());
          return bDate.compareTo(aDate);
        } catch (e) {
          return 0;
        }
      });

      setState(() {
        allDonations = fetchedDonations;
        _isLoading = false;
      });

      _animationController.forward();

    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        _showErrorSnackBar("Error loading donations: ${e.toString().substring(0, 50)}...");
      }
    }
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message, style: const TextStyle(fontSize: 14))),
          ],
        ),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // Simplified helper methods
  String _getNGOName(String donationType) {
    const Map<String, String> ngoMap = {
      'clothes': 'Clothes for Good NGO',
      'food': 'Feed the Hungry Foundation',
      'books': 'Education for All NGO',
    };
    return ngoMap[donationType.toLowerCase()] ?? 'Community Welfare NGO';
  }

  String _getDonationTitle(Map<String, dynamic> data) {
    String donationType = data['donationType'] ?? 'unknown';
    String name = '';
    String category = '';
    
    switch (donationType.toLowerCase()) {
      case 'clothes':
        name = data['clothesDetails']?['name'] ?? 'Clothes';
        category = data['clothesDetails']?['category'] ?? '';
        break;
      case 'food':
        name = data['foodDetails']?['name'] ?? 'Food';
        category = data['foodDetails']?['category'] ?? '';
        break;
      case 'books':
        name = data['bookDetails']?['name'] ?? 'Books';
        category = data['bookDetails']?['category'] ?? '';
        break;
      default:
        return 'Community Donation';
    }
    
    String title = '$name${category.isNotEmpty ? ' - $category' : ''} Donation';
    return _truncateText(title, 35);
  }

  String _getStatusText(String status) {
    const Map<String, String> statusMap = {
      'pending': '⏳ Pending',
      'confirmed': '✅ Confirmed',
      'picked_up': '📦 Picked Up',
      'completed': '🎉 Completed',
      'cancelled': '❌ Cancelled',
    };
    return statusMap[status.toLowerCase()] ?? '⏳ Processing';
  }

  String _formatDate(dynamic dateField) {
    try {
      DateTime date;
      
      if (dateField is Timestamp) {
        date = dateField.toDate();
      } else if (dateField is String) {
        date = DateTime.parse(dateField);
      } else {
        return 'N/A';
      }

      date = date.toLocal();
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      
      String month = months[date.month - 1];
      String day = date.day.toString().padLeft(2, '0');
      int hour12 = date.hour == 0 ? 12 : (date.hour > 12 ? date.hour - 12 : date.hour);
      String minute = date.minute.toString().padLeft(2, '0');
      String period = date.hour >= 12 ? 'PM' : 'AM';
      
      return '$day $month, $hour12:$minute $period';
    } catch (e) {
      return 'N/A';
    }
  }

  String _getDonationDetails(Map<String, dynamic> data) {
    String donationType = data['donationType'] ?? 'unknown';
    
    switch (donationType.toLowerCase()) {
      case 'clothes':
        int quantity = data['clothesDetails']?['quantity'] ?? 0;
        return '$quantity items';
      case 'food':
        String quantity = data['foodDetails']?['quantity'] ?? 'Unknown';
        return quantity;
      case 'books':
        int quantity = data['bookDetails']?['quantity'] ?? 0;
        return '$quantity books';
      default:
        return 'Details';
    }
  }

  List<Map<String, dynamic>> get filteredDonations {
    if (_searchQuery.isEmpty) return allDonations;
    return allDonations.where((donation) =>
        donation['ngo'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        donation['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        donation['donationType'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
        donation['status'].toString().toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  Color _getStatusColor(String status) {
    const Map<String, Color> colorMap = {
      'pending': Colors.orange,
      'confirmed': Colors.blue,
      'picked_up': Colors.green,
      'completed': Color(0xFF2E7D32),
      'cancelled': Colors.red,
    };
    return colorMap[status.toLowerCase()] ?? Colors.grey;
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: bgLight,
    body: CustomScrollView(
      slivers: [
        // Custom App Bar
        SliverAppBar(
          expandedHeight: 120,
          floating: false,
          pinned: true,
          backgroundColor: bgLight,
          elevation: 0,

          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true, // <-- This centers the title
            title: Text(
              'My Donations',
              style: TextStyle(
                color: mainPurple,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bgLight, gradientStrong.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),


          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Compact User Info
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: gradientStrong.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: fieldPurple,
                          radius: 20,
                          child: Text(
                            _userDisplayName.isNotEmpty ? _userDisplayName[0].toUpperCase() : 'T',
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userDisplayName,
                                style: TextStyle(color: mainPurple, fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Current: ${_getCurrentTimestamp()} UTC",
                                style: TextStyle(color: gradientStrong, fontSize: 11, fontFamily: 'monospace'),
                              ),
                            ],
                          ),
                        ),
                        if (!_isLoading && allDonations.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: fieldPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${allDonations.length} donations',
                              style: TextStyle(color: mainPurple, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Main Content Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: gradientStrong.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: bgLight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: fieldPurple.withOpacity(0.2)),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (val) => setState(() => _searchQuery = val),
                              decoration: InputDecoration(
                                hintText: "Search donations...",
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                hintStyle: TextStyle(color: gradientStrong.withOpacity(0.7), fontSize: 14),
                                prefixIcon: Icon(Icons.search, color: fieldPurple, size: 20),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(Icons.clear, color: gradientStrong, size: 18),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() => _searchQuery = "");
                                        },
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),

                        // Stats Row (Compact)
                        if (!_isLoading && allDonations.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [fieldPurple.withOpacity(0.05), mainPurple.withOpacity(0.05)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildCompactStatItem("Total", allDonations.length.toString(), Icons.volunteer_activism),
                                _buildCompactStatItem("Pending", allDonations.where((d) => d['status'] == 'pending').length.toString(), Icons.pending),
                                _buildCompactStatItem("Done", allDonations.where((d) => d['status'] == 'completed').length.toString(), Icons.check_circle),
                              ],
                            ),
                          ),

                        // Content States
                        if (_isLoading)
                          _buildLoadingState()
                        else if (allDonations.isEmpty)
                          _buildEmptyState()
                        else if (filteredDonations.isEmpty)
                          _buildNoSearchResultsState()
                        else
                          _buildDonationsList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: mainPurple, size: 20),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: mainPurple)),
        Text(label, style: TextStyle(fontSize: 10, color: gradientStrong, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(fieldPurple), strokeWidth: 3),
          const SizedBox(height: 16),
          Text('Loading donations...', style: TextStyle(color: mainPurple, fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.volunteer_activism, size: 60, color: gradientStrong.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text('No donations yet', style: TextStyle(color: mainPurple, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Start donating to build your history!', style: TextStyle(color: gradientStrong, fontSize: 13), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: fieldPurple,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            child: const Text("Start Donating", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildNoSearchResultsState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 50, color: gradientStrong.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text('No results for "$_searchQuery"', style: TextStyle(color: mainPurple, fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() => _searchQuery = "");
            },
            child: Text("Clear search", style: TextStyle(color: fieldPurple, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationsList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredDonations.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, idx) {
          final donation = filteredDonations[idx];
          return _buildCompactDonationCard(donation, idx);
        },
      ),
    );
  }

  Widget _buildCompactDonationCard(Map<String, dynamic> donation, int index) {
    return GestureDetector(
      onTap: () => _showDonationDetails(donation),
      child: Hero(
        tag: "donation_${donation['donationId']}_$index",
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: fieldPurple.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: gradientStrong.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compact header
              Stack(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _getDonationGradient(donation['donationType']),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    ),
                    child: Icon(_getDonationIcon(donation['donationType']), size: 28, color: Colors.white),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(donation['status']),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        donation['status'].toString().toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              // Compact content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_truncateText(donation['ngo'], 20), style: TextStyle(color: fieldPurple, fontWeight: FontWeight.w600, fontSize: 10)),
                      const SizedBox(height: 3),
                      Expanded(
                        child: Text(
                          donation['title'],
                          style: TextStyle(color: mainPurple, fontWeight: FontWeight.w700, fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(donation['details'], style: TextStyle(color: gradientStrong, fontWeight: FontWeight.w500, fontSize: 9)),
                      const SizedBox(height: 3),
                      Text(donation['progress'], style: TextStyle(color: _getStatusColor(donation['status']), fontWeight: FontWeight.w600, fontSize: 9)),
                      const SizedBox(height: 3),
                      Text(donation['date'], style: TextStyle(color: gradientStrong.withOpacity(0.8), fontWeight: FontWeight.w500, fontSize: 8)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getDonationGradient(String donationType) {
    const Map<String, List<Color>> gradientMap = {
      'clothes': [fieldPurple, mainPurple],
      'food': [Color(0xFF11998e), Color(0xFF38ef7d)],
      'books': [Color(0xFFfc4a1a), Color(0xFFf7b733)],
    };
    return gradientMap[donationType.toLowerCase()] ?? [fieldPurple, gradientStrong];
  }

  IconData _getDonationIcon(String donationType) {
    const Map<String, IconData> iconMap = {
      'clothes': Icons.checkroom,
      'food': Icons.restaurant,
      'books': Icons.menu_book,
    };
    return iconMap[donationType.toLowerCase()] ?? Icons.volunteer_activism;
  }

  void _showDonationDetails(Map<String, dynamic> donation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: gradientStrong.withOpacity(0.3), borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: _getDonationGradient(donation['donationType'])),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(_getDonationIcon(donation['donationType']), color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(donation['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: mainPurple)),
                            Text(donation['ngo'], style: TextStyle(color: fieldPurple, fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getStatusColor(donation['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _getStatusColor(donation['status']).withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: _getStatusColor(donation['status']), size: 18),
                        const SizedBox(width: 8),
                        Text(donation['progress'], style: TextStyle(color: _getStatusColor(donation['status']), fontWeight: FontWeight.w600, fontSize: 13)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailItem('📅 Date', donation['date']),
                  _buildDetailItem('👤 User', donation['userDisplayName']),
                  _buildDetailItem('📦 Type', donation['donationType'].toString().toUpperCase()),
                  _buildDetailItem('📊 Details', donation['details']),
                  _buildDetailItem('📍 Location', donation['location']),
                  _buildDetailItem('📞 Contact', donation['phone']),
                  _buildDetailItem('🆔 ID', _truncateText(donation['donationId'], 20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: gradientStrong, fontSize: 13)),
          ),
          Expanded(child: Text(value, style: TextStyle(fontSize: 13, color: mainPurple, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}