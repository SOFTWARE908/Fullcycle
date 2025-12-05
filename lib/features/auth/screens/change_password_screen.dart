import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loading_widget.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تغيير كلمة المرور")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 25),

            /// Old Password
            CustomTextField(
              controller: oldPassword,
              hintText: "كلمة المرور القديمة",
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 20),

            /// New Password
            CustomTextField(
              controller: newPassword,
              hintText: "كلمة المرور الجديدة",
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 30),

            BlocBuilder<ChangePasswordCubit, CubitState>(
              builder: (context, state) {
                if (state == CubitState.loading) {
                  return const CustomLoadingButtonWidget();
                }

                return CustomElevatedButton(
                  buttonText: "تغيير كلمة المرور",
                  onTap: () {
                    context.read<ChangePasswordCubit>().changePassword(
                      oldPassword: oldPassword.text,
                      newPassword: newPassword.text,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
