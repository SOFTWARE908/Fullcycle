import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../../core/cubit/base_cubit_state.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_loading_widget.dart';
import '../cubit/login_cubit.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key, required this.name});

  final String name;

  final controller =
      TextEditingController(text: kDebugMode ? 'P@ssw0rd' : null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اكمل تسجيل الدخول')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              controller: controller,
              hintText: 'كلمة المرور',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            BlocBuilder<LoginCubit, CubitState>(builder: (context, state) {
              if (state == CubitState.loading) {
                return const CustomLoadingButtonWidget();
              }

              return CustomElevatedButton(
                  buttonText: 'تحقق',
                  onTap: () =>
                      context.read<LoginCubit>().login(name, controller.text));
            })
          ],
        ),
      ),
    );
  }
}
