import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double rating = 0;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF6B5FCE);
    final bold = const Color(0xFF5C2C9C);
    final bg = const Color(0xFFE8E4F3);
    final rateBg = const Color(0xFFE8D6F3);
    final gold = const Color(0xFFFFB800);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primary, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Feedback",
          style: TextStyle(
            color: bold,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Any Feedback or Suggestions would be appreciated .",
                    style: TextStyle(
                      fontSize: 15,
                      color: bold,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // NAME
                  Text(
                    "NAME:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Container(
                    height: 1.5,
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 26),

                  // EMAIL
                  Text(
                    "EMAIL:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Container(
                    height: 1.5,
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 26),

                  // Rating Section
                  Text(
                    "Rate Us:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: rateBg,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: RatingBar.builder(
                        initialRating: rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 36.0,
                        unratedColor: Colors.white,
                        glowColor: Colors.transparent,
                        // Increased gap between stars
                        itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                        itemBuilder: (context, index) => Icon(
                          rating > index
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: gold,
                          size: 36,
                        ),
                        onRatingUpdate: (value) {
                          setState(() {
                            rating = value;
                          });
                        },
                        updateOnDrag: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Message
                  Text(
                    "MESSAGE:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: bold,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        // Shadow only on left, right, and bottom
                        BoxShadow(
                          color: Colors.black.withOpacity(0.13),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          blurRadius: 6,
                          offset: const Offset(4, 0),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          blurRadius: 6,
                          offset: const Offset(-4, 0),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      minLines: 7,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Send Button
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          // Action for sending feedback
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Feedback sent successfully!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          // Optionally navigate back
                          // Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 7,
                          shadowColor: Colors.black.withOpacity(0.22),
                        ),
                        child: const Text(
                          'SEND',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}