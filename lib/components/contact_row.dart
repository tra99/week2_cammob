import 'package:flutter/material.dart';

class ContactRow extends StatelessWidget {
  final String imagePath;
  final String phoneNumber;

  const ContactRow({super.key, 
    required this.imagePath,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(imagePath, width: 60),
            const SizedBox(width: 20),
            Text(phoneNumber, style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 28, 125, 31) )),
          ],
        ),
        const Icon(Icons.phone, color: Color.fromARGB(255, 28, 125, 31), size: 30),
      ],
    );
  }
}