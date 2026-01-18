import 'package:flutter/material.dart';
import 'donatation_guidlines.dart'; // Import the donation guidelines screen
import 'contact_and_support.dart'; // Import contact and support screen
import 'special_days.dart'; // Import special days screen
import 'upcoming_event_screen.dart'; // Import upcoming events screen
import 'featured_ngo.dart'; // Import featured NGOs screen
import 'your_donation.dart'; // Import donation history screen
import 'profile_screen.dart';
import 'main_scaffold.dart';
import 'floating_chatbot_button.dart';


// Main HomePage 
class HomePage extends StatefulWidget {
  final void Function(int donationIndex) onDonationOptionTap;
  const HomePage({super.key, required this.onDonationOptionTap});

  // Static method to navigate to donation history from anywhere (including navbar)
  static void navigateToDonationHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DonationHistoryScreen()),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedSlide = 0;
  PageController slideController = PageController();

  final List<SlideData> slides = [
    SlideData(
      title:
          "Your unused clothes can bring warmth, dignity, and hope to someone in need",
      imagePath: "assets/Images/home_slide1.png",
    ),
    SlideData(
      title:
          "Share your extra meals and bring happiness to hungry hearts in your community",
      imagePath: "assets/Images/home_slide2.png",
    ),
    SlideData(
      title:
          "Give the gift of knowledge and open new worlds for someone eager to learn",
      imagePath: "assets/Images/home_slide3.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        setState(() {
          selectedSlide = (selectedSlide + 1) % slides.length;
        });
        slideController.animateToPage(
          selectedSlide,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildSlidingCards(),
                      const SizedBox(height: 16),
                      _buildSlideIndicators(),
                      const SizedBox(height: 24),
                      _buildDonationsCard(),
                      const SizedBox(height: 32),
                      _buildDonationOptions(),
                      const SizedBox(height: 32),
                      _buildDonorHighlights(context),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const FloatingChatBot(), // Floating chatbot button
      ],
    );
  }

  /// ------------------ HEADER -------------------
  Widget _buildHeader() {
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFFF2E6FF),
    ),
    child: Column(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "WasteNot",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Shadow(
                        offset: const Offset(0, 0),
                        blurRadius: 15,
                        color: Colors.deepPurple.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB991E3).withOpacity(0.6),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: const Color(0xFFB991E3).withOpacity(0.3),
                          blurRadius: 25,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFB991E3),
                      child: Icon(Icons.person, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 32,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
      ],
    ),
  );
}

  /// ------------------ SLIDING CARDS -------------------
  Widget _buildSlidingCards() {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: slideController,
        itemCount: slides.length,
        onPageChanged: (index) {
          setState(() {
            selectedSlide = index;
          });
        },
        itemBuilder: (context, index) {
          final slide = slides[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: const Color(0xFF8276CB),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset(
                    slide.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slide.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          "DONATE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ------------------ SLIDE INDICATORS -------------------
  Widget _buildSlideIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(slides.length, (index) {
        return GestureDetector(
          onTap: () {
            slideController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
            setState(() {
              selectedSlide = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: selectedSlide == index ? 16 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: selectedSlide == index
                  ? Colors.deepPurple
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }),
    );
  }

  /// ------------------ DONATION CARD -------------------
  Widget _buildDonationsCard() {
    return GestureDetector(
      onTap: () {
        HomePage.navigateToDonationHistory(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.deepPurple, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Donations",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You've donated 3 out of 5 times this month! Keep spreading the love !!",
                    style: TextStyle(
                      color: Colors.deepPurple.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    "assets/Images/home_slide4.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.deepPurple,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------ DONATION OPTIONS -------------------
  Widget _buildDonationOptions() {
    final options = [
      {"icon": "assets/Images/food_donatation.png", "label": "FOOD"},
      {"icon": "assets/Images/cloth_donatation.png", "label": "CLOTH"},
      {"icon": "assets/Images/book_donatation.png", "label": "BOOK"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Donation Options",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: List.generate(options.length, (i) {
            final option = options[i];
            return Expanded(
              child: GestureDetector(
                onTap: () => widget.onDonationOptionTap(i),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black12, width: 1.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        child: Image.asset(
                          option["icon"]!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9B6DE8),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.22),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            option["label"]!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// ------------------ DONOR HIGHLIGHTS -------------------
  Widget _buildDonorHighlights(BuildContext context) {
    final highlights = [
      {
        "icon": "assets/Images/special_days.png",
        "title": "Special Days",
        "subtitle": "Donate more on special occasions",
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SpecialDaysScreen()),
          );
        },
      },
      {
        "icon": "assets/Images/upcoming_event.png",
        "title": "Upcoming Events",
        "subtitle": "Explore new events at NGOs",
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpcomingEventsScreen()),
          );
        },
      },
      {
        "icon": "assets/Images/customer-service.png",
        "title": "Contact & Support",
        "subtitle": "Get help when you need it",
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactSupportScreen()),
          );
        },
      },
      {
        "icon": "assets/Images/featurede_ngo.png",
        "title": "Featured NGOs",
        "subtitle": "View details about top NGOs",
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeaturedNGOsPage()),
          );
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Donor Highlights",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            // Special Days
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildHighlightCard(
                iconPath: highlights[0]["icon"] as String,
                title: highlights[0]["title"] as String,
                subtitle: highlights[0]["subtitle"] as String,
                onTap: highlights[0]["onTap"] as VoidCallback,
              ),
            ),
            // Upcoming Events
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildHighlightCard(
                iconPath: highlights[1]["icon"] as String,
                title: highlights[1]["title"] as String,
                subtitle: highlights[1]["subtitle"] as String,
                onTap: highlights[1]["onTap"] as VoidCallback,
              ),
            ),
            // Contact & Support
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildHighlightCard(
                iconPath: highlights[2]["icon"] as String,
                title: highlights[2]["title"] as String,
                subtitle: highlights[2]["subtitle"] as String,
                onTap: highlights[2]["onTap"] as VoidCallback,
              ),
            ),
            // Featured NGOs
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildHighlightCard(
                iconPath: highlights[3]["icon"] as String,
                title: highlights[3]["title"] as String,
                subtitle: highlights[3]["subtitle"] as String,
                onTap: highlights[3]["onTap"] as VoidCallback,
              ),
            ),
            // Donation Guidelines
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildHighlightCard(
                iconPath: "assets/Images/guidelines.png",
                title: "Donation Guidelines",
                subtitle: "Read our donation guidelines",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DonationGuidelinesScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighlightCard({
    required String iconPath,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF9B6DE8),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              SizedBox(
                height: 38,
                width: 38,
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.black, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------ SLIDE DATA MODEL -------------------
class SlideData {
  final String title;
  final String imagePath;
  SlideData({required this.title, required this.imagePath});
}