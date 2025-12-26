import 'package:flutter/material.dart';
import 'package:fullcycle/features/auth/screens/login_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';

void showDeleteAccountDialog() {
  final TextEditingController passwordController = TextEditingController();

  showDialog(
    context: AppNavigation.context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'تأكيد حذف الحساب',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('من فضلك أدخل كلمة المرور لتأكيد حذف الحساب.'),
            const SizedBox(height: 10),
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
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, elevation: 0),
            onPressed: () {
              final password = passwordController.text.trim();

              if (password.isEmpty) {
                CustomSnackBars.showErrorToast(title: 'يرجى إدخال كلمة المرور');

                return;
              }

              Navigator.pop(context);
              CustomSnackBars.showErrorToast(title: 'تم حذف الحساب بنجاح');

              AppNavigation.pushRemoveAll(LoginScreen());
            },
            child: const Text(
              '  تاكيد  ',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              '  إلغاء  ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
