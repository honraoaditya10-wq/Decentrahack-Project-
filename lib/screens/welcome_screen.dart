import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'main_scaffold.dart';
import 'donor_login_screen.dart';
import 'ngo/ngo_login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _iconAnimation;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _circleAnimation =
        Tween<double>(begin: -1, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _iconAnimation =
        Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeIn =
        CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEFDBF6), Color(0xFF9478B9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _circleAnimation,
          builder: (context, child) {
            return Positioned(
              top: 0 + 120 * _circleAnimation.value,
              left: -80.0,
              child: Opacity(
                opacity: 0.23,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0xFFB17CDF), Color(0x00B17CDF)],
                      radius: 1,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _circleAnimation,
          builder: (context, child) {
            return Positioned(
              bottom: -50 + 80 * _circleAnimation.value,
              right: -50,
              child: Opacity(
                opacity: 0.19,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0xFF772AB9), Color(0x00772AB9)],
                      radius: 1,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _circleAnimation,
          builder: (context, child) {
            return Positioned(
              top: 180 + 40 * _circleAnimation.value,
              left: -60,
              child: Opacity(
                opacity: 0.13,
                child: Transform.rotate(
                  angle: math.pi / 12,
                  child: Container(
                    width: 260,
                    height: 120,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF5C2C9C), Color(0x00B17CDF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        bottomRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        topRight: Radius.circular(80),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _animatedLogo() {
    return ScaleTransition(
      scale: _iconAnimation,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFB17CDF), Color(0xFF772AB9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Icon(
          Icons.volunteer_activism,
          color: Colors.white,
          size: 52,
          shadows: [
            Shadow(
              color: Color(0xFFB17CDF).withOpacity(0.22),
              blurRadius: 12,
              offset: Offset(0, 8),
            )
          ],
        ),
      ),
    );
  }

  Widget _animatedCard(BuildContext context) {
    return FadeTransition(
      opacity: _fadeIn,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.97),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB17CDF).withOpacity(0.13),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              "Get Started",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF772AB9),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Choose your role to make a difference",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // Donor Button
            _GradientButton(
              icon: Icons.volunteer_activism,
              text: "Login As Donor\nI Want to Donate",
              gradientColors: const [Color(0xFFB17CDF), Color(0xFF772AB9)],
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),

            const SizedBox(height: 14),

            // NGO Button
            _GradientButton(
              icon: Icons.apartment,
              text: "Login As NGO\nWe Need Donations",
              gradientColors: const [Color(0xFF3674B5), Color(0xFF18334F)],
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NGOLoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedTitle() {
    return FadeTransition(
      opacity: _fadeIn,
      child: Column(
        children: [
          Text(
            "Welcome to WasteNot",
            style: TextStyle(
              color: const Color(0xFF5C2C9C),
              fontWeight: FontWeight.w900,
              fontSize: 32,
              letterSpacing: 1.1,
              shadows: [
                Shadow(
                  color: const Color(0xFF9478B9).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(1, 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            "Together, we save and share",
            style: TextStyle(
              color: Color(0xFF9478B9),
              fontWeight: FontWeight.w500,
              fontSize: 15.5,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          _animatedBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: mq.size.height * 0.08),
                    _animatedLogo(),
                    const SizedBox(height: 22),
                    _animatedTitle(),
                    SizedBox(height: mq.size.height * 0.04),
                    _animatedCard(context),
                    SizedBox(height: mq.size.height * 0.07),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  const _GradientButton({
    required this.icon,
    required this.text,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 23),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
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