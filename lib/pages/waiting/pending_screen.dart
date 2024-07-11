import 'package:flutter/material.dart';
import 'package:test_week2/pages/home_screen.dart';
import '../../components/contact_row.dart';
import '../../components/waiting_dialog.dart';
import '../../services/register_status_service.dart';

class PendingScreen extends StatefulWidget {
  final String phoneNumber;

  const PendingScreen({super.key, required this.phoneNumber});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  final RegisterStatusService registerStatusService = RegisterStatusService();

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    await _checkRegisterStatus(widget.phoneNumber);
  }

  void _showCustomDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          content: content,
          onConfirm: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _checkRegisterStatus(String phoneNumber) async {
    try {
      final response = await registerStatusService.checkRegisterStatus(phoneNumber);
      if (response != null && response["data"] != null && response["data"]["user"] != null) {
        if (response["data"]["user"]["is_approve"] == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomeScreen()),
          );
        } else {
          _showCustomDialog('គណនីរបស់អ្នកកំពុងស្ថិតក្នុងស្ថានភាពរងចាំការផ្តល់សិទ្ធ');
        }
      } else {
        _showCustomDialog('ការចុះឈ្មោះបរាជ័យ: Unexpected response format');
      }
    } catch (e) {
      _showCustomDialog('ការចុះឈ្មោះបរាជ័យ: $e');
      print('ការចុះឈ្មោះបរាជ័យ: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                "assets/png/close.png",
                width: 45,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Column(
              children: [
                const Icon(
                  Icons.access_alarm_rounded,
                  size: 100,
                  color: Colors.grey,
                ),
                const Text(
                  "សូមទាក់ទងទៅក្រុមការងារក្រសួងដើម្បីផ្តល់សិទ្ធប្រើប្រាស់",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 90, 90, 90),
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _checkRegisterStatus(widget.phoneNumber);
                    },
                    child: const Text(
                      "ចូលប្រើប្រាស់",
                      style: TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 180),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "លេខទំនាក់ទំនងក្រុមការងារ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 90, 90, 90),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 6),
                ContactRow(
                  imagePath: "assets/jpg/cellcard.jpg",
                  phoneNumber: "092193059",
                ),
                SizedBox(height: 6),
                Divider(thickness: 1),
                SizedBox(height: 6),
                ContactRow(
                  imagePath: "assets/png/Smart-08.png",
                  phoneNumber: "010345012",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
