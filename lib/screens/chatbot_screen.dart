import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Welcome message
    _messages.add(ChatMessage(
      text: "Hi! I'm WasteNot Assistant 👋\n\nI'm here to help you learn about our app and guide you through the donation process. How can I help you today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: _getBotResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ));
          _isTyping = false;
        });
        _scrollToBottom();
      }
    });
  }

  String _getBotResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    // Food donation
    if (message.contains('food') || message.contains('meal')) {
      return "🍽️ Food Donation:\n\nYou can donate extra meals, cooked food, or packaged items. We connect you with local NGOs and people in need.\n\n• Tap on 'FOOD' option on home screen\n• Add photos and details\n• Choose pickup or drop-off\n• Help feed someone today!\n\nWould you like to know about donation guidelines?";
    }

    // Cloth donation
    if (message.contains('cloth') || message.contains('clothes') || message.contains('clothing')) {
      return "👕 Cloth Donation:\n\nDonate your unused clothes and bring warmth to someone in need!\n\n• Clean, wearable clothes accepted\n• All sizes and seasons welcome\n• Shoes and accessories too\n• Easy pickup options\n\nJust tap the 'CLOTH' option to get started!";
    }

    // Book donation
    if (message.contains('book') || message.contains('study') || message.contains('education')) {
      return "📚 Book Donation:\n\nShare knowledge and open new worlds for eager learners!\n\n• School textbooks\n• Story books\n• Reference materials\n• Stationery items\n\nTap 'BOOK' option to donate and make education accessible!";
    }

    // How it works
    if (message.contains('how') || message.contains('work') || message.contains('process')) {
      return "✨ How WasteNot Works:\n\n1. Choose donation type (Food/Cloth/Book)\n2. Add photos and description\n3. Select pickup or drop-off\n4. NGO confirms and collects\n5. Track your donation impact!\n\nIt's that simple! What would you like to donate?";
    }

    // NGO
    if (message.contains('ngo') || message.contains('organization')) {
      return "🤝 Featured NGOs:\n\nWe partner with verified NGOs across your city. You can:\n\n• View featured NGOs on home screen\n• See their work and impact\n• Choose specific NGOs for donation\n• Attend their events\n\nTap 'Featured NGOs' in Donor Highlights to explore!";
    }

    // Events
    if (message.contains('event') || message.contains('program')) {
      return "📅 Upcoming Events:\n\nJoin donation drives and community events!\n\n• Food distribution drives\n• Cloth collection camps\n• Book donation fairs\n• Volunteer opportunities\n\nCheck 'Upcoming Events' section to participate!";
    }

    // Special days
    if (message.contains('special') || message.contains('occasion') || message.contains('birthday')) {
      return "🎉 Special Days:\n\nCelebrate occasions by giving back!\n\n• Birthday donations\n• Anniversary contributions\n• Festival giving\n• Memorial donations\n\nVisit 'Special Days' to make your day more meaningful!";
    }

    // Track donations
    if (message.contains('track') || message.contains('history') || message.contains('past')) {
      return "📊 Your Donations:\n\nTrack all your contributions in one place!\n\n• View donation history\n• See impact statistics\n• Get appreciation certificates\n• Monitor monthly progress\n\nTap 'Your Donations' card on home screen!";
    }

    // Guidelines
    if (message.contains('guideline') || message.contains('rule') || message.contains('policy')) {
      return "📋 Donation Guidelines:\n\n• Items should be in good condition\n• Food should be fresh and hygienic\n• Clothes should be clean and wearable\n• Books should be readable\n• Provide accurate photos\n\nCheck 'Donation Guidelines' for detailed information!";
    }

    // Contact
    if (message.contains('contact') || message.contains('support') || message.contains('help') || message.contains('issue')) {
      return "📞 Contact & Support:\n\nNeed assistance? We're here to help!\n\n• In-app chat support\n• Email: support@wastenot.com\n• Phone: +91-XXXXXXXXXX\n• FAQs section\n\nVisit 'Contact & Support' in Donor Highlights!";
    }

    // Profile
    if (message.contains('profile') || message.contains('account') || message.contains('setting')) {
      return "👤 Your Profile:\n\nManage your account settings:\n\n• Update personal info\n• Set notification preferences\n• View donation badges\n• Share your impact\n\nTap the profile icon in top-right corner!";
    }

    // Start/donate
    if (message.contains('start') || message.contains('donate') || message.contains('begin')) {
      return "🌟 Ready to Make a Difference?\n\nChoose what you'd like to donate:\n\n• 🍽️ Food - Share extra meals\n• 👕 Cloth - Donate unused clothes\n• 📚 Book - Gift knowledge\n\nTap any option on the home screen to begin your donation journey!";
    }

    // Thank you
    if (message.contains('thank') || message.contains('thanks')) {
      return "You're welcome! 😊 Your kindness makes a real difference. Is there anything else you'd like to know about WasteNot?";
    }

    // Greeting
    if (message.contains('hi') || message.contains('hello') || message.contains('hey')) {
      return "Hello! 👋 Happy to help you explore WasteNot. What would you like to know about our donation platform?";
    }

    // Default response
    return "I'm here to help! You can ask me about:\n\n• How to donate (food/clothes/books)\n• NGO partnerships\n• Upcoming events\n• Donation guidelines\n• Tracking your impact\n• Contact support\n\nWhat would you like to know? 😊";
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF9B6DE8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/Images/chatbot_icon.png',
                height: 24,
                width: 24,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.smart_toy, color: Color(0xFF9B6DE8));
                },
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WasteNot Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Always here to help',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          if (_isTyping) _buildTypingIndicator(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF9B6DE8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF9B6DE8)
                    : Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft:
                      Radius.circular(message.isUser ? 20 : 4),
                  bottomRight:
                      Radius.circular(message.isUser ? 4 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF9B6DE8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(1),
                const SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -5 * (0.5 - (value - index * 0.2).abs())),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: _handleSendMessage,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _handleSendMessage(_messageController.text),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF9B6DE8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}