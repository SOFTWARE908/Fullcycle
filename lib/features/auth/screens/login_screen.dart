import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/auth/screens/forget_password_screen.dart';
import 'package:fullcycle/features/auth/screens/register_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loading_widget.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController(
      text: kDebugMode ? 'mohamedfcis2000@gmail.com' : null);
  final password = TextEditingController(text: kDebugMode ? '123456' : null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("ليس لديك حساب؟"),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => AppNavigation.navigate(const RegisterScreen()),
              child: const Text(
                "إنشاء حساب الان",
                style: TextStyle(
                  color: Colors.orange,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text(' تسجيل الدخول')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),

              /// Email
              CustomTextField(
                controller: email,
                hintText: 'البريد الالكتروني',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'البريد الإلكتروني مطلوب';
                  }
                  if (!value.contains('@')) {
                    return 'البريد الإلكتروني غير صالح';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Password
              CustomTextField(
                controller: password,
                hintText: 'كلمة المرور',
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'كلمة المرور مطلوبة';
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور لا تقل عن 6 أحرف';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              BlocBuilder<LoginCubit, CubitState>(
                builder: (context, state) {
                  if (state == CubitState.loading) {
                    return const CustomLoadingButtonWidget();
                  }

                  return CustomElevatedButton(
                    buttonText: 'تسجيل الدخول',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<LoginCubit>()
                            .login(email.text.trim(), password.text);
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 10),

              InkWell(
                onTap: () => AppNavigation.navigate(ForgetPasswordScreen()),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('نسيت كلمة المرور؟'),
                    SizedBox(width: 2),
                    Text(
                      'إعادة تعيين',
                      style: TextStyle(
                        color: Colors.orange,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
