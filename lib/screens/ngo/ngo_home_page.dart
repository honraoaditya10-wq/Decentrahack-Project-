 



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ngo_profile_screen.dart';
import 'events_page.dart';

class NGODonationManagementHeader extends StatefulWidget {
  const NGODonationManagementHeader({super.key});

  @override
  State<NGODonationManagementHeader> createState() => _NGODonationManagementHeaderState();
}

class _NGODonationManagementHeaderState extends State<NGODonationManagementHeader> {
  int _selectedIndex = 0;

  Widget _getBodyWidget() {
    if (_selectedIndex == 0) {
      return _NGODonationPageBody();
    } else if (_selectedIndex == 1) {
      return const EventsPage();
    } else {
      return const SizedBox.shrink();
    }
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onProfileTapped(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NGOProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1F8EF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: SafeArea(
          child: Container(
            color: const Color(0xFFD1F8EF),
            padding: const EdgeInsets.only(left: 0, right: 14, top: 8, bottom: 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(height: 2),
                    Text(
                      "NGO Donation",
                      style: TextStyle(
                        color: Color(0xFF4B81C1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        height: 1.1,
                        letterSpacing: 0.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 0),
                    Text(
                      "Management",
                      style: TextStyle(
                        color: Color(0xFF4B81C1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        height: 1.1,
                        letterSpacing: 0.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 8,
                  child: GestureDetector(
                    onTap: () => _onProfileTapped(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFF4B81C1), width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF4B81C1),
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26),
            child: _getBodyWidget(),
          ),
        ],
      ),
      bottomNavigationBar: _NGOBottomNavBar(selectedIndex: _selectedIndex, onTap: _onNavTapped),
    );
  }
}

class _NGODonationPageBody extends StatefulWidget {
  @override
  State<_NGODonationPageBody> createState() => _NGODonationPageBodyState();
}

class _NGODonationPageBodyState extends State<_NGODonationPageBody> {
  final List<String> statuses = ["pending", "confirmed", "picked_up", "completed", "cancelled"];
  String selectedStatus = "pending";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getCurrentTimestamp() {
    DateTime now = DateTime.now().toUtc();
    return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  Future<void> updateDonationStatus(String donationId, String newStatus) async {
    try {
      await _firestore.collection('donations').doc(donationId).update({
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
        'ngoUpdatedAt': _getCurrentTimestamp(),
        'ngoProcessedTime': FieldValue.serverTimestamp(),
      });

      String message = '';
      Color bgColor = Colors.blue;
      
      switch (newStatus) {
        case 'confirmed':
          message = '✅ Request Accepted! Tejas2305 will be notified.';
          bgColor = Colors.blue;
          break;
        case 'cancelled':
          message = '❌ Request Declined! Tejas2305 will be notified.';
          bgColor = Colors.red;
          break;
        case 'picked_up':
          message = '📦 Marked as Picked Up! Status updated.';
          bgColor = Colors.green;
          break;
        case 'completed':
          message = '🎉 Donation Completed! Thank you for the service.';
          bgColor = Colors.green[700]!;
          break;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(message, style: const TextStyle(fontWeight: FontWeight.w500))),
              ],
            ),
            backgroundColor: bgColor,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text('Error updating status: $e')),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _callDonor(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not make call: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _openMaps(double lat, double lng, String address) async {
    try {
      final Uri mapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
      if (await canLaunchUrl(mapsUri)) {
        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not open maps';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open maps: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 28),
          
          // Current Time Display
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFF3F9F7), const Color(0xFFE8F5F0)],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF4B81C1).withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4B81C1).withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: const Color(0xFF4B81C1), size: 16),
                const SizedBox(width: 8),
                Text(
                  "Current Time: ${_getCurrentTimestamp()} UTC",
                  style: const TextStyle(
                    color: Color(0xFF4B81C1),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),

          // Status Filter Dropdown
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 18, bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F9F7),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: const Color(0xFF4B81C1).withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedStatus,
                    isExpanded: false,
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 25),
                    borderRadius: BorderRadius.circular(12),
                    style: const TextStyle(
                      color: Color(0xFF3A3A3A),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    items: statuses.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Row(
                          children: [
                            _getStatusIcon(status),
                            const SizedBox(width: 8),
                            Text(
                              _getStatusDisplayName(status),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue ?? "pending";
                      });
                    },
                  ),
                ),
              ),
            ),
          ),

          // Firebase Stream Builder - FIXED QUERY
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('donations')
                .where('status', isEqualTo: selectedStatus)
                .snapshots(), // Removed orderBy to fix index issue
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[600]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Error loading donations: ${snapshot.error}',
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(50),
                  child: Center(
                    child: Column(
                      children: [
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4B81C1)),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading donations from Tejas2305...',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final donations = snapshot.data?.docs ?? [];

              // Sort manually by createdAt (newest first)
              donations.sort((a, b) {
                try {
                  final aData = a.data() as Map<String, dynamic>;
                  final bData = b.data() as Map<String, dynamic>;
                  
                  final aTime = aData['createdAt'];
                  final bTime = bData['createdAt'];
                  
                  if (aTime == null && bTime == null) return 0;
                  if (aTime == null) return 1;
                  if (bTime == null) return -1;
                  
                  if (aTime is Timestamp && bTime is Timestamp) {
                    return bTime.compareTo(aTime);
                  }
                  
                  return 0;
                } catch (e) {
                  return 0;
                }
              });

              if (donations.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No ${_getStatusDisplayName(selectedStatus)} requests",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Waiting for donations from users like Tejas2305...",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    // Results count
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4B81C1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Found ${donations.length} ${_getStatusDisplayName(selectedStatus)} donation${donations.length == 1 ? '' : 's'}",
                        style: const TextStyle(
                          color: Color(0xFF4B81C1),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    // Donation cards
                    ...donations.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final donationId = doc.id;
                      
                      return FirebaseDonationCard(
                        donationId: donationId,
                        data: data,
                        onStatusUpdate: updateDonationStatus,
                        onCall: _callDonor,
                        onNavigate: _openMaps,
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  String _getStatusDisplayName(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return 'Pending';
      case 'confirmed': return 'Accepted';
      case 'picked_up': return 'Picked Up';
      case 'completed': return 'Completed';
      case 'cancelled': return 'Declined';
      default: return status;
    }
  }

  Widget _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Icon(Icons.watch_later, color: Colors.orange[600], size: 16);
      case 'confirmed': return Icon(Icons.check_circle_outline, color: Colors.blue[600], size: 16);
      case 'picked_up': return Icon(Icons.local_shipping, color: Colors.green[600], size: 16);
      case 'completed': return Icon(Icons.check_circle, color: Colors.green[700], size: 16);
      case 'cancelled': return Icon(Icons.cancel, color: Colors.red[600], size: 16);
      default: return Icon(Icons.help_outline, color: Colors.grey[600], size: 16);
    }
  }
}

class FirebaseDonationCard extends StatelessWidget {
  final String donationId;
  final Map<String, dynamic> data;
  final Function(String, String) onStatusUpdate;
  final Function(String) onCall;
  final Function(double, double, String) onNavigate;

  const FirebaseDonationCard({
    Key? key,
    required this.donationId,
    required this.data,
    required this.onStatusUpdate,
    required this.onCall,
    required this.onNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String status = data['status'] ?? 'pending';
    final String donationType = data['donationType'] ?? 'unknown';
    final String userDisplayName = data['userDisplayName'] ?? 'Unknown User';
    final String userEmail = data['userEmail'] ?? 'No email';
    
    // Get donation details based on type
    Map<String, dynamic> details = _getDonationDetails(data, donationType);
    
    final Color statusColor = _getStatusColor(status);
    final IconData statusIcon = _getStatusIcon(status);

    // Get location info
    final pickupInfo = data['pickupInformation'] ?? {};
    final coordinates = pickupInfo['coordinates'];
    final phoneNumber = pickupInfo['phoneNumber'] ?? '';
    final fullAddress = pickupInfo['fullAddress'] ?? 'Location not specified';

    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: statusColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with gradient
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [statusColor.withOpacity(0.1), statusColor.withOpacity(0.05)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        details['title'],
                        style: const TextStyle(
                          color: Color(0xFF222B45),
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _getStatusDisplayName(status),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (status == 'pending')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "NEW",
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Donation Information
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF3DA9F5), width: 1.5),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: const Color(0xFF3DA9F5), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            "Donation Details",
                            style: TextStyle(
                              color: const Color(0xFF3DA9F5),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _iconTextRow(Icons.fastfood_outlined, "Type: ${donationType.toUpperCase()}", const Color(0xFF3DA9F5)),
                      const SizedBox(height: 4),
                      _iconTextRow(Icons.scale, "Quantity: ${details['quantity']}", const Color(0xFF3DA9F5)),
                      const SizedBox(height: 4),
                      _iconTextRow(Icons.schedule, "Submitted: ${_formatDate(data['createdAt'])}", const Color(0xFF3DA9F5)),
                      if (data['foodDetails']?['expiryDate'] != null) ...[
                        const SizedBox(height: 4),
                        _iconTextRow(Icons.warning_amber_outlined, "Expires: ${_formatDate(data['foodDetails']['expiryDate'])}", Colors.orange),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Donor Information
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2FFFB),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF42EAC3), width: 1.5),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: const Color(0xFF3AAFA6), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            "Donor Information (Tejas2305)",
                            style: TextStyle(
                              color: const Color(0xFF3AAFA6),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _iconTextRow(Icons.person, "Name: $userDisplayName", const Color(0xFF3AAFA6)),
                      const SizedBox(height: 4),
                      _iconTextRow(Icons.email_outlined, "Email: $userEmail", const Color(0xFF3AAFA6)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, color: const Color(0xFF3AAFA6), size: 13),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "Phone: ${phoneNumber.isNotEmpty ? phoneNumber : 'Not provided'}",
                              style: const TextStyle(
                                color: Color(0xFF2A3B4D),
                                fontSize: 11.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (phoneNumber.isNotEmpty)
                            IconButton(
                              onPressed: () => onCall(phoneNumber),
                              icon: Icon(Icons.call, color: Colors.green[600], size: 18),
                              visualDensity: VisualDensity.compact,
                              tooltip: "Call Tejas2305",
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Location Information
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue[200]!, width: 1.5),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.blue[600], size: 16),
                          const SizedBox(width: 6),
                          Text(
                            "Pickup Location",
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.place, color: Colors.blue[600], size: 13),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              fullAddress,
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 11.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (coordinates != null)
                            IconButton(
                              onPressed: () => onNavigate(
                                coordinates['latitude']?.toDouble() ?? 0.0,
                                coordinates['longitude']?.toDouble() ?? 0.0,
                                fullAddress,
                              ),
                              icon: Icon(Icons.navigation, color: Colors.blue[600], size: 18),
                              visualDensity: VisualDensity.compact,
                              tooltip: "Open in Maps",
                            ),
                        ],
                      ),
                      if (coordinates != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          "📍 ${coordinates['latitude']?.toStringAsFixed(6)}, ${coordinates['longitude']?.toStringAsFixed(6)}",
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 10,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Action Buttons
                const SizedBox(height: 16),
                
                if (status == "pending")
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => onStatusUpdate(donationId, 'confirmed'),
                          icon: const Icon(Icons.check_circle, color: Colors.white, size: 18),
                          label: const Text('Accept', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => onStatusUpdate(donationId, 'cancelled'),
                          icon: const Icon(Icons.cancel, color: Colors.white, size: 18),
                          label: const Text('Decline', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 3,
                          ),
                        ),
                      ),
                    ],
                  ),

                if (status == "confirmed")
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => onStatusUpdate(donationId, 'picked_up'),
                          icon: const Icon(Icons.local_shipping, color: Colors.white, size: 18),
                          label: const Text('Mark Picked Up', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.indigo),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (coordinates != null) {
                              onNavigate(
                                coordinates['latitude']?.toDouble() ?? 0.0,
                                coordinates['longitude']?.toDouble() ?? 0.0,
                                fullAddress,
                              );
                            }
                          },
                          icon: const Icon(Icons.navigation, color: Colors.indigo, size: 24),
                          tooltip: "Navigate",
                        ),
                      ),
                    ],
                  ),

                if (status == "picked_up")
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => onStatusUpdate(donationId, 'completed'),
                      icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                      label: const Text('Mark Complete', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 4,
                      ),
                    ),
                  ),

                if (status == "completed")
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green[100]!, Colors.green[50]!],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[300]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.celebration, color: Colors.green[700], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "🎉 Donation Completed Successfully!",
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (status == "cancelled")
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, color: Colors.red[600], size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "This donation was declined",
                          style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconTextRow(IconData icon, String text, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 13),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2A3B4D),
              fontSize: 11.2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getDonationDetails(Map<String, dynamic> data, String donationType) {
    switch (donationType.toLowerCase()) {
      case 'food':
        final foodDetails = data['foodDetails'] ?? {};
        return {
          'title': foodDetails['name'] ?? 'Food Donation',
          'quantity': foodDetails['quantity'] ?? 'Unknown quantity',
        };
      case 'clothes':
        final clothesDetails = data['clothesDetails'] ?? {};
        return {
          'title': clothesDetails['name'] ?? 'Clothes',
          'quantity': '${clothesDetails['quantity'] ?? 0} items',
        };
      case 'books':
        final bookDetails = data['bookDetails'] ?? {};
        return {
          'title': bookDetails['name'] ?? 'Books',
          'quantity': '${bookDetails['quantity'] ?? 0} books',
        };
      default:
        return {
          'title': 'Donation',
          'quantity': 'Unknown',
        };
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return const Color(0xFFFFBA27);
      case 'confirmed': return Colors.blue;
      case 'picked_up': return Colors.green;
      case 'completed': return Colors.green[700]!;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return Icons.watch_later;
      case 'confirmed': return Icons.check_circle_outline;
      case 'picked_up': return Icons.local_shipping;
      case 'completed': return Icons.check_circle;
      case 'cancelled': return Icons.cancel;
      default: return Icons.help_outline;
    }
  }

  String _getStatusDisplayName(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return 'Pending';
      case 'confirmed': return 'Accepted';
      case 'picked_up': return 'Picked Up';
      case 'completed': return 'Completed';
      case 'cancelled': return 'Declined';
      default: return status;
    }
  }

  String _formatDate(dynamic dateField) {
    try {
      DateTime date;
      
      if (dateField is Timestamp) {
        date = dateField.toDate();
      } else if (dateField is String) {
        date = DateTime.parse(dateField);
      } else {
        return 'Date not available';
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
      return 'Date not available';
    }
  }
}

// Keep your existing bottom navigation bar code
class _NGOBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const _NGOBottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Color(0xFFD1F8EF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            label: "All Donations",
            icon: Icons.receipt_long,
            selected: selectedIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            label: "Events",
            icon: Icons.emoji_events,
            selected: selectedIndex == 1,
            onTap: () => onTap(1),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _NavBarItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: selected
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            : EdgeInsets.zero,
        decoration: selected
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF4A90A4), size: 26),
            if (selected) ...[
              const SizedBox(width: 7),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF4A90A4),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}