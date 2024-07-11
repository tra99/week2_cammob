import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String content;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            const Icon(
              Icons.hourglass_top_outlined,
              size: 60,
              color: Colors.grey,
            ),
            const SizedBox(height: 40),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 197, 197, 197),
                fontWeight: FontWeight.w200
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 110,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: const Text(
                  "យល់ព្រម",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
