import 'package:flutter/material.dart';
import 'package:fullcycle/features/auth/screens/login_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

void showDeleteAccountDialog(BuildContext context) {
  final TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'تأكيد حذف الحساب',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('من فضلك أدخل كلمة المرور لتأكيد حذف الحساب.'),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              final password = passwordController.text.trim();

              if (password.isEmpty) {
                CustomSnackBars.showErrorToast(title: 'يرجى إدخال كلمة المرور');

                return;
              }

              Navigator.pop(context);
              CustomSnackBars.showErrorToast(title: 'تم حذف الحساب بنجاح');

              AppNavigation.navigateOffAll(LoginScreen());
            },
            child: const Text('حذف'),
          ),
        ],
      );
    },
  );
}
