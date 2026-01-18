import 'package:flutter/material.dart';

class SpecialDaysScreen extends StatelessWidget {
  const SpecialDaysScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> specialDaysJson = const [
    {
      "title": "World Food Day",
      "iconPath": "assets/Images/earth1.png",
      "date": "16 October",
      "description":
          "Raise awareness about hunger and take action to ensure everyone has access to nutritious food."
    },
    {
      "title": "World Book Day",
      "iconPath": "assets/Images/book1.png",
      "date": "23 April",
      "description":
          "Celebrate reading, share books, and inspire a love for knowledge."
    },
  {
    "title": "International Day of Charity",
    "iconPath": "assets/Images/charity1.png",
    "date": "5 September",
    "description":
        "Promote and celebrate charitable efforts and encourage giving to those in need."
  },
  {
    "title": "National Food Donation Day",
    "iconPath": "assets/Images/fooddonation1.png",
    "date": "2 September",
    "description":
        "Inspire communities to donate food to the hungry and reduce food waste."
  },
  {
    "title": "International Book Giving Day",
    "iconPath": "assets/Images/bookgiving1.png",
    "date": "14 February",
    "description":
        "Encourage people to give books to children and promote literacy."
  },
  {
    "title": "Clothing Donation Day",
    "iconPath": "assets/Images/clothdonation1.png",
    "date": "15 January",
    "description":
        "Motivate people to donate gently used clothes to those in need."
  },
  {
    "title": "World Hunger Day",
    "iconPath": "assets/Images/hunger1.png",
    "date": "28 May",
    "description":
        "Raise awareness and inspire action to end global hunger."
  },
  {
    "title": "World Kindness Day",
    "iconPath": "assets/Images/kindness1.png",
    "date": "13 November",
    "description":
        "Promote acts of kindness including donations of food, clothes, and books."
  },
  {
    "title": "Global Sharing Week",
    "iconPath": "assets/Images/sharing1.png",
    "date": "1st week of June",
    "description":
        "Encourage sharing within communities, including donations of essential items."
  },
  {
    "title": "International Volunteer Day",
    "iconPath": "assets/Images/volunteer1.png",
    "date": "5 December",
    "description":
        "Celebrate volunteers and encourage participation in donation drives."
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFDBF6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFDBF6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Special Days',
          style: TextStyle(
            color: Color(0xFF5C2C9C),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF5C2C9C)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 28, 18, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _safeImage(
                            "assets/Images/calendar2.png",
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 10),
                          const Flexible(
                            child: Text(
                              "Celebrate and contribute on these\nmeaningful days!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF5C2C9C),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      ...specialDaysJson.map((day) => Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: _specialDayCard(
                              title: day['title'],
                              iconPath: day['iconPath'],
                              date: day['date'],
                              description: day['description'],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to safely load images with fallback
  Widget _safeImage(String path, {double? height, double? width}) {
    return Image.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.image_not_supported, color: Color(0xFF5C2C9C), size: height ?? 24),
      ),
    );
  }

  Widget _specialDayCard({
    required String title,
    required String iconPath,
    required String date,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0x5A5C2C9C),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _safeImage(
                      iconPath,
                      height: 33,
                      width: 33,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.3,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.4,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}