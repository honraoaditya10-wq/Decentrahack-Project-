import 'package:flutter/material.dart';

class FeaturedNGOsPage extends StatelessWidget {
  const FeaturedNGOsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D5F0), // Light purple background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF8A2BE2), Color(0xFF4B0082)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Text(
                      'WasteNot',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Featured NGOs',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // NGO List
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListView.builder(
                    itemCount: ngoList.length,
                    itemBuilder: (context, index) {
                      final ngo = ngoList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // NGO Logo/Image
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: ngo['color'] ?? Colors.deepPurple[200],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: ngo['imageUrl'] != null && ngo['imageUrl'] != ""
                                        ? Image.network(
                                            ngo['imageUrl']!,
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return _buildFallbackIcon(ngo);
                                            },
                                          )
                                        : _buildFallbackIcon(ngo),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // NGO Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ngo['name']!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        ngo['description']!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          height: 1.3,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 12),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFB794D1),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 8,
                                          ),
                                        ),
                                        child: const Text(
                                          "Details",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(Map<String, dynamic> ngo) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ngo['color'] ?? Colors.deepPurple[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            ngo['icon'] ?? Icons.account_balance,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              ngo['shortName'] ?? "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Simple NGO data
final List<Map<String, dynamic>> ngoList = [
  {
    "name": "Smile Foundation",
    "shortName": "Smile Foundation\nEducate. Empower. Smile.",
    "description": "Educating underprivileged children across India, empowering them with knowledge, confidence, and opportunities for a brighter future.",
    "color": Color(0xFF9575CD),
    "icon": Icons.school,
    "imageUrl": "",
  },
  {
    "name": "Akshaya Patra Foundation",
    "shortName": "Akshaya Patra Foundation",
    "description": "Serving mid-day meals to school children, nourishing their bodies, encouraging school attendance, and fueling dreams for a brighter tomorrow.",
    "color": Color(0xFF5C6BC0),
    "icon": Icons.restaurant,
    "imageUrl": "https://images.unsplash.com/photo-1593113598332-cd288d649433?w=200&h=200&fit=crop&crop=faces",
  },
  {
    "name": "Green Earth",
    "shortName": "Green Earth",
    "description": "Focused on tree plantation & environment conservation to create a sustainable future for coming generations.",
    "color": Color(0xFF66BB6A),
    "icon": Icons.eco,
    "imageUrl": "",
  },
  {
    "name": "Food For All",
    "shortName": "Food For All",
    "description": "Reducing food waste and helping poor communities by redistributing surplus food to those in need.",
    "color": Color(0xFFFF7043),
    "icon": Icons.food_bank,
    "imageUrl": "",
  },
];