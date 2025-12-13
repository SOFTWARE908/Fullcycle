import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loading_widget.dart';
import '../cubit/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final email = TextEditingController(
      text: kDebugMode ? 'mohamedfcis2000@gmail.com' : null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إعادة تعيين كلمة المرور")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 25),
            CustomTextField(
              controller: email,
              hintText: "البريد الالكتروني",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            BlocBuilder<ForgetPasswordCubit, CubitState>(
              builder: (context, state) {
                if (state == CubitState.loading) {
                  return const CustomLoadingButtonWidget();
                }

                return CustomElevatedButton(
                  buttonText: "استعادة كلمة المرور",
                  onTap: () {
                    context
                        .read<ForgetPasswordCubit>()
                        .resetPassword(email.text);
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
