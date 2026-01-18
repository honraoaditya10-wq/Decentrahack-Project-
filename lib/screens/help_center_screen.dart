import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => HelpCenterScreenState();
}

class HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<Map<String, String>> faqs = [
    {
      "question": "How can I donate food or clothes using WasteNot?",
      "answer":
          "You can donate by registering/logging in, then using the 'Donate' feature to list your items. Volunteers will coordinate pickup or drop-off."
    },
    {
      "question": "What should I do if I face issues with a pickup, delivery, or mismatched donation?",
      "answer":
          "Please contact our support team through the Help Center or use the 'Report an Issue' feature in your account. We will assist you promptly."
    },
    {
      "question": "Can NGOs or organizations partner with WasteNot?",
      "answer":
          "Yes! NGOs or organizations can register as partners, collaborate for pickups, and receive donations via our platform."
    },
    {
      "question": "How can I track my past donations and impact?",
      "answer":
          "Your donation history and impact summary are available in your profile under 'My Donations'."
    },
    {
      "question": "How is my privacy protected?",
      "answer":
          "We value your privacy and never share your data with third parties without consent. Read our privacy policy for more details."
    },
  ];

  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _isExpanded = List.generate(faqs.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Color(0xFF5C2C9C),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF5C2C9C)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: const Color(0xFF5C2C9C),
            height: 2,
            width: double.infinity,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
          child: Column(
            children: [
              // Welcome Container
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.13),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Welcome to Help Center , checkout getting started guide or contact us for assistance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5C2C9C),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your submit request action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5C2C9C),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          "Submit Your Request",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Space
              const SizedBox(height: 28),

              // FAQ Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7D7F6),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 11,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Learn More About WasteNot",
                        style: TextStyle(
                          color: Color(0xFF5C2C9C),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: faqs.length,
                      itemBuilder: (context, index) {
                        return _buildFaqTile(index);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqTile(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0), // increased left padding
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            trailing: Icon(
              _isExpanded[index]
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF5C2C9C),
            ),
            title: Text(
              faqs[index]['question']!,
              style: const TextStyle(
                color: Color(0xFF5C2C9C),
                fontWeight: FontWeight.w600,
                fontSize: 13.8, // reduced text size
              ),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 2, 14, 14), // more left padding for answer
                child: Text(
                  faqs[index]['answer']!,
                  style: const TextStyle(
                    color: Color(0xFF6E4CA5),
                    fontSize: 12.5, // reduced text size
                    height: 1.45,
                  ),
                ),
              )
            ],
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded[index] = expanded;
              });
            },
            initiallyExpanded: _isExpanded[index],
          ),
        ),
      ),
    );
  }
}