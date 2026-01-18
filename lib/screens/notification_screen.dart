import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFF3EBFD);
    const Color headingColor = Color(0xFF6F3FAF);
    const double headerHeight = 106;

    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Food Donation Sent',
        'description': 'You donated 10 food packets to Helping Hands.',
        'date': 'Oct 6, 2025',
        'icon': Icons.favorite_rounded,
        'color': Color(0xFF7E55D8),
      },
      {
        'title': 'Food Donation Received',
        'description': 'Your food parcel was received by Feeding India.',
        'date': 'Oct 4, 2025',
        'icon': Icons.check_circle_rounded,
        'color': Color(0xFF8B5FE8),
      },
      {
        'title': 'Food Pickup Scheduled',
        'description': 'Your food pickup is scheduled for tomorrow at 11 AM.',
        'date': 'Oct 3, 2025',
        'icon': Icons.schedule_rounded,
        'color': Color(0xFF9C6FF5),
      },
      {
        'title': 'Volunteer Request Accepted',
        'description': 'You will help distribute surplus food in your area.',
        'date': 'Oct 2, 2025',
        'icon': Icons.volunteer_activism_rounded,
        'color': Color(0xFFAA80FF),
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header section with gradient
            Container(
              height: headerHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    backgroundColor,
                    Color(0xFFE8DAFB),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8)
                  .copyWith(top: 18, bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Notifications',
                          style: TextStyle(
                            color: headingColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                            letterSpacing: 0.2,
                            height: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Stay updated with your food donations',
                          style: TextStyle(
                            color: headingColor.withOpacity(0.6),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            // Notification list area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(36),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x18000000),
                      blurRadius: 20,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: 80,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No notifications yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 4,
                        ),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) => NotificationCard(
                          title: notifications[index]['title']!,
                          description: notifications[index]['description']!,
                          date: notifications[index]['date']!,
                          icon: notifications[index]['icon']!,
                          iconColor: notifications[index]['color']!,
                          backgroundColor: backgroundColor,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.15),
            blurRadius: 15,
            offset: Offset(0, 6),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle notification tap
          },
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container with gradient
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        iconColor.withOpacity(0.2),
                        iconColor.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: iconColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                          height: 1.3,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.grey[700],
                          height: 1.4,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            date,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Small dot indicator
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}