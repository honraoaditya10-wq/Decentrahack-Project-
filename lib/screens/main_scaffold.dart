import 'package:flutter/material.dart';
import 'donor_home_screen.dart';
import 'donate_food_screen.dart';
import 'donate_clothes_screen.dart';
import 'donate_books_screen.dart';
import 'profile_screen.dart'; 
import 'notification_screen.dart';
import 'your_donation.dart'; 
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  
  int _selectedIndex = 0;

  int _donationPage = -1;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
      _donationPage = -1;
    });
  }

  void _openDonationScreen(int screenIndex) {
    setState(() {
      _selectedIndex = 0; 
      _donationPage = screenIndex;
    });
  }

  void _backToHomeFromDonation() {
    setState(() {
      _donationPage = -1;
    });
  }

  Widget get _body {

    if (_selectedIndex == 0 && _donationPage == 0) {
      return DonateFoodScreen(
        selectedIndex: 0,
        onNavTap: (_) => _backToHomeFromDonation(),
      );
    }
    if (_selectedIndex == 0 && _donationPage == 1) {
      return DonateClothesScreen(
        selectedIndex: 0,
        onNavTap: (_) => _backToHomeFromDonation(),
      );
    }
    if (_selectedIndex == 0 && _donationPage == 2) {
      return DonateBooksScreen(
        selectedIndex: 0,
        onNavTap: (_) => _backToHomeFromDonation(),
      );
    }
    
    if (_selectedIndex == 0) {
      return HomePage(onDonationOptionTap: _openDonationScreen);
    }
    
    if (_selectedIndex == 1) {
      return const DonationHistoryScreen(); 
    }
    if (_selectedIndex == 2) {
      return const NotificationScreen();
    }
    if (_selectedIndex == 3) {
      return const ProfileScreen();
    }
    return Center(child: Text("Tab $_selectedIndex"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: WasteNotNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavTap,
      ),
    );
  }
}


class WasteNotNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  const WasteNotNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF2E1FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, "Home", 0),
          _buildNavItem(Icons.volunteer_activism, "Donations", 1), 
          _buildNavItem(Icons.person_outline, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.deepPurple,
              size: 28,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}