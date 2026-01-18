// // import 'package:flutter/material.dart';
// // import 'dart:math';

// // class UpcomingEventsScreen extends StatefulWidget {
// //   @override
// //   _UpcomingEventsScreenState createState() => _UpcomingEventsScreenState();
// // }

// // class _UpcomingEventsScreenState extends State<UpcomingEventsScreen> with SingleTickerProviderStateMixin {
// //   final List<Map<String, dynamic>> events = [
// //     {
// //       "title": "Food Donation Camp",
// //       "date": "June 12, 2025",
// //       "time": "10:00 AM - 4:00 PM",
// //       "location": "Community Center",
// //       "icon": Icons.volunteer_activism,
// //       "color": Color(0xFFB17CDF),
// //       "description": "Join us in making a difference by donating food to those in need."
// //     },
// //     {
// //       "title": "Waste Management Seminar",
// //       "date": "July 8, 2025",
// //       "time": "2:00 PM - 5:00 PM",
// //       "location": "City Hall Auditorium",
// //       "icon": Icons.recycling,
// //       "color": Color(0xFF772AB9),
// //       "description": "Learn about sustainable waste management practices for our community."
// //     },
// //     {
// //       "title": "Community Awareness Drive",
// //       "date": "August 18, 2025",
// //       "time": "9:00 AM - 6:00 PM",
// //       "location": "Central Square",
// //       "icon": Icons.campaign,
// //       "color": Color(0xFF9478B9),
// //       "description": "Spreading awareness about important social issues in our neighborhood."
// //     },
// //   ];

// //   late AnimationController _controller;
// //   late Animation<double> _waveAnim;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = AnimationController(
// //       duration: Duration(seconds: 2),
// //       vsync: this,
// //     )..repeat(reverse: true);
// //     _waveAnim = Tween<double>(begin: 0, end: 2 * pi).animate(
// //       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   // Fixed opacity values to ensure they stay within 0.0-1.0 range
// //   double _clampOpacity(double value) {
// //     return value.clamp(0.0, 1.0);
// //   }

// //   Widget _animatedBackground(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: _waveAnim,
// //       builder: (context, child) {
// //         return Stack(
// //           children: [
// //             Container(
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [Color(0xFFEFDBF6), Color(0xFF9478B9)],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //               ),
// //             ),
// //             Positioned(
// //               top: 0,
// //               left: 0,
// //               right: 0,
// //               child: CustomPaint(
// //                 painter: _WavyPainter(_waveAnim.value),
// //                 child: Container(height: 120),
// //               ),
// //             ),
// //             Positioned(
// //               bottom: -30 + 10 * sin(_waveAnim.value),
// //               right: -60,
// //               child: Container(
// //                 width: 120,
// //                 height: 120,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: Color(0xFF772AB9).withOpacity(_clampOpacity(0.13)),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color(0xFFEFDBF6),
// //       appBar: AppBar(
// //         title: Text(
// //           "Upcoming Events",
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             fontSize: 24,
// //             color: Color(0xFF5C2C9C),
// //             letterSpacing: 1,
// //           ),
// //         ),
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         centerTitle: true,
// //         foregroundColor: Color(0xFF5C2C9C),
// //       ),
// //       extendBodyBehindAppBar: true,
// //       body: Stack(
// //         children: [
// //           _animatedBackground(context),
// //           Padding(
// //             padding: EdgeInsets.only(top: 100.0, left: 16, right: 16, bottom: 16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Current Date and Time Display
// //                 Container(
// //                   padding: EdgeInsets.all(16),
// //                   margin: EdgeInsets.only(bottom: 16),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white.withOpacity(_clampOpacity(0.9)),
// //                     borderRadius: BorderRadius.circular(16),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Color(0xFF9478B9).withOpacity(_clampOpacity(0.2)),
// //                         blurRadius: 10,
// //                         offset: Offset(0, 4),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Icon(Icons.access_time, color: Color(0xFF5C2C9C), size: 18),
// //                       SizedBox(width: 8),
// //                       Text(
// //                         "Current Time: 2025-08-25 04:20:11 UTC",
// //                         style: TextStyle(
// //                           color: Color(0xFF5C2C9C),
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.w600,
// //                           fontFamily: 'monospace',
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Text(
// //                   "Don't miss out on these amazing events!",
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     color: Color(0xFF9478B9),
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),
// //                 Expanded(
// //                   child: ListView.builder(
// //                     physics: BouncingScrollPhysics(),
// //                     itemCount: events.length,
// //                     itemBuilder: (context, index) {
// //                       final event = events[index];
// //                       return TweenAnimationBuilder<double>(
// //                         tween: Tween(begin: 0, end: 1),
// //                         duration: Duration(milliseconds: 700 + index * 200),
// //                         curve: Curves.easeOutBack,
// //                         builder: (context, value, child) {
// //                           return Opacity(
// //                             opacity: _clampOpacity(value),
// //                             child: Transform.translate(
// //                               offset: Offset(0, (1 - value) * 40),
// //                               child: child,
// //                             ),
// //                           );
// //                         },
// //                         child: Container(
// //                           margin: EdgeInsets.only(bottom: 16),
// //                           child: Card(
// //                             color: Colors.white,
// //                             elevation: 4,
// //                             shadowColor: event['color'].withOpacity(_clampOpacity(0.15)),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(24),
// //                             ),
// //                             child: InkWell(
// //                               borderRadius: BorderRadius.circular(24),
// //                               onTap: () {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   SnackBar(
// //                                     content: Text("Selected: ${event['title']}"),
// //                                     backgroundColor: event['color'],
// //                                     behavior: SnackBarBehavior.floating,
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(12),
// //                                     ),
// //                                   ),
// //                                 );
// //                               },
// //                               child: Padding(
// //                                 padding: EdgeInsets.all(20),
// //                                 child: Row(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Container(
// //                                       width: 60,
// //                                       height: 60,
// //                                       decoration: BoxDecoration(
// //                                         color: event['color'].withOpacity(_clampOpacity(0.18)),
// //                                         borderRadius: BorderRadius.circular(20),
// //                                       ),
// //                                       child: Icon(
// //                                         event['icon'],
// //                                         color: event['color'],
// //                                         size: 30,
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 18),
// //                                     Expanded(
// //                                       child: Column(
// //                                         crossAxisAlignment: CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(
// //                                             event['title'],
// //                                             style: TextStyle(
// //                                               fontSize: 19,
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Color(0xFF5C2C9C),
// //                                               letterSpacing: 0.5,
// //                                             ),
// //                                           ),
// //                                           SizedBox(height: 4),
// //                                           Row(
// //                                             children: [
// //                                               Icon(Icons.calendar_today, size: 15, color: Color(0xFF9478B9)),
// //                                               SizedBox(width: 4),
// //                                               Text(
// //                                                 event['date'],
// //                                                 style: TextStyle(
// //                                                   fontSize: 14,
// //                                                   color: Color(0xFF9478B9),
// //                                                   fontWeight: FontWeight.w500,
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                           SizedBox(height: 2),
// //                                           Row(
// //                                             children: [
// //                                               Icon(Icons.access_time, size: 15, color: Color(0xFF9478B9)),
// //                                               SizedBox(width: 4),
// //                                               Text(
// //                                                 event['time'],
// //                                                 style: TextStyle(
// //                                                   fontSize: 14,
// //                                                   color: Color(0xFFB17CDF),
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                           SizedBox(height: 2),
// //                                           Row(
// //                                             children: [
// //                                               Icon(Icons.location_on, size: 15, color: Color(0xFF9478B9)),
// //                                               SizedBox(width: 4),
// //                                               Text(
// //                                                 event['location'],
// //                                                 style: TextStyle(
// //                                                   fontSize: 14,
// //                                                   color: Color(0xFF9478B9),
// //                                                 ),
// //                                               ),
// //                                             ],
// //                                           ),
// //                                           SizedBox(height: 8),
// //                                           Text(
// //                                             event['description'],
// //                                             style: TextStyle(
// //                                               fontSize: 13,
// //                                               color: Color(0xFF5C2C9C),
// //                                               height: 1.3,
// //                                             ),
// //                                             maxLines: 2,
// //                                             overflow: TextOverflow.ellipsis,
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                     Icon(Icons.arrow_forward_ios, color: Color(0xFFB17CDF), size: 18),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       // Removed floatingActionButton completely
// //     );
// //   }
// // }

// // class _WavyPainter extends CustomPainter {
// //   final double waveValue;
// //   _WavyPainter(this.waveValue);

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final path = Path();
// //     final paint = Paint()
// //       ..shader = LinearGradient(
// //         colors: [Color(0xFFB17CDF), Color(0xFFEFDBF6)],
// //         begin: Alignment.topLeft,
// //         end: Alignment.bottomRight,
// //       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

// //     path.moveTo(0, size.height * 0.6);
// //     for (double x = 0; x <= size.width; x += 1) {
// //       path.lineTo(
// //         x,
// //         size.height * 0.6 +
// //             18 * sin((x / size.width * 2 * pi) + waveValue),
// //       );
// //     }
// //     path.lineTo(size.width, size.height);
// //     path.lineTo(0, size.height);
// //     path.close();

// //     canvas.drawPath(path, paint);
// //   }

// //   @override
// //   bool shouldRepaint(covariant _WavyPainter oldDelegate) {
// //     return oldDelegate.waveValue != waveValue;
// //   }
// // }


















// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math';

// class UpcomingEventsScreen extends StatefulWidget {
//   @override
//   _UpcomingEventsScreenState createState() => _UpcomingEventsScreenState();
// }

// class _UpcomingEventsScreenState extends State<UpcomingEventsScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _waveAnim;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String _getCurrentTimestamp() {
//     DateTime now = DateTime.now().toUtc();
//     return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);
//     _waveAnim = Tween<double>(begin: 0, end: 2 * pi).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   double _clampOpacity(double value) {
//     return value.clamp(0.0, 1.0);
//   }

//   Widget _animatedBackground(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _waveAnim,
//       builder: (context, child) {
//         return Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFEFDBF6), Color(0xFF9478B9)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: CustomPaint(
//                 painter: _WavyPainter(_waveAnim.value),
//                 child: Container(height: 120),
//               ),
//             ),
//             Positioned(
//               bottom: -30 + 10 * sin(_waveAnim.value),
//               right: -60,
//               child: Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color(0xFF772AB9).withOpacity(_clampOpacity(0.13)),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   IconData _getEventIcon(String eventName) {
//     String name = eventName.toLowerCase();
//     if (name.contains('food') || name.contains('donation')) {
//       return Icons.volunteer_activism;
//     } else if (name.contains('waste') || name.contains('recycle')) {
//       return Icons.recycling;
//     } else if (name.contains('awareness') || name.contains('community')) {
//       return Icons.campaign;
//     } else if (name.contains('education') || name.contains('seminar')) {
//       return Icons.school;
//     } else if (name.contains('health') || name.contains('medical')) {
//       return Icons.local_hospital;
//     } else {
//       return Icons.event;
//     }
//   }

//   Color _getEventColor(int index) {
//     List<Color> colors = [
//       Color(0xFFB17CDF),
//       Color(0xFF772AB9),
//       Color(0xFF9478B9),
//       Color(0xFF6A4C93),
//       Color(0xFF8E44AD),
//     ];
//     return colors[index % colors.length];
//   }

//   String _formatEventDateTime(dynamic dateTimeField) {
//     try {
//       DateTime dateTime;
      
//       if (dateTimeField is Timestamp) {
//         dateTime = dateTimeField.toDate();
//       } else if (dateTimeField is String) {
//         dateTime = DateTime.parse(dateTimeField);
//       } else {
//         return 'Date not available';
//       }

//       const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//       String month = months[dateTime.month - 1];
//       String day = dateTime.day.toString();
//       String year = dateTime.year.toString();
      
//       int hour12 = dateTime.hour == 0 ? 12 : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
//       String minute = dateTime.minute.toString().padLeft(2, '0');
//       String period = dateTime.hour >= 12 ? 'PM' : 'AM';
      
//       return {
//         'date': '$month $day, $year',
//         'time': '$hour12:$minute $period',
//       }['date']!;
//     } catch (e) {
//       return 'Date not available';
//     }
//   }

//   String _formatEventTime(dynamic dateTimeField) {
//     try {
//       DateTime dateTime;
      
//       if (dateTimeField is Timestamp) {
//         dateTime = dateTimeField.toDate();
//       } else if (dateTimeField is String) {
//         dateTime = DateTime.parse(dateTimeField);
//       } else {
//         return 'Time not available';
//       }

//       int hour12 = dateTime.hour == 0 ? 12 : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
//       String minute = dateTime.minute.toString().padLeft(2, '0');
//       String period = dateTime.hour >= 12 ? 'PM' : 'AM';
      
//       return '$hour12:$minute $period';
//     } catch (e) {
//       return 'Time not available';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEFDBF6),
//       appBar: AppBar(
//         title: Text(
//           "Upcoming Events",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//             color: Color(0xFF5C2C9C),
//             letterSpacing: 1,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         foregroundColor: Color(0xFF5C2C9C),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Center(
//               child: Text(
//                 "👋 Tejas2305",
//                 style: TextStyle(
//                   color: Color(0xFF5C2C9C),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           _animatedBackground(context),
//           Padding(
//             padding: EdgeInsets.only(top: 100.0, left: 16, right: 16, bottom: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Current Date and Time Display
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   margin: EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(_clampOpacity(0.9)),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xFF9478B9).withOpacity(_clampOpacity(0.2)),
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.access_time, color: Color(0xFF5C2C9C), size: 18),
//                           SizedBox(width: 8),
//                           Text(
//                             "Current Time: ${_getCurrentTimestamp()} UTC",
//                             style: TextStyle(
//                               color: Color(0xFF5C2C9C),
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'monospace',
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             "Live events from NGOs",
//                             style: TextStyle(
//                               color: Color(0xFF5C2C9C),
//                               fontSize: 11,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   "Don't miss out on these amazing events from NGOs!",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Color(0xFF9478B9),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: _firestore
//                         .collection('events')
//                         .where('status', isEqualTo: 'active')
//                         .orderBy('eventDateTime', descending: false)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Container(
//                             padding: EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               color: Colors.red[50],
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Colors.red[200]!),
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(Icons.error_outline, color: Colors.red[600], size: 48),
//                                 SizedBox(height: 12),
//                                 Text(
//                                   'Error loading events',
//                                   style: TextStyle(
//                                     color: Colors.red[700],
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   '${snapshot.error}',
//                                   style: TextStyle(color: Colors.red[600], fontSize: 12),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }

//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircularProgressIndicator(
//                                 valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5C2C9C)),
//                               ),
//                               SizedBox(height: 16),
//                               Text(
//                                 'Loading events from NGOs...',
//                                 style: TextStyle(
//                                   color: Color(0xFF9478B9),
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }

//                       final events = snapshot.data?.docs ?? [];

//                       if (events.isEmpty) {
//                         return Center(
//                           child: Container(
//                             padding: EdgeInsets.all(24),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(_clampOpacity(0.9)),
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color(0xFF9478B9).withOpacity(_clampOpacity(0.1)),
//                                   blurRadius: 10,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.event_busy,
//                                   size: 64,
//                                   color: Color(0xFF9478B9),
//                                 ),
//                                 SizedBox(height: 16),
//                                 Text(
//                                   'No Events Yet',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF5C2C9C),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'NGOs haven\'t published any events yet.\nCheck back later for exciting opportunities!',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Color(0xFF9478B9),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }

//                       return ListView.builder(
//                         physics: BouncingScrollPhysics(),
//                         itemCount: events.length,
//                         itemBuilder: (context, index) {
//                           final eventDoc = events[index];
//                           final eventData = eventDoc.data() as Map<String, dynamic>;
//                           final eventColor = _getEventColor(index);
                          
//                           return TweenAnimationBuilder<double>(
//                             tween: Tween(begin: 0, end: 1),
//                             duration: Duration(milliseconds: 700 + index * 200),
//                             curve: Curves.easeOutBack,
//                             builder: (context, value, child) {
//                               return Opacity(
//                                 opacity: _clampOpacity(value),
//                                 child: Transform.translate(
//                                   offset: Offset(0, (1 - value) * 40),
//                                   child: child,
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(bottom: 16),
//                               child: Card(
//                                 color: Colors.white,
//                                 elevation: 4,
//                                 shadowColor: eventColor.withOpacity(_clampOpacity(0.15)),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(24),
//                                 ),
//                                 child: InkWell(
//                                   borderRadius: BorderRadius.circular(24),
//                                   onTap: () {
//                                     _showEventDetails(eventData, eventColor);
//                                   },
//                                   child: Padding(
//                                     padding: EdgeInsets.all(20),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           width: 60,
//                                           height: 60,
//                                           decoration: BoxDecoration(
//                                             color: eventColor.withOpacity(_clampOpacity(0.18)),
//                                             borderRadius: BorderRadius.circular(20),
//                                           ),
//                                           child: Icon(
//                                             _getEventIcon(eventData['eventName'] ?? ''),
//                                             color: eventColor,
//                                             size: 30,
//                                           ),
//                                         ),
//                                         SizedBox(width: 18),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 eventData['eventName'] ?? 'Unknown Event',
//                                                 style: TextStyle(
//                                                   fontSize: 19,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color(0xFF5C2C9C),
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 4),
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.calendar_today, size: 15, color: Color(0xFF9478B9)),
//                                                   SizedBox(width: 4),
//                                                   Text(
//                                                     _formatEventDateTime(eventData['eventDateTime']),
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: Color(0xFF9478B9),
//                                                       fontWeight: FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 2),
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.access_time, size: 15, color: Color(0xFF9478B9)),
//                                                   SizedBox(width: 4),
//                                                   Text(
//                                                     _formatEventTime(eventData['eventDateTime']),
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: Color(0xFFB17CDF),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 2),
//                                               Row(
//                                                 children: [
//                                                   Icon(Icons.location_on, size: 15, color: Color(0xFF9478B9)),
//                                                   SizedBox(width: 4),
//                                                   Expanded(
//                                                     child: Text(
//                                                       eventData['location'] ?? 'Location TBA',
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                         color: Color(0xFF9478B9),
//                                                       ),
//                                                       maxLines: 1,
//                                                       overflow: TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 8),
//                                               Text(
//                                                 eventData['description'] ?? 'No description available',
//                                                 style: TextStyle(
//                                                   fontSize: 13,
//                                                   color: Color(0xFF5C2C9C),
//                                                   height: 1.3,
//                                                 ),
//                                                 maxLines: 2,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               SizedBox(height: 8),
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.green[100],
//                                                       borderRadius: BorderRadius.circular(8),
//                                                     ),
//                                                     child: Text(
//                                                       'Published by NGO',
//                                                       style: TextStyle(
//                                                         fontSize: 10,
//                                                         color: Colors.green[700],
//                                                         fontWeight: FontWeight.w600,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Icon(Icons.arrow_forward_ios, color: Color(0xFFB17CDF), size: 18),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showEventDetails(Map<String, dynamic> eventData, Color eventColor) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           title: Row(
//             children: [
//               Icon(_getEventIcon(eventData['eventName'] ?? ''), color: eventColor, size: 28),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   eventData['eventName'] ?? 'Event Details',
//                   style: TextStyle(color: Color(0xFF5C2C9C), fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: eventColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildDetailRow("📅", "Date", _formatEventDateTime(eventData['eventDateTime'])),
//                       _buildDetailRow("🕐", "Time", _formatEventTime(eventData['eventDateTime'])),
//                       _buildDetailRow("📍", "Location", eventData['location'] ?? 'TBA'),
//                       if (eventData['registrationLink']?.isNotEmpty == true)
//                         _buildDetailRow("🔗", "Registration", "Link provided"),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   "Description:",
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5C2C9C)),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   eventData['description'] ?? 'No description available',
//                   style: TextStyle(color: Color(0xFF5C2C9C)),
//                 ),
//                 SizedBox(height: 12),
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Text(
//                     "📢 This event was published by an NGO for community participation",
//                     style: TextStyle(fontSize: 10, color: Colors.blue[700]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text("Close", style: TextStyle(color: eventColor)),
//             ),
//             if (eventData['registrationLink']?.isNotEmpty == true)
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Registration link: ${eventData['registrationLink']}"),
//                       backgroundColor: eventColor,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: eventColor),
//                 child: Text("Register", style: TextStyle(color: Colors.white)),
//               ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildDetailRow(String emoji, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("$emoji ", style: const TextStyle(fontSize: 14)),
//           SizedBox(
//             width: 60,
//             child: Text("$label:", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700], fontSize: 13)),
//           ),
//           Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
//         ],
//       ),
//     );
//   }
// }

// class _WavyPainter extends CustomPainter {
//   final double waveValue;
//   _WavyPainter(this.waveValue);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final path = Path();
//     final paint = Paint()
//       ..shader = LinearGradient(
//         colors: [Color(0xFFB17CDF), Color(0xFFEFDBF6)],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

//     path.moveTo(0, size.height * 0.6);
//     for (double x = 0; x <= size.width; x += 1) {
//       path.lineTo(
//         x,
//         size.height * 0.6 +
//             18 * sin((x / size.width * 2 * pi) + waveValue),
//       );
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant _WavyPainter oldDelegate) {
//     return oldDelegate.waveValue != waveValue;
//   }
// }

































import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class UpcomingEventsScreen extends StatefulWidget {
  @override
  _UpcomingEventsScreenState createState() => _UpcomingEventsScreenState();
}

class _UpcomingEventsScreenState extends State<UpcomingEventsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnim;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getCurrentTimestamp() {
    DateTime now = DateTime.now().toUtc();
    return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _waveAnim = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _clampOpacity(double value) {
    return value.clamp(0.0, 1.0);
  }

  Widget _animatedBackground(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveAnim,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEFDBF6), Color(0xFF9478B9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                painter: _WavyPainter(_waveAnim.value),
                child: Container(height: 120),
              ),
            ),
            Positioned(
              bottom: -30 + 10 * sin(_waveAnim.value),
              right: -60,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF772AB9).withOpacity(_clampOpacity(0.13)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getEventIcon(String eventName) {
    String name = eventName.toLowerCase();
    if (name.contains('food') || name.contains('donation')) {
      return Icons.volunteer_activism;
    } else if (name.contains('waste') || name.contains('recycle')) {
      return Icons.recycling;
    } else if (name.contains('awareness') || name.contains('community')) {
      return Icons.campaign;
    } else if (name.contains('education') || name.contains('seminar')) {
      return Icons.school;
    } else if (name.contains('health') || name.contains('medical')) {
      return Icons.local_hospital;
    } else {
      return Icons.event;
    }
  }

  Color _getEventColor(int index) {
    List<Color> colors = [
      Color(0xFFB17CDF),
      Color(0xFF772AB9),
      Color(0xFF9478B9),
      Color(0xFF6A4C93),
      Color(0xFF8E44AD),
    ];
    return colors[index % colors.length];
  }

  String _formatEventDateTime(dynamic dateTimeField) {
    try {
      DateTime dateTime;
      
      if (dateTimeField is Timestamp) {
        dateTime = dateTimeField.toDate();
      } else if (dateTimeField is String) {
        dateTime = DateTime.parse(dateTimeField);
      } else {
        return 'Date not available';
      }

      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      String month = months[dateTime.month - 1];
      String day = dateTime.day.toString();
      String year = dateTime.year.toString();
      
      return '$month $day, $year';
    } catch (e) {
      return 'Date not available';
    }
  }

  String _formatEventTime(dynamic dateTimeField) {
    try {
      DateTime dateTime;
      
      if (dateTimeField is Timestamp) {
        dateTime = dateTimeField.toDate();
      } else if (dateTimeField is String) {
        dateTime = DateTime.parse(dateTimeField);
      } else {
        return 'Time not available';
      }

      int hour12 = dateTime.hour == 0 ? 12 : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
      String minute = dateTime.minute.toString().padLeft(2, '0');
      String period = dateTime.hour >= 12 ? 'PM' : 'AM';
      
      return '$hour12:$minute $period';
    } catch (e) {
      return 'Time not available';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFDBF6),
      appBar: AppBar(
        title: Text(
          "Upcoming Events",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF5C2C9C),
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Color(0xFF5C2C9C),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "👋 ",
                style: TextStyle(
                  color: Color(0xFF5C2C9C),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _animatedBackground(context),
          Padding(
            padding: EdgeInsets.only(top: 100.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Date and Time Display
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(_clampOpacity(0.9)),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF9478B9).withOpacity(_clampOpacity(0.2)),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time, color: Color(0xFF5C2C9C), size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Current Time: ${_getCurrentTimestamp()} UTC",
                            style: TextStyle(
                              color: Color(0xFF5C2C9C),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Live events from NGOs",
                            style: TextStyle(
                              color: Color(0xFF5C2C9C),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  "Don't miss out on these amazing events from NGOs!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9478B9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('events')
                        .where('status', isEqualTo: 'active')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red[200]!),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.error_outline, color: Colors.red[600], size: 48),
                                SizedBox(height: 12),
                                Text(
                                  'Error loading events',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Please check your internet connection',
                                  style: TextStyle(color: Colors.red[600], fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5C2C9C)),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Loading events from NGOs...',
                                style: TextStyle(
                                  color: Color(0xFF9478B9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      // Get events and sort them manually
                      final allEvents = snapshot.data?.docs ?? [];
                      
                      // Filter active events and sort by date
                      final activeEvents = allEvents.where((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return data['status'] == 'active';
                      }).toList();

                      // Sort events by date manually
                      activeEvents.sort((a, b) {
                        final aData = a.data() as Map<String, dynamic>;
                        final bData = b.data() as Map<String, dynamic>;
                        
                        try {
                          DateTime aDate = DateTime.parse(aData['eventDateTime'] ?? '');
                          DateTime bDate = DateTime.parse(bData['eventDateTime'] ?? '');
                          return aDate.compareTo(bDate);
                        } catch (e) {
                          return 0;
                        }
                      });

                      if (activeEvents.isEmpty) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(_clampOpacity(0.9)),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF9478B9).withOpacity(_clampOpacity(0.1)),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.event_busy,
                                  size: 64,
                                  color: Color(0xFF9478B9),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No Events Yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5C2C9C),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'NGOs haven\'t published any events yet.\nCheck back later for exciting opportunities!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9478B9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: activeEvents.length,
                        itemBuilder: (context, index) {
                          final eventDoc = activeEvents[index];
                          final eventData = eventDoc.data() as Map<String, dynamic>;
                          final eventColor = _getEventColor(index);
                          
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: Duration(milliseconds: 700 + index * 200),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: _clampOpacity(value),
                                child: Transform.translate(
                                  offset: Offset(0, (1 - value) * 40),
                                  child: child,
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Card(
                                color: Colors.white,
                                elevation: 4,
                                shadowColor: eventColor.withOpacity(_clampOpacity(0.15)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(24),
                                  onTap: () {
                                    _showEventDetails(eventData, eventColor);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: eventColor.withOpacity(_clampOpacity(0.18)),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Icon(
                                            _getEventIcon(eventData['eventName'] ?? ''),
                                            color: eventColor,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(width: 18),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                eventData['eventName'] ?? 'Unknown Event',
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF5C2C9C),
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.calendar_today, size: 15, color: Color(0xFF9478B9)),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    _formatEventDateTime(eventData['eventDateTime']),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF9478B9),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Icon(Icons.access_time, size: 15, color: Color(0xFF9478B9)),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    _formatEventTime(eventData['eventDateTime']),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFFB17CDF),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Icon(Icons.location_on, size: 15, color: Color(0xFF9478B9)),
                                                  SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      eventData['location'] ?? 'Location TBA',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF9478B9),
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                eventData['description'] ?? 'No description available',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF5C2C9C),
                                                  height: 1.3,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[100],
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Text(
                                                      'Published by NGO',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.green[700],
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios, color: Color(0xFFB17CDF), size: 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(Map<String, dynamic> eventData, Color eventColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(_getEventIcon(eventData['eventName'] ?? ''), color: eventColor, size: 28),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  eventData['eventName'] ?? 'Event Details',
                  style: TextStyle(color: Color(0xFF5C2C9C), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: eventColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("📅", "Date", _formatEventDateTime(eventData['eventDateTime'])),
                      _buildDetailRow("🕐", "Time", _formatEventTime(eventData['eventDateTime'])),
                      _buildDetailRow("📍", "Location", eventData['location'] ?? 'TBA'),
                      if (eventData['registrationLink']?.isNotEmpty == true)
                        _buildDetailRow("🔗", "Registration", "Link provided"),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5C2C9C)),
                ),
                SizedBox(height: 4),
                Text(
                  eventData['description'] ?? 'No description available',
                  style: TextStyle(color: Color(0xFF5C2C9C)),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "📢 This event was published by an NGO for community participation",
                    style: TextStyle(fontSize: 10, color: Colors.blue[700]),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close", style: TextStyle(color: eventColor)),
            ),
            if (eventData['registrationLink']?.isNotEmpty == true)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Registration link: ${eventData['registrationLink']}"),
                      backgroundColor: eventColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: eventColor),
                child: Text("Register", style: TextStyle(color: Colors.white)),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$emoji ", style: const TextStyle(fontSize: 14)),
          SizedBox(
            width: 60,
            child: Text("$label:", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700], fontSize: 13)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class _WavyPainter extends CustomPainter {
  final double waveValue;
  _WavyPainter(this.waveValue);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFFB17CDF), Color(0xFFEFDBF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    path.moveTo(0, size.height * 0.6);
    for (double x = 0; x <= size.width; x += 1) {
      path.lineTo(
        x,
        size.height * 0.6 +
            18 * sin((x / size.width * 2 * pi) + waveValue),
      );
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavyPainter oldDelegate) {
    return oldDelegate.waveValue != waveValue;
  }
}