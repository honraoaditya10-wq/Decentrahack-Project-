// import 'package:flutter/material.dart';
// import 'main_scaffold.dart'; // Import MainScaffold for navigation

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//   bool _acceptTerms = false;

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   static const Color mainPurple = Color(0xFF5C2C9C);
//   static const Color fieldPurple = Color(0xFFB17CDF);
//   static const Color bgLight = Color(0xFFEFDBF6);
//   static const Color gradientOverlay = Color(0x669478B9);
//   static const Color gradientStrong = Color(0xFF9478B9);

//   void _handleSignUp() {
//     if (_formKey.currentState?.validate() ?? false) {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => const MainScaffold()),
//         (route) => false,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgLight,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               bgLight,
//               gradientStrong,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Text(
//                     "Welcome to WasteNot",
//                     style: TextStyle(
//                       color: mainPurple,
//                       fontWeight: FontWeight.w800,
//                       fontSize: 28,
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Together, we save and share",
//                     style: TextStyle(
//                       color: Color(0xFF9478B9),
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//                   const SizedBox(height: 26),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.90,
//                     padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: gradientStrong.withOpacity(0.14),
//                           blurRadius: 30,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Create Account",
//                             style: TextStyle(
//                               color: mainPurple,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 21,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           const Text(
//                             "Join us and start creating change",
//                             style: TextStyle(
//                               color: Color(0xFF9478B9),
//                               fontSize: 13.5,
//                             ),
//                           ),
//                           const SizedBox(height: 18),

//                           _ThemedTextField(
//                             label: "Name",
//                             hint: "Enter Your Name",
//                             icon: Icons.person_outline,
//                             color: fieldPurple,
//                             controller: _nameController,
//                           ),
//                           const SizedBox(height: 13),

//                           _ThemedTextField(
//                             label: "Email Address",
//                             hint: "Enter Your Email",
//                             icon: Icons.alternate_email,
//                             color: fieldPurple,
//                             controller: _emailController,
//                           ),
//                           const SizedBox(height: 13),

//                           _ThemedTextField(
//                             label: "Password",
//                             hint: "Enter Your Password",
//                             icon: Icons.lock_outline,
//                             color: fieldPurple,
//                             controller: _passwordController,
//                             obscure: _obscurePassword,
//                             suffix: IconButton(
//                               icon: Icon(
//                                 _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                 color: fieldPurple,
//                               ),
//                               onPressed: () => setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               }),
//                             ),
//                           ),
//                           const SizedBox(height: 12),

//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: _acceptTerms,
//                                 activeColor: mainPurple,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                                 onChanged: (val) => setState(() => _acceptTerms = val ?? false),
//                               ),
//                               Expanded(
//                                 child: RichText(
//                                   text: TextSpan(
//                                     text: "By signing up, you agree to our ",
//                                     style: const TextStyle(color: Colors.black87, fontSize: 13),
//                                     children: [
//                                       TextSpan(
//                                         text: "Terms",
//                                         style: TextStyle(
//                                           color: mainPurple,
//                                           decoration: TextDecoration.underline,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),

//                           SizedBox(
//                             width: double.infinity,
//                             height: 46,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: fieldPurple,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(14),
//                                 ),
//                                 elevation: 2,
//                               ),
//                               onPressed: _acceptTerms ? _handleSignUp : null,
//                               child: const Text(
//                                 "Sign Up",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 17,
//                                   letterSpacing: 0.7,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 15),

//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.grey.shade300,
//                                   thickness: 1.3,
//                                 ),
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 10),
//                                 child: Text("Or Sign up with", style: TextStyle(fontSize: 13)),
//                               ),
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.grey.shade300,
//                                   thickness: 1.3,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 15),

//                           SizedBox(
//                             width: double.infinity,
//                             height: 44,
//                             child: OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 side: BorderSide(color: Colors.grey.shade300, width: 1.2),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(14),
//                                 ),
//                                 backgroundColor: Colors.white,
//                                 elevation: 0,
//                               ),
//                               onPressed: () W{
//                                 // TODO: Google Sign Up logic
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     "assets/Images/google.png",
//                                     height: 22,
//                                     width: 22,
//                                     package: null,
//                                     errorBuilder: (ctx, err, stack) => const SizedBox(),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   const Text(
//                                     "Continue with Google",
//                                     style: TextStyle(
//                                       color: Colors.black87,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 35),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ThemedTextField extends StatelessWidget {
//   final String label;
//   final String hint;
//   final IconData icon;
//   final Color color;
//   final bool obscure;
//   final Widget? suffix;
//   final TextEditingController? controller;

//   const _ThemedTextField({
//     required this.label,
//     required this.hint,
//     required this.icon,
//     required this.color,
//     this.obscure = false,
//     this.suffix,
//     this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: color,
//             fontWeight: FontWeight.w600,
//             fontSize: 14.5,
//           ),
//         ),
//         const SizedBox(height: 2),
//         TextFormField(
//           controller: controller,
//           obscureText: obscure,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: color.withOpacity(0.7)),
//             prefixIcon: Icon(icon, color: color),
//             suffixIcon: suffix,
//             contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: color, width: 1.4),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: color, width: 2.0),
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'donor_login_screen.dart'; // Import the login screen

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _acceptTerms = false;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color mainPurple = Color(0xFF5C2C9C);
  static const Color fieldPurple = Color(0xFFB17CDF);
  static const Color bgLight = Color(0xFFEFDBF6);
  static const Color gradientStrong = Color(0xFF9478B9);

  String? _errorText;

  // Enhanced Firebase signup logic
  Future<void> _handleSignUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!_acceptTerms) {
      setState(() {
        _errorText = "You must accept terms and conditions.";
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isLoading = true;
    });

    try {
      String email = _emailController.text.trim().toLowerCase();
      String password = _passwordController.text;
      String name = _nameController.text.trim();

      print("Attempting to create user with email: $email"); // Debug log

      // Try to create new user
      UserCredential userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                throw Exception('Connection timeout');
              },
            );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          // User already exists, show error message instead of signing in
          print("Email already in use");
          setState(() {
            _errorText = "Account already exists with this email. Please go to login page.";
          });
          return;
        } else {
          rethrow; // Re-throw other FirebaseAuth exceptions
        }
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Failed to create user');
      }

      print("User creation successful: ${user.uid}");

      // Update display name safely
      try {
        if (user.displayName == null || user.displayName!.isEmpty) {
          await user.updateDisplayName(name);
          await Future.delayed(const Duration(milliseconds: 300));
          await user.reload();
        }
      } catch (e) {
        print("Display name update failed: $e");
      }
      

      // Sign out the user after successful registration
      await FirebaseAuth.instance.signOut();

      // Navigate to login page
      _navigateToLogin(name);

    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      String errorMessage = "Signup failed. Please try again.";
      switch (e.code) {
        case 'weak-password':
          errorMessage = "Password is too weak. Use at least 6 characters.";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email address format.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email/password signup is not enabled. Contact support.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many attempts. Please try again later.";
          break;
        case 'network-request-failed':
          errorMessage = "Network error. Check your internet connection.";
          break;
        default:
          errorMessage = "Authentication error: ${e.message ?? 'Unknown error'}";
          break;
      }
      if (mounted) {
        setState(() {
          _errorText = errorMessage;
        });
      }
    } catch (e, stacktrace) {
      print("General Exception: $e");
      print("Stacktrace: $stacktrace");
      if (mounted) {
        setState(() {
          _errorText = "Unexpected error occurred. Please try again.";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToLogin(String name) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Account created successfully, $name! Please log in."),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Welcome to WasteNot",
                    style: TextStyle(
                      color: mainPurple,
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Together, we save and share",
                    style: TextStyle(
                      color: Color(0xFF9478B9),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: gradientStrong.withOpacity(0.14),
                          blurRadius: 30,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Create Account",
                            style: TextStyle(
                              color: mainPurple,
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Join us and start creating change",
                            style: TextStyle(
                              color: Color(0xFF9478B9),
                              fontSize: 13.5,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _ThemedTextField(
                            label: "Name",
                            hint: "Enter Your Name",
                            icon: Icons.person_outline,
                            color: fieldPurple,
                            controller: _nameController,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Name is required";
                              }
                              if (val.trim().length < 2) {
                                return "Name must be at least 2 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 13),
                          _ThemedTextField(
                            label: "Email Address",
                            hint: "Enter Your Email",
                            icon: Icons.alternate_email,
                            color: fieldPurple,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Email is required";
                              }
                              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(val.trim())) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 13),
                          _ThemedTextField(
                            label: "Password",
                            hint: "Enter Your Password",
                            icon: Icons.lock_outline,
                            color: fieldPurple,
                            controller: _passwordController,
                            obscure: _obscurePassword,
                            suffix: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: fieldPurple,
                              ),
                              onPressed: () =>
                                  setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Password is required";
                              }
                              if (val.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Checkbox(
                                value: _acceptTerms,
                                activeColor: mainPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                onChanged: (val) =>
                                    setState(() => _acceptTerms = val ?? false),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: "By signing up, you agree to our ",
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 13),
                                    children: [
                                      TextSpan(
                                        text: "Terms",
                                        style: TextStyle(
                                          color: mainPurple,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (_errorText != null)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red.shade700,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _errorText!,
                                      style: TextStyle(
                                        color: Colors.red.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (_acceptTerms && !_isLoading)
                                    ? fieldPurple
                                    : fieldPurple.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 2,
                              ),
                              onPressed:
                                  (_acceptTerms && !_isLoading) ? _handleSignUp : null,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
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
  final bool obscure;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const _ThemedTextField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.color,
    this.obscure = false,
    this.suffix,
    this.controller,
    this.validator,
    this.keyboardType,
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
          validator: validator,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: color.withOpacity(0.7)),
            prefixIcon: Icon(icon, color: color),
            suffixIcon: suffix,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1.4),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 2.0),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.4),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}