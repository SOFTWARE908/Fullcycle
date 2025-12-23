import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/experience/presentation/cubit/add_experience_cubit.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  final _formKey = GlobalKey<FormState>();

  final companyNameController = TextEditingController();
  final position = TextEditingController();
  final numOfYearsController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _requiredValidator(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال ${fieldName ?? "هذا الحقل"}';
    }
    return null;
  }

  String? _numberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال عدد السنين';
    }
    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return 'أدخل رقم صحيح أكبر من صفر';
    }
    return null;
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      context.read<AddExperienceCubit>().addExpeience(
            companyName: companyNameController.text.trim(),
            description: descriptionController.text.trim(),
            position: position.text.trim(),
            years: int.parse(numOfYearsController.text.trim()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة خبرة جديدة'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text('اسم الشركة'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: companyNameController,
                  validator: (val) =>
                      _requiredValidator(val, fieldName: "اسم الشركة"),
                ),
                const SizedBox(height: 16),
                const Text('المسمي الوظيفي'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: position,
                  validator: (val) =>
                      _requiredValidator(val, fieldName: "المسمي الوظيفي"),
                ),
                const SizedBox(height: 16),
                const Text('المدة(عدد السنوات)'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: numOfYearsController,
                  keyboardType: TextInputType.number,
                  validator: _numberValidator,
                ),
                const SizedBox(height: 16),
                const Text('الوصف'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: descriptionController,
                  maxLines: 4,
                  validator: (val) =>
                      _requiredValidator(val, fieldName: "الوصف"),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: BlocBuilder<AddExperienceCubit, CubitState>(
              builder: (context, state) {
            if (state == CubitState.loading) {
              return const CustomLoadingButtonWidget();
            }
            return CustomElevatedButton(
              onTap: _onSave,
              fontColor: const Color(0xffF5DCCB),
              fontWeight: FontWeight.w500,
              fontSize: 16,
              buttonText: 'حفظ الخبرة',
            );
          }),
        ),
      ),
    );
  }
}
