import 'package:flutter/material.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});
  final TextEditingController complaintController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المساعدة"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'برجاء كتابة الشكوى أو الاستفسار الخاص بك وسنقوم بالرد عليك في أقرب وقت ممكن.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: complaintController,
              maxLines: 6,
              hintText: 'اكتب الشكوى هنا...',
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onTap: () {
                if (complaintController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('من فضلك اكتب الشكوى أولاً'),
                    ),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إرسال الشكوى بنجاح'),
                  ),
                );

                complaintController.clear();
              },
              buttonText: 'إرسال الشكوى',
            ),
          ],
        ),
      ),
    );
  }
}
