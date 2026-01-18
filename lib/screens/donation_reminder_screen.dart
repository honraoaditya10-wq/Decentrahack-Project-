import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_screen.dart';

class DonationReminderPage extends StatefulWidget {
  const DonationReminderPage({Key? key}) : super(key: key);

  @override
  State<DonationReminderPage> createState() => _DonationReminderPageState();
}

class Reminder {
  String detail;
  bool completed;

  Reminder({required this.detail, this.completed = false});
}

class _DonationReminderPageState extends State<DonationReminderPage> {
  // For new reminder input
  final List<DonationDetailInput> _donationDetails = [DonationDetailInput()];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _recurringOption = 'Never';
  List<String> _selectedNotificationTypes = [];
  String? _selectedCategory = 'Food';

  final Color mainBlue = const Color(0xFF4B81C1);

  final List<String> categories = ['Food', 'Clothes', 'Money', 'Blood'];
  final List<String> recurringOptions = ['Never', 'Daily', 'Weekly', 'Monthly', 'Yearly'];
  final List<String> notificationOptions = ['Push Notification', 'Email', 'SMS'];

  // Existing reminders with completion status
  List<Reminder> _reminderHistory = [
    Reminder(detail: "Donate clothes to local shelter"),
    Reminder(detail: "Blood donation camp on 15th"),
    Reminder(detail: "Monthly food packet donation", completed: true),
  ];

  // Adds new detail input field
  void _addDonationDetail() {
    setState(() {
      _donationDetails.add(DonationDetailInput());
    });
  }

  // Toggle reminder completion state
  void _toggleCompletion(int index, bool? value) {
    setState(() {
      _reminderHistory[index].completed = value ?? false;
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _submit() {
    bool allValid = true;
    for (var detail in _donationDetails) {
      if (detail.controller.text.trim().isEmpty) {
        allValid = false;
        break;
      }
    }

    if (!allValid || _selectedDate == null || _selectedTime == null || _recurringOption == 'Never') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all donation details, select date/time, and a recurring option.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Add new reminders to history as pending (not completed)
    for (var detail in _donationDetails) {
      _reminderHistory.add(Reminder(detail: detail.controller.text.trim()));
    }

    // Clear inputs after submission
    for (var detail in _donationDetails) {
      detail.controller.clear();
    }
    _donationDetails.clear();
    _donationDetails.add(DonationDetailInput());

    _selectedDate = null;
    _selectedTime = null;
    _recurringOption = 'Never';
    _selectedNotificationTypes.clear();
    _selectedCategory = 'Food';

    // Show dialog popup for reminder setup completion
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline, color: mainBlue, size: 56),
              const SizedBox(height: 16),
              Text(
                "Reminder Set!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: mainBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Thank you for setting your donation reminder.",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // After 2.5 seconds, pop dialog and redirect to profile page
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context)
          ..pop() // close dialog
          ..pushReplacement(MaterialPageRoute(builder: (_) => const ProfileScreen()));
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    for (var detail in _donationDetails) {
      detail.controller.dispose();
    }
    super.dispose();
  }

  Widget _buildReminderCard(Reminder reminder, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                reminder.detail,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  decoration: reminder.completed ? TextDecoration.lineThrough : null,
                  color: reminder.completed ? Colors.grey : Colors.black,
                ),
              ),
            ),
            Checkbox(
              value: reminder.completed,
              onChanged: (val) => _toggleCompletion(index, val),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingReminders = _reminderHistory.where((r) => !r.completed).toList();
    final completedReminders = _reminderHistory.where((r) => r.completed).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFD1F8EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD1F8EF),
        elevation: 0,
        title: Text(
          "Donation Reminder",
          style: GoogleFonts.poppins(
            color: mainBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: mainBlue),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // --- Section: Previous Reminders ---

                if (pendingReminders.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Pending Donation Reminders",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: mainBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pendingReminders.length,
                    itemBuilder: (context, idx) {
                      // find index in original list for toggle to work correctly
                      final originalIndex = _reminderHistory.indexOf(pendingReminders[idx]);
                      return _buildReminderCard(pendingReminders[idx], originalIndex);
                    },
                  ),
                  const SizedBox(height: 20),
                ],

                if (completedReminders.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Completed Donation Reminders",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: mainBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: completedReminders.length,
                    itemBuilder: (context, idx) {
                      final originalIndex = _reminderHistory.indexOf(completedReminders[idx]);
                      return _buildReminderCard(completedReminders[idx], originalIndex);
                    },
                  ),
                  const SizedBox(height: 20),
                ],

                const Divider(),
                const SizedBox(height: 20),

                // --- Section: Set New Donation Reminder ---
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Set up your donation reminder",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: mainBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _donationDetails.length,
                  itemBuilder: (context, idx) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _donationDetails[idx].controller,
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFF3F9F7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: mainBlue),
                              ),
                              hintText: 'Donation detail ${idx + 1}',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF9C9C9C),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            ),
                          ),
                        ),
                        if (_donationDetails.length > 1)
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _donationDetails.removeAt(idx);
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _addDonationDetail,
                    icon: Icon(Icons.add, color: mainBlue),
                    label: Text(
                      "Add More",
                      style: GoogleFonts.poppins(color: mainBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Recurring Reminder Dropdown
                DropdownButton<String>(
                  value: _recurringOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _recurringOption = newValue;
                    });
                  },
                  items: recurringOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.poppins()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                // Notification Type
                Wrap(
                  spacing: 8,
                  children: notificationOptions.map((notification) {
                    return ChoiceChip(
                      label: Text(notification, style: GoogleFonts.poppins()),
                      selected: _selectedNotificationTypes.contains(notification),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedNotificationTypes.add(notification);
                          } else {
                            _selectedNotificationTypes.remove(notification);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                // Donation Category Dropdown
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.poppins()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                // ** No completion checkbox here as per your request **

                // Date and Time Pickers
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    padding: const EdgeInsets.only(left: 16, top: 4, right: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5D5D5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Color(0xFF9C9C9C), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}',
                            style: GoogleFonts.poppins(
                              color: _selectedDate == null ? const Color(0xFF9C9C9C) : const Color(0xFF666666),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () => _pickTime(context),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    padding: const EdgeInsets.only(left: 16, top: 4, right: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD5D5D5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, color: Color(0xFF9C9C9C), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _selectedTime == null ? 'Select Time' : _selectedTime!.format(context),
                            style: GoogleFonts.poppins(
                              color: _selectedTime == null ? const Color(0xFF9C9C9C) : const Color(0xFF666666),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 34),
                Center(
                  child: SizedBox(
                    width: 180,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                        elevation: 3,
                        textStyle: GoogleFonts.poppins(),
                      ),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DonationDetailInput {
  final TextEditingController controller = TextEditingController();
}