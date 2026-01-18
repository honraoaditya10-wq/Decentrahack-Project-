import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'donate_feedback.dart';
import 'notification_screen.dart';
import 'your_donation.dart';
import 'donatation_guidlines.dart';
import 'help_center_screen.dart';
import 'donation_reminder_screen.dart';
import 'upcoming_event_screen.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userDisplayName = "Tejas2305";
  String _userEmail = "tejas2305@example.com";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String email = currentUser.email ?? "";
      String displayName = currentUser.displayName ?? "";
      
      setState(() {
        _userEmail = email;
        if (displayName.isNotEmpty) {
          _userDisplayName = displayName;
        } else if (email.isNotEmpty) {
          _userDisplayName = email.split('@')[0];
        } else {
          _userDisplayName = "Tejas2305";
        }
      });
    }
  }

  Future<void> _handleLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await _auth.signOut();
                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error logging out: $e')),
                    );
                  }
                }
              },
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _handleNavigation(String tileText) {
    switch (tileText) {
      case 'My donation':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DonationHistoryScreen()),
        );
        break;
      case 'Donation reminder':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DonationReminderPage()),
        );
        break;
      case 'Change password':
        _showChangePasswordDialog();
        break;
      case 'Settings':
        _showSettingsDialog();
        break;
      case 'Notifications':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationScreen()),
        );
        break;
      case 'Help Center':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HelpCenterScreen()),
        );
        break;
      case 'Feedback':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeedbackPage()),
        );
        break;
      case 'Log Out':
        _handleLogout();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$tileText feature coming soon!')),
        );
    }
  }

  void _showChangePasswordDialog() {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;
  String? errorTextCurrent;
  String? errorTextNew;
  String? errorTextConfirm;
  bool isLoading = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool validate() {
            errorTextCurrent = currentPasswordController.text.isEmpty ? 'Enter current password' : null;
            errorTextNew = (newPasswordController.text.length < 6) ? 'Password must be at least 6 chars' : null;
            errorTextConfirm = (newPasswordController.text != confirmPasswordController.text) ? 'Passwords do not match' : null;
            return errorTextCurrent == null && errorTextNew == null && errorTextConfirm == null;
          }

          return AlertDialog(
            title: const Text('Change Password'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: currentPasswordController,
                    obscureText: obscureCurrent,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      border: const OutlineInputBorder(),
                      errorText: errorTextCurrent,
                      suffixIcon: IconButton(
                        icon: Icon(obscureCurrent ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => obscureCurrent = !obscureCurrent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: newPasswordController,
                    obscureText: obscureNew,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: const OutlineInputBorder(),
                      errorText: errorTextNew,
                      suffixIcon: IconButton(
                        icon: Icon(obscureNew ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => obscureNew = !obscureNew),
                      ),
                    ),
                    onChanged: (_) => setState(() => validate()),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: obscureConfirm,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      border: const OutlineInputBorder(),
                      errorText: errorTextConfirm,
                      suffixIcon: IconButton(
                        icon: Icon(obscureConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => obscureConfirm = !obscureConfirm),
                      ),
                    ),
                    onChanged: (_) => setState(() => validate()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: isLoading || !validate()
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          User? user = _auth.currentUser;
                          if (user != null) {
                            final cred = EmailAuthProvider.credential(
                              email: user.email!,
                              password: currentPasswordController.text,
                            );
                            await user.reauthenticateWithCredential(cred);
                            await user.updatePassword(newPasswordController.text);
                            if (mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password updated successfully')),
                              );
                            }
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error updating password: $e')),
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                child: isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Update'),
              ),
            ],
          );
        },
      );
    },
  );
}


  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notification Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Donation Guidelines'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonationGuidelinesScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Upcoming Events'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpcomingEventsScreen()),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProfileDialog() {
    final TextEditingController nameController = TextEditingController(text: _userDisplayName);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Email: $_userEmail',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  User? user = _auth.currentUser;
                  if (user != null) {
                    await user.updateDisplayName(nameController.text);
                    setState(() {
                      _userDisplayName = nameController.text;
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated successfully')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating profile: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFF3EBFD);
    const Color headingColor = Color(0xFF6F3FAF);
    const double headerHeight = 60;
    const double navBarHeight = 70;
    const double sidePadding = 18;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double availableHeight = screenHeight -
        headerHeight -
        navBarHeight -
        MediaQuery.of(context).padding.top;

    final double whiteContainerHeight = availableHeight;

    final List<_ProfileTileData> tiles = [
      _ProfileTileData(
        assetIconPath: 'assets/Images/heart.png',
        text: 'My donation',
      ),
      _ProfileTileData(
        assetIconPath: 'assets/Images/bell.png',
        text: 'Donation reminder',
      ),
      _ProfileTileData(
        assetIconPath: 'assets/Images/key.png',
        text: 'Change password',
      ),
      _ProfileTileData(
        assetIconPath: 'assets/Images/setting.png',
        text: 'Settings',
      ),
      _ProfileTileData(
        assetIconPath: 'assets/Images/bell.png',
        text: 'Notifications',
      ),
      _ProfileTileData(
        assetIconPath: 'assets/Images/support.png',
        text: 'Help Center',
      ),
      _ProfileTileData(
        assetIconPath: 'assets/Images/feedback.png',
        text: 'Feedback',
      ),
      _ProfileTileData(
        assetIconPath: 'assets/Images/logout.png',
        text: 'Log Out',
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: headerHeight,
              color: backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: headingColor, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Account',
                      style: TextStyle(
                        color: headingColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: whiteContainerHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22),
                  bottom: Radius.circular(22),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: sidePadding),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFFEAEAEA),
                            width: 4,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor: Color(0xFFAB7DF6),
                          child: Text(
                            _userDisplayName.isNotEmpty ? _userDisplayName[0].toUpperCase() : 'T',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              _userDisplayName,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _userEmail,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF3EBFD),
                                  foregroundColor: Color(0xFFAB7DF6),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                ),
                                onPressed: _showEditProfileDialog,
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Color(0xFFAB7DF6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Divider(color: Colors.grey.shade200, thickness: 1),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double tileHeight = (constraints.maxHeight) / tiles.length;
                        if (tileHeight < 48) tileHeight = 48;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(tiles.length, (i) {
                            return SizedBox(
                              height: tileHeight,
                              child: _ProfileListTile(
                                assetIconPath: tiles[i].assetIconPath,
                                text: tiles[i].text,
                                onTap: () => _handleNavigation(tiles[i].text),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTileData {
  final String assetIconPath;
  final String text;
  _ProfileTileData({required this.assetIconPath, required this.text});
}

class _ProfileListTile extends StatelessWidget {
  final String assetIconPath;
  final String text;
  final VoidCallback? onTap;

  const _ProfileListTile({
    required this.assetIconPath,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Image.asset(
                assetIconPath,
                width: 26,
                height: 26,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback icon if image asset is not found
                  return Icon(
                    _getIconForText(text),
                    size: 26,
                    color: const Color(0xFFAB7DF6),
                  );
                },
              ),
              const SizedBox(width: 20),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForText(String text) {
    switch (text) {
      case 'My donation':
        return Icons.volunteer_activism;
      case 'Donation reminder':
        return Icons.notifications;
      case 'Change password':
        return Icons.lock;
      case 'Settings':
        return Icons.settings;
      case 'Notifications':
        return Icons.notifications_active;
      case 'Help Center':
        return Icons.help_center;
      case 'Feedback':
        return Icons.feedback;
      case 'Log Out':
        return Icons.logout;
      default:
        return Icons.circle;
    }
  }
}