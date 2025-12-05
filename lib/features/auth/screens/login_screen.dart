import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/extensions/string_extenstions.dart';
import 'package:fullcycle/core/resources/colors.dart';
import 'package:fullcycle/features/auth/screens/register_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loading_widget.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../cubit/send_otp_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final nationalId =
      TextEditingController(text: kDebugMode ? 'mohamed@gmail.com' : null);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                controller: nationalId,
                hintText: 'البريد الالكتروني',
                // keyboardType: TextInputType.number,
                validator: (val) => val!.emailValidator(val),
              ),

              const SizedBox(height: 20),
              BlocBuilder<SendOtpCubit, CubitState>(builder: (context, state) {
                if (state == CubitState.loading) {
                  return const CustomLoadingButtonWidget();
                }
                return CustomElevatedButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SendOtpCubit>().sendOtp(nationalId.text);
                    }
                  },
                  buttonText: 'تسجيل الدخول',
                );
              }),
              const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       "ليس لديك حساب؟",
              //       style: TextStyle(color: Colors.grey),
              //     ),
              //     const SizedBox(width: 4),
              //     GestureDetector(
              //       onTap: () => AppNavigation.navigate(const RegisterScreen()),
              //       child: const Text(
              //         "إنشاء حساب الان",
              //         style: TextStyle(
              //           color: AppColors.primaryColor,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 16,
              //         ),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
