import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/core/resources/colors.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:fullcycle/shared/widgets/custom_snack_bar.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../../candidate/data/models/lookup_model.dart';
import '../cubit/register_cubit.dart';

//

String formatDate(String input) {
  final inputFormat = DateFormat('dd/MM/yyyy');
  final outputFormat = DateFormat('yyyy-MM-dd');

  final date = inputFormat.parse(input);
  return outputFormat.format(date);
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final arabicNameController = TextEditingController();
  final englishNameController = TextEditingController();
  final idController = TextEditingController();
  final dobController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final password = TextEditingController();

  LookUpItem? city;
  LookUpItem? gender;
  LookUpItem? nationality;
  LookUpItem? tshirtSize;
  LookUpItem? educationLevel;
  LookUpItem? language;
  LookUpItem? department;

  int _currentStep = 0;
  final lookUps = CandidateRepository.lookupModel;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      arabicNameController.text = "محمد";
      englishNameController.text = "Ali";
      // idController.text = "1216946344";

      // dobController.text = "18/12/2005";
      heightController.text = "180";
      weightController.text = "75";
      phoneController.text = "0564694513";
      emailController.text = "m${Random().nextInt(10) * 10}@gmail.com";
      // password.text = "P@ssw0rd";
    }
  }

  void _showError(String message) =>
      CustomSnackBars.showErrorToast(title: message);

  bool _validateIdentityStep() {
    if (arabicNameController.text.trim().isEmpty) {
      _showError("الرجاء إدخال الاسم بالعربية");
      return false;
    }
    if (englishNameController.text.trim().isEmpty) {
      _showError("الرجاء إدخال الاسم بالإنجليزية");
      return false;
    }
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
        .hasMatch(emailController.text.trim())) {
      _showError("الرجاء إدخال بريد إلكتروني صحيح");
      return false;
    }
    if (password.text.isEmpty) {
      _showError("الرجاء إدخال كلمة المرور صحيح");
      return false;
    }
    if (password.text.length < 8) {
      _showError("كلمة المرور لا يجب ان تقل عن ثمان احرف");
      return false;
    }
    if (city == null) {
      _showError("الرجاء اختيار المدينة");
      return false;
    }
    return true;
  }

  bool _validatePersonalStep() {
    if (dobController.text.trim().isEmpty) {
      _showError("الرجاء إدخال تاريخ الميلاد");
      return false;
    }
    if (gender == null) {
      _showError("الرجاء اختيار الجنس");
      return false;
    }
    if (nationality == null) {
      _showError("الرجاء اختيار الجنسية");
      return false;
    }
    if (heightController.text.trim().isEmpty ||
        int.tryParse(heightController.text.trim()) == null) {
      _showError("الرجاء إدخال الطول بشكل صحيح");
      return false;
    }
    if (weightController.text.trim().isEmpty ||
        int.tryParse(weightController.text.trim()) == null) {
      _showError("الرجاء إدخال الوزن بشكل صحيح");
      return false;
    }

    if (tshirtSize == null) {
      _showError("الرجاء اختيار مقاس التيشرت");
      return false;
    }
    return true;
  }

  bool _validateContactStep() {
    if (department == null) {
      _showError("الرجاء اختيار القسم");
      return false;
    }
    if (language == null) {
      _showError("الرجاء اختيار اللغة");
      return false;
    }
    if (educationLevel == null) {
      _showError("الرجاء اختيار المستوى التعليمي");
      return false;
    }
    return true;
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _validateIdentityStep();
      case 1:
        return _validatePersonalStep();
      case 2:
        return _validateContactStep();
      default:
        return false;
    }
  }

  void _submitForm(BuildContext context) {
    if (!_validateContactStep()) return;

    context.read<RegisterCubit>().register(
          languageId: language?.value ?? 0,
          password: password.text,
          educationId: educationLevel?.value ?? 0,
          departmentId: department?.value ?? 0,
          arabicName: arabicNameController.text.trim(),
          englishName: englishNameController.text.trim(),
          idNumber: idController.text,
          cityId: city?.value ?? 0,
          email: emailController.text.trim(),
          dob: formatDate(dobController.text.trim()),
          gender: gender?.value ?? 0,
          nationality: nationality?.value ?? 0,
          height: int.parse(heightController.text),
          weight: int.parse(weightController.text),
          tshirtSize: tshirtSize?.value ?? 0,
          phoneNumber: phoneController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل حساب جديد"),
        leading: BackButton(
          onPressed: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        controlsBuilder: (context, details) => Row(
          children: [
            Flexible(
              child: CustomElevatedButton(
                onTap: () {
                  if (_currentStep < 2) {
                    if (_validateCurrentStep()) {
                      setState(() => _currentStep += 1);
                    }
                  } else {
                    _submitForm(context);
                  }
                },
                buttonText: _currentStep == 2 ? "إرسال" : "التالي",
              ),
            ),
            if (_currentStep != 0)
              Flexible(
                child: CustomElevatedButton(
                  onTap: () {
                    if (_currentStep > 0) {
                      setState(() => _currentStep -= 1);
                    }
                  },
                  buttonText: "السابق",
                  color: Colors.white,
                  fontColor: AppColors.textColor,
                ),
              ),
          ],
        ),
        steps: [
          Step(
            title: const Text("الهوية"),
            isActive: _currentStep >= 0,
            content: _buildIdentityStep(),
          ),
          Step(
            title: const Text("الشخصية"),
            isActive: _currentStep >= 1,
            content: _buildPersonalStep(),
          ),
          Step(
            title: const Text("التواصل"),
            isActive: _currentStep >= 2,
            content: _buildContactStep(context),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityStep() {
    return Column(
      children: [
        buildTextField("الاسم بالعربية", arabicNameController),
        buildTextField("الاسم بالإنجليزية", englishNameController),
        buildTextField("رقم الهوية (اختياري)", idController,
            keyboardType: TextInputType.number),
        buildTextField("البريد الإلكتروني", emailController,
            keyboardType: TextInputType.emailAddress),
        buildTextField("كلمة المرور", password,
            keyboardType: TextInputType.visiblePassword),
        buildDropdown("المدينة", city, lookUps?.lookUpData?.cities ?? [],
            (val) => setState(() => city = val!)),
      ],
    );
  }

  Widget _buildPersonalStep() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate:
                  DateTime.now().subtract(const Duration(days: 365 * 20)),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              dobController.text = DateFormat("dd/MM/yyyy").format(picked);
            }
          },
          child: AbsorbPointer(
            child: buildTextField("تاريخ الميلاد", dobController),
          ),
        ),
        buildDropdown("الجنس", gender, lookUps?.lookUpData?.genders,
            (val) => setState(() => gender = val!)),
        buildDropdown(
            "الجنسية",
            nationality,
            lookUps?.lookUpData?.nationalities,
            (val) => setState(() => nationality = val!)),
        buildTextField("الطول (سم)", heightController,
            keyboardType: TextInputType.number, maxLength: 3),
        buildTextField(
          "الوزن (كجم)",
          weightController,
          maxLength: 3,
          keyboardType: TextInputType.number,
        ),
        buildDropdown(
            "مقاس التيشرت",
            tshirtSize,
            lookUps?.lookUpData?.tshirtSizes,
            (val) => setState(() => tshirtSize = val!)),
      ],
    );
  }

  Widget _buildContactStep(BuildContext context) {
    return Column(
      children: [
        buildTextField("رقم الهاتف ( اختياري )", phoneController,
            keyboardType: TextInputType.phone),
        buildDropdown(
            "القسم",
            department,
            lookUps?.lookUpData?.departments ?? [],
            (val) => setState(() => department = val!)),
        buildDropdown("اللغة", language, lookUps?.lookUpData?.languages ?? [],
            (val) => setState(() => language = val!)),
        buildDropdown(
            "المستوى التعليمي",
            educationLevel,
            lookUps?.lookUpData?.educationLevels ?? [],
            (val) => setState(() => educationLevel = val!)),
        BlocBuilder<RegisterCubit, CubitState>(
          builder: (context, state) {
            if (state == CubitState.loading) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CustomLoadingWidget(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CustomTextField(
        controller: controller,
        maxLength: maxLength,
        hintText: label,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget buildDropdown(String? label, LookUpItem? value,
      List<LookUpItem>? items, Function(LookUpItem?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<LookUpItem?>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onChanged: onChanged,
        items: items
            ?.map((e) => DropdownMenuItem(
                  value: e,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(e.text ?? "")),
                ))
            .toList(),
      ),
    );
  }
}
