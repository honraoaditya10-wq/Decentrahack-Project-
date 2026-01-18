import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DonationGuidelinesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> guidelines = [
    // FOOD SECTION
    {
      "category": "Food Safety",
      "icon": Icons.health_and_safety,
      "color": Colors.red,
      "gradient": [Color(0xFFE53935), Color(0xFFEF5350)],
      "items": [
        {
          "title": "Check Expiration Dates",
          "description": "Ensure all food items are fresh and well within their expiration dates. Never donate expired food.",
          "icon": Icons.schedule,
          "tips": [
            "Check all packaging dates",
            "Remove any expired items",
            "When in doubt, don't donate"
          ]
        },
        {
          "title": "Temperature Control",
          "description": "Keep perishable items at proper temperatures until pickup to maintain food safety.",
          "icon": Icons.thermostat,
          "tips": [
            "Refrigerate perishables",
            "Use insulated containers",
            "Arrange quick pickup"
          ]
        },
        {
          "title": "Visual Inspection",
          "description": "Inspect food for any signs of spoilage, mold, or contamination before donating.",
          "icon": Icons.visibility,
          "tips": [
            "Check for discoloration",
            "Look for unusual odors",
            "Ensure packaging integrity"
          ]
        }
      ]
    },
    {
      "category": "Packaging & Storage (Food)",
      "icon": Icons.inventory_2,
      "color": Colors.blue,
      "gradient": [Color(0xFF1976D2), Color(0xFF42A5F5)],
      "items": [
        {
          "title": "Proper Packaging",
          "description": "Pack food in clean, sealed containers to prevent contamination and maintain freshness.",
          "icon": Icons.kitchen,
          "tips": [
            "Use clean containers",
            "Seal packages properly",
            "Label contents clearly"
          ]
        },
        {
          "title": "Hygienic Handling",
          "description": "Maintain cleanliness when preparing and packing food donations.",
          "icon": Icons.clean_hands,
          "tips": [
            "Wash hands thoroughly",
            "Use clean utensils",
            "Sanitize surfaces"
          ]
        },
        {
          "title": "Storage Guidelines",
          "description": "Store packed food in appropriate conditions until pickup time.",
          "icon": Icons.storage,
          "tips": [
            "Keep in cool, dry place",
            "Separate raw and cooked",
            "Maintain organization"
          ]
        }
      ]
    },
    {
      "category": "Logistics & Communication (Food)",
      "icon": Icons.schedule_send,
      "color": Colors.green,
      "gradient": [Color(0xFF388E3C), Color(0xFF66BB6A)],
      "items": [
        {
          "title": "Accurate Information",
          "description": "Provide precise details about quantity, type of food, and your location.",
          "icon": Icons.info,
          "tips": [
            "Count items accurately",
            "Describe food types",
            "Provide clear address"
          ]
        },
        {
          "title": "Reliable Timing",
          "description": "Be available at the specified pickup time and communicate any changes promptly.",
          "icon": Icons.access_time,
          "tips": [
            "Confirm pickup times",
            "Be punctual",
            "Notify if delayed"
          ]
        },
        {
          "title": "Clear Communication",
          "description": "Maintain open communication with pickup volunteers for smooth coordination.",
          "icon": Icons.chat,
          "tips": [
            "Share contact details",
            "Respond promptly",
            "Provide pickup instructions"
          ]
        }
      ]
    },
    // CLOTHES SECTION
    {
      "category": "Clothes Condition & Hygiene",
      "icon": Icons.checkroom,
      "color": Colors.purple,
      "gradient": [Color(0xFF8E24AA), Color(0xFFCE93D8)],
      "items": [
        {
          "title": "Clean Clothes Only",
          "description": "Donate only freshly washed and clean clothes, free from stains, holes, or strong odors.",
          "icon": Icons.local_laundry_service,
          "tips": [
            "Wash and dry clothes before donating",
            "Check for stains or damage",
            "Avoid donating undergarments unless unused"
          ]
        },
        {
          "title": "Good Condition",
          "description": "Ensure all clothes are wearable and in good condition.",
          "icon": Icons.thumb_up,
          "tips": [
            "No rips or severe wear",
            "Check buttons and zippers",
            "Pair up socks and gloves"
          ]
        }
      ]
    },
    {
      "category": "Packaging & Sorting (Clothes)",
      "icon": Icons.inventory,
      "color": Colors.indigo,
      "gradient": [Color(0xFF3949AB), Color(0xFF90CAF9)],
      "items": [
        {
          "title": "Sort by Type & Size",
          "description": "Sort clothes by type (men, women, children) and size for easier distribution.",
          "icon": Icons.line_weight,
          "tips": [
            "Separate by gender and age group",
            "Fold neatly",
            "Label bags if possible"
          ]
        },
        {
          "title": "Package Securely",
          "description": "Pack clothes in clean bags or boxes to keep them safe during transport.",
          "icon": Icons.shopping_bag,
          "tips": [
            "Use sturdy bags/boxes",
            "Avoid over-packing",
            "Seal bags/boxes securely"
          ]
        }
      ]
    },
    {
      "category": "Logistics & Communication (Clothes)",
      "icon": Icons.local_shipping,
      "color": Colors.teal,
      "gradient": [Color(0xFF00897B), Color(0xFF80CBC4)],
      "items": [
        {
          "title": "Provide Details",
          "description": "Mention the type, size, and quantity of clothes in each package.",
          "icon": Icons.info_outline,
          "tips": [
            "List number of items",
            "Specify sizes if possible",
            "Add any special notes"
          ]
        },
        {
          "title": "Arrange Pickup/Drop-off",
          "description": "Coordinate timing and location clearly for a smooth handover.",
          "icon": Icons.schedule,
          "tips": [
            "Be available at scheduled time",
            "Provide clear address",
            "Notify in case of delays"
          ]
        }
      ]
    },
    // BOOKS SECTION
    {
      "category": "Books Condition",
      "icon": Icons.menu_book,
      "color": Colors.deepOrange,
      "gradient": [Color(0xFFF4511E), Color(0xFFFFB74D)],
      "items": [
        {
          "title": "Acceptable Condition",
          "description": "Donate books that are gently used, with no missing pages, excessive markings, or major damage.",
          "icon": Icons.assignment_turned_in,
          "tips": [
            "Check for torn/missing pages",
            "No water damage",
            "No excessive scribbling"
          ]
        },
        {
          "title": "Age Appropriateness",
          "description": "Donate age-appropriate books for children, teens, or adults as needed.",
          "icon": Icons.child_care,
          "tips": [
            "Label age group if possible",
            "Bundle similar books",
            "No explicit content"
          ]
        }
      ]
    },
    {
      "category": "Packaging & Sorting (Books)",
      "icon": Icons.archive,
      "color": Colors.brown,
      "gradient": [Color(0xFF6D4C41), Color(0xFFD7CCC8)],
      "items": [
        {
          "title": "Pack Carefully",
          "description": "Pack books in sturdy boxes or bags to prevent damage during transport.",
          "icon": Icons.inventory_2,
          "tips": [
            "Use cardboard boxes or strong bags",
            "Don't overfill boxes",
            "Secure boxes with tape"
          ]
        },
        {
          "title": "Sort by Type",
          "description": "Group similar books together for easy sorting on arrival.",
          "icon": Icons.category,
          "tips": [
            "Group by genre, subject, or age",
            "Label if possible",
            "Separate textbooks from storybooks"
          ]
        }
      ]
    },
    {
      "category": "Logistics & Communication (Books)",
      "icon": Icons.local_post_office,
      "color": Colors.blueGrey,
      "gradient": [Color(0xFF607D8B), Color(0xFFB0BEC5)],
      "items": [
        {
          "title": "Share Details",
          "description": "Specify book types, number of books, and any special notes.",
          "icon": Icons.info,
          "tips": [
            "Count books before packing",
            "List genres if possible",
            "Mention any rare/special books"
          ]
        },
        {
          "title": "Pickup/Drop-off",
          "description": "Arrange a suitable time and place for donation handover.",
          "icon": Icons.calendar_today,
          "tips": [
            "Agree on timing",
            "Use sturdy packaging",
            "Notify in case of schedule changes"
          ]
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      appBar: AppBar(
        title: const Text(
          "Donation Guidelines",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5C2C9C), // MAIN PURPLE
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5A2C9C), Color(0xFFB17CDF)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.17),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: const Color(0xFFB17CDF),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.menu_book,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Safe Donation Practices',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Follow these guidelines to ensure your donations are safe and helpful',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Guidelines Categories
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: guidelines.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(guidelines[index]);
              },
            ),
          ),
          // Bottom Quick Tips Section
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF9463d6),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: const Color(0x33FFFFFF),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EFFF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFF6D5DF6),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Reminder',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3A1768),
                            ),
                          ),
                          Text(
                            'When in doubt about donation safety or quality, always check item condition, pack properly, and don\'t hesitate to ask for help!',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                       onPressed: () {
  _downloadGuidelines(context);
},

                        icon: const Icon(Icons.download, size: 18),
                        label: const Text('Download PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5c2c9c),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: (category['color'] as Color).withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Category Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: (category['gradient'] as List<Color>),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    category['category'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Guidelines Items
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: (category['items'] as List<dynamic>).map<Widget>((item) {
                return _buildGuidelineItem(item as Map<String, dynamic>, category['color'] as Color);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineItem(Map<String, dynamic> item, Color categoryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: categoryColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: categoryColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: categoryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            item['description'] as String,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          // Tips
          Column(
            children: (item['tips'] as List<dynamic>).map<Widget>((tip) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: categoryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tip as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _downloadGuidelines(BuildContext context) async {
  const url = 'https://food.ec.europa.eu/document/download/1ddc7c28-994c-4a90-ac9c-8e84cea42ef6_en?filename=fw_lib_gfd_hun_guide_food-proc-retail-sect_eng.pdf';

  if (Platform.isAndroid) {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission is required to download the file')),
      );
      return;
    }
  }

  try {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final filePath = '${directory!.path}/donation_guidelines.pdf';

    await Dio().download(url, filePath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded to $filePath')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download failed')),
    );
  }
}

}