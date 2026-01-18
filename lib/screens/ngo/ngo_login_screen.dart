import 'package:flutter/material.dart';
import '../welcome_screen.dart';
import 'ngo_home_page.dart'; // <-- Make sure this matches your file name!

class NGOLoginPage extends StatefulWidget {
  const NGOLoginPage({super.key});

  @override
  State<NGOLoginPage> createState() => _NGOLoginPageState();
}

class _NGOLoginPageState extends State<NGOLoginPage> {
  // Removed tempEmail and tempPassword

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorText;

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    // Theme constants, similar to donor login (with darker textfields/colors)
    const Color mainBlue = Color(0xFF3674B5);
    const Color fieldBlue = Color(0xFF225277);
    const Color bgLight = Color(0xFF88BCD9);
    const Color gradientStrong = Color(0xFF3674B5);
    const Color fillColor = Color(0xFFDBE6EF);
    const Color textColor = Color(0xFF192A38);
    const Color hintTextColor = Color(0xFF3B4F66);

    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: gradientStrong),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [bgLight, gradientStrong],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to WasteNot",
                    style: TextStyle(
                      color: mainBlue,
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Together, we save and share",
                    style: TextStyle(
                      color: fieldBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: mainBlue.withOpacity(0.14),
                          blurRadius: 30,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Login as NGO",
                          style: TextStyle(
                            color: mainBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Access your account to keep spreading hope\nand kindness.",
                          style: TextStyle(
                            color: fieldBlue,
                            fontSize: 13.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),

                        // Email Field
                        _ThemedTextField(
                          label: "Email Address",
                          hint: "Enter Your Email",
                          icon: Icons.email_outlined,
                          color: fieldBlue,
                          fillColor: fillColor,
                          textColor: textColor,
                          hintTextColor: hintTextColor,
                          borderColor: fieldBlue,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 13),

                        // Password Field
                        _ThemedTextField(
                          label: "Password",
                          hint: "Enter Your Password",
                          icon: Icons.lock_outline,
                          color: fieldBlue,
                          fillColor: fillColor,
                          textColor: textColor,
                          hintTextColor: hintTextColor,
                          borderColor: fieldBlue,
                          controller: _passwordController,
                          obscure: _obscurePassword,
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility,
                              color: fieldBlue,
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        if (_errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              _errorText!,
                              style: const TextStyle(color: Colors.red, fontSize: 13),
                            ),
                          ),

                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () {
                              setState(() {
                                _errorText = null;
                              });
                              // TODO: Replace with your actual NGO login validation
                              if (_emailController.text.trim().isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const NGODonationManagementHeader()),
                                );
                              } else {
                                setState(() {
                                  _errorText = "Invalid NGO email or password.";
                                });
                              }
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                letterSpacing: 0.7,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Temporary credentials card has been removed.
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemedTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final Color color;
  final Color fillColor;
  final Color textColor;
  final Color hintTextColor;
  final Color borderColor;
  final bool obscure;
  final Widget? suffix;
  final TextEditingController? controller;

  const _ThemedTextField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.color,
    required this.fillColor,
    required this.textColor,
    required this.hintTextColor,
    required this.borderColor,
    this.obscure = false,
    this.suffix,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 14.5,
          ),
        ),
        const SizedBox(height: 2),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            hintText: hint,
            hintStyle: TextStyle(color: hintTextColor),
            prefixIcon: Icon(icon, color: color),
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.4),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 2.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}