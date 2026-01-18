import 'package:flutter/material.dart';
import 'chatbot_screen.dart';

class FloatingChatBot extends StatefulWidget {
  const FloatingChatBot({super.key});

  @override
  State<FloatingChatBot> createState() => _FloatingChatBotState();
}
 
class _FloatingChatBotState extends State<FloatingChatBot> {
  Offset _offset = const Offset(20, 500);
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            _isDragging = true;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            // Update position while dragging
            double newX = _offset.dx + details.delta.dx;
            double newY = _offset.dy + details.delta.dy;

            // Keep within screen bounds
            newX = newX.clamp(0.0, size.width - 60);
            newY = newY.clamp(0.0, size.height - 60);

            _offset = Offset(newX, newY);
          });
        },
        onPanEnd: (details) {
          setState(() {
            _isDragging = false;
            // Snap to nearest edge (left or right)
            if (_offset.dx < size.width / 2) {
              _offset = Offset(20, _offset.dy);
            } else {
              _offset = Offset(size.width - 80, _offset.dy);
            }
          });
        },
        onTap: () {
          if (!_isDragging) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatBotScreen()),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF9B6DE8), Color(0xFF7C4DFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9B6DE8).withOpacity(0.5),
                blurRadius: _isDragging ? 20 : 15,
                spreadRadius: _isDragging ? 3 : 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/Images/chatbot_icon.png',
                  width: 32,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.smart_toy,
                      color: Colors.white,
                      size: 32,
                    );
                  },
                ),
              ),
              // Notification badge (optional)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}