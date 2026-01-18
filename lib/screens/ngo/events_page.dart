import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ngo_home_page.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController registrationLinkController = TextEditingController();

  DateTime? selectedDateTime;
  bool _isSubmitting = false;

  final Color eventsBlue = const Color.fromARGB(255, 54, 116, 181);
  final Color accentTeal = const Color(0xFF4DB8AC);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getCurrentTimestamp() {
    DateTime now = DateTime.now().toUtc();
    return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB8E6E1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: eventsBlue.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: eventsBlue, size: 20),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const NGODonationManagementHeader()),
                (route) => false,
              );
            },
          ),
        ),
        title: Text(
          'NGO Events Manager',
          style: GoogleFonts.poppins(
            color: eventsBlue,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.95), Colors.white.withOpacity(0.85)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: eventsBlue.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              "🎯 NGO",
              style: GoogleFonts.poppins(
                color: eventsBlue,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Time Display - Enhanced
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFE3F5F3),
                        const Color(0xFFD1EDE9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accentTeal.withOpacity(0.3), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: accentTeal.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.access_time_rounded, color: accentTeal, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Current Time: ${_getCurrentTimestamp()} UTC",
                        style: GoogleFonts.poppins(
                          color: eventsBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Header text - Enhanced
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 28.0),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        eventsBlue.withOpacity(0.08),
                        eventsBlue.withOpacity(0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: eventsBlue.withOpacity(0.15)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: eventsBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.celebration_rounded, color: eventsBlue, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Create Events for Tejas2305 and Other Donors',
                          style: GoogleFonts.poppins(
                            color: eventsBlue,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                _buildInputField(
                  controller: eventNameController,
                  hintText: 'Enter event name (e.g., Food Donation Drive)',
                  icon: Icons.event_rounded,
                ),
                const SizedBox(height: 18),
                _buildInputField(
                  controller: descriptionController,
                  hintText: 'Enter description (e.g., Join us to help the community)',
                  maxLines: 5,
                  height: 140,
                  icon: Icons.description_rounded,
                ),
                const SizedBox(height: 20),
                _buildDateTimeField(context),
                const SizedBox(height: 18),
                _buildInputField(
                  controller: locationController,
                  hintText: 'Enter location (e.g., Community Center, City Hall)',
                  icon: Icons.location_on_rounded,
                ),
                const SizedBox(height: 18),
                _buildInputField(
                  controller: registrationLinkController,
                  hintText: 'Enter registration link (optional)',
                  icon: Icons.link_rounded,
                ),
                const SizedBox(height: 32),

                // Recent Events Section
                _buildRecentEventsSection(),

                const SizedBox(height: 36),
                Center(
                  child: Container(
                    width: 220,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        colors: _isSubmitting 
                          ? [Colors.grey[400]!, Colors.grey[500]!]
                          : [eventsBlue, eventsBlue.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (_isSubmitting ? Colors.grey : eventsBlue).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _addEventToFirebase,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: _isSubmitting
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Publishing...',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.publish_rounded, color: Colors.white, size: 22),
                                const SizedBox(width: 10),
                                Text(
                                  'Publish Event',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentEventsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF8FCFC),
            const Color(0xFFF0F9F8),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentTeal.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentTeal.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accentTeal.withOpacity(0.15), accentTeal.withOpacity(0.08)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.event_note_rounded, color: accentTeal, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                'Published Events',
                style: GoogleFonts.poppins(
                  color: eventsBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('events')
                .orderBy('createdAt', descending: true)
                .limit(3)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[600], size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Error loading events',
                        style: GoogleFonts.poppins(color: Colors.red[600], fontSize: 12),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(accentTeal),
                      ),
                    ),
                  ),
                );
              }

              final events = snapshot.data?.docs ?? [];

              if (events.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, color: Colors.grey[400], size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'No events published yet. Create your first event!',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: events.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: accentTeal.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: accentTeal.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [accentTeal.withOpacity(0.15), accentTeal.withOpacity(0.08)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.event_rounded, color: accentTeal, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['eventName'] ?? 'Unknown Event',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: eventsBlue,
                                  letterSpacing: -0.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_rounded, size: 10, color: Colors.grey[500]),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatEventDate(data['eventDateTime']),
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green[400]!, Colors.green[500]!],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Live',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatEventDate(dynamic dateField) {
    try {
      DateTime date;
      
      if (dateField is Timestamp) {
        date = dateField.toDate();
      } else if (dateField is String) {
        date = DateTime.parse(dateField);
      } else {
        return 'Date not available';
      }

      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      String month = months[date.month - 1];
      
      return '${date.day} $month, ${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  Future<void> _addEventToFirebase() async {
    // Validation
    if (eventNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter event name', Colors.red);
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      _showSnackBar('Please enter event description', Colors.red);
      return;
    }
    if (selectedDateTime == null) {
      _showSnackBar('Please select date and time', Colors.red);
      return;
    }
    if (locationController.text.trim().isEmpty) {
      _showSnackBar('Please enter event location', Colors.red);
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      String currentTimestamp = _getCurrentTimestamp();
      
      // Create event data
      Map<String, dynamic> eventData = {
        'eventName': eventNameController.text.trim(),
        'description': descriptionController.text.trim(),
        'eventDateTime': selectedDateTime!.toIso8601String(),
        'location': locationController.text.trim(),
        'registrationLink': registrationLinkController.text.trim(),
        'publishedBy': 'NGO System',
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'publishedAt': DateTime.now().toUtc().toIso8601String(),
        'publishTimestamp': '$currentTimestamp UTC',
        'targetAudience': 'donors', // For Tejas2305 and other donors
      };

      // Add to Firestore
      DocumentReference docRef = await _firestore
          .collection('events')
          .add(eventData);

      setState(() {
        _isSubmitting = false;
      });

      // Show success dialog
      _showSuccessDialog(docRef.id, currentTimestamp);

    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });

      _showSnackBar('Error publishing event: $e', Colors.red);
    }
  }

  void _showSuccessDialog(String eventId, String timestamp) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green[400]!, Colors.green[500]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.check_circle_rounded, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              const Text("Event Published! 🎉"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Your event is now live for all donors!",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: eventsBlue, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[50]!, Colors.green[100]!],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("🆔 Event ID:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.green[700])),
                      Text(eventId, style: GoogleFonts.poppins(fontSize: 10, color: Colors.green[600], fontWeight: FontWeight.w500, letterSpacing: 0.3)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildDetailRow("🎯", "Event", eventNameController.text),
                _buildDetailRow("📅", "Date", "${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year}"),
                _buildDetailRow("🕐", "Time", "${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}"),
                _buildDetailRow("📍", "Location", locationController.text),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[50]!, Colors.blue[100]!],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.visibility_rounded, color: Colors.blue[600], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Tejas2305 and other donors will see this event in their 'Upcoming Events' page!",
                          style: GoogleFonts.poppins(color: Colors.blue[700], fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("⏰ Published: $timestamp UTC", 
                    style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600], letterSpacing: 0.5)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetForm();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: eventsBlue.withOpacity(0.1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("OK", style: GoogleFonts.poppins(color: eventsBlue, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$emoji ", style: const TextStyle(fontSize: 15)),
          SizedBox(
            width: 60,
            child: Text("$label:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.grey[700], fontSize: 13)),
          ),
          Expanded(child: Text(value, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[800]))),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      eventNameController.clear();
      descriptionController.clear();
      locationController.clear();
      registrationLinkController.clear();
      selectedDateTime = null;
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              color == Colors.red ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(message, style: GoogleFonts.poppins())),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    int maxLines = 1,
    double? height,
  }) {
    return Container(
      width: double.infinity,
      height: height ?? 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: eventsBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: eventsBlue, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              style: GoogleFonts.poppins(
                color: const Color(0xFF333333),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF999999),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.only(top: maxLines > 1 ? 8 : 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeField(BuildContext context) {
    String text = selectedDateTime == null
        ? 'Select Date & Time'
        : '${selectedDateTime!.day.toString().padLeft(2, '0')}/${selectedDateTime!.month.toString().padLeft(2, '0')}/${selectedDateTime!.year}   ${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () async {
        DateTime now = DateTime.now();
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: selectedDateTime ?? now,
          firstDate: now,
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(),
                colorScheme: ColorScheme.light(
                  primary: eventsBlue,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: selectedDateTime != null
                ? TimeOfDay(hour: selectedDateTime!.hour, minute: selectedDateTime!.minute)
                : TimeOfDay.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  textTheme: GoogleFonts.poppinsTextTheme(),
                  colorScheme: ColorScheme.light(
                    primary: eventsBlue,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (time != null) {
            setState(() {
              selectedDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
            });
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: selectedDateTime == null ? Colors.grey[300]! : accentTeal.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (selectedDateTime == null ? eventsBlue : accentTeal).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.calendar_today_rounded,
                color: selectedDateTime == null ? eventsBlue : accentTeal,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  color: selectedDateTime == null ? const Color(0xFF999999) : const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: selectedDateTime == null ? FontWeight.w400 : FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.grey[500],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    eventNameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    registrationLinkController.dispose();
    super.dispose();
  }
}