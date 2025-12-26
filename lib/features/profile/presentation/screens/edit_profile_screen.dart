import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/core/resources/colors.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../../auth/cubit/lookups_cubit.dart';
import '../../../candidate/data/models/lookup_item.dart';
import '../../cubit/edit_profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final LookupsCubit lookupsCubit;

  // Controllers
  late final TextEditingController arabicNameController;
  late final TextEditingController emailController;
  late final TextEditingController englishNameController;
  late final TextEditingController idController;
  late final TextEditingController dobController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;
  late final TextEditingController sizeController;

  LookUpItem? city;
  LookUpItem? gender;
  LookUpItem? nationality;
  LookUpItem? language;
  LookUpItem? departement;
  LookUpItem? tshirtSize;
  LookUpItem? education;

  @override
  void initState() {
    super.initState();

    final candidate = CacheHelper.candidate;

    arabicNameController =
        TextEditingController(text: candidate?.fullNameAr ?? '');
    englishNameController =
        TextEditingController(text: candidate?.fullNameEn ?? '');

    idController = TextEditingController(text: candidate?.identity ?? '');

    dobController = TextEditingController(text: candidate?.dateOfBirth ?? '');
    heightController =
        TextEditingController(text: candidate?.height?.toString() ?? '');

    weightController =
        TextEditingController(text: candidate?.weight?.toString() ?? '');
    emailController =
        TextEditingController(text: candidate?.email?.toString() ?? '');

    sizeController =
        TextEditingController(text: candidate?.tShirtSize.toString() ?? '');

    lookupsCubit = context.read<LookupsCubit>();
    lookupsCubit.getLookUps();
  }

  void _initSelectedLookups() {
    final lookups = lookupsCubit.lookupModel?.lookUpData;
    final candidate = CacheHelper.candidate;

    city ??= lookups?.cities?.firstWhere((e) => e.value == candidate?.cityId);

    gender ??=
        lookups?.genders?.firstWhere((e) => e.value == candidate?.genderId);

    nationality ??= lookups?.nationalities
        ?.firstWhere((e) => e.value == candidate?.nationalityId);

    language ??=
        lookups?.languages?.firstWhere((e) => e.value == candidate?.languageId);
    departement ??= lookups?.departments
        ?.firstWhere((e) => e.value == candidate?.departmentId);
    tshirtSize ??= lookups?.tshirtSizes
        ?.firstWhere((e) => e.value == candidate?.tShirtSize);

    education ??= lookups?.educationLevels
        ?.firstWhere((e) => e.value == candidate?.educationId);
  }

  @override
  void dispose() {
    arabicNameController.dispose();
    englishNameController.dispose();
    idController.dispose();
    dobController.dispose();
    heightController.dispose();
    weightController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تعديل حسابي")),
      body: BlocBuilder<LookupsCubit, CubitState>(
        buildWhen: (p, c) => c != CubitState.loading,
        builder: (context, state) {
          if (state == CubitState.done) {
            _initSelectedLookups();

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الاسم بالعربي',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                      hintText: "الاسم بالعربي",
                      controller: arabicNameController),
                  const SizedBox(height: 10),
                  const Text(
                    'الاسم بالانجليزية',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                      hintText: "الاسم بالانجليزية",
                      controller: englishNameController),
                  const SizedBox(height: 10),
                  const Text(
                    'الطول',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                      hintText: "الطول", controller: heightController),
                  const SizedBox(height: 10),
                  const Text(
                    'البريد الالكتروني',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                      hintText: "البريد الالكتروني",
                      controller: emailController),
                  const SizedBox(height: 10),
                  const Text(
                    'الوزن',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                      hintText: "الوزن", controller: weightController),
                  const SizedBox(height: 10),
                  const Text(
                    'تاريخ الميلاد',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                      onTap: () => _selectDate(dobController),
                      child: AbsorbPointer(
                          child: CustomTextField(
                              hintText: "تاريخ الميلاد",
                              controller: dobController))),
                  _dropdown(
                    hint: "المدينة",
                    value: city,
                    items: lookupsCubit.lookupModel?.lookUpData?.cities,
                    onChanged: (v) => setState(() => city = v),
                  ),
                  _dropdown(
                    hint: "الجنس",
                    value: gender,
                    items: lookupsCubit.lookupModel?.lookUpData?.genders,
                    onChanged: (v) => setState(() => gender = v),
                  ),
                  _dropdown(
                    hint: "الجنسية",
                    value: nationality,
                    items: lookupsCubit.lookupModel?.lookUpData?.nationalities,
                    onChanged: (v) => setState(() => nationality = v),
                  ),
                  _dropdown(
                    hint: "اللغة",
                    value: language,
                    items: lookupsCubit.lookupModel?.lookUpData?.languages,
                    onChanged: (v) => setState(() => language = v),
                  ),
                  _dropdown(
                    hint: "المؤهل الدراسي",
                    value: education,
                    items:
                        lookupsCubit.lookupModel?.lookUpData?.educationLevels,
                    onChanged: (v) => setState(() => education = v),
                  ),
                  _dropdown(
                    hint: "القسم",
                    value: departement,
                    items: lookupsCubit.lookupModel?.lookUpData?.departments,
                    onChanged: (v) => setState(() => departement = v),
                  ),
                  _dropdown(
                    hint: "مقاس التيشيرت",
                    value: tshirtSize,
                    items: lookupsCubit.lookupModel?.lookUpData?.tshirtSizes,
                    onChanged: (v) => setState(() => tshirtSize = v),
                  ),
                ],
              ),
            );
          }

          if (state == CubitState.loading) {
            return const CustomLoadingWidget();
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: BlocBuilder<EditProfileCubit, CubitState>(
              builder: (context, state) {
            if (state == CubitState.loading) {
              return const CustomLoadingButtonWidget();
            }
            return CustomElevatedButton(
              onTap: () {
                context.read<EditProfileCubit>().editProfile(
                      email: emailController.text,
                      fullNameAr: arabicNameController.text,
                      fullNameEn: englishNameController.text,
                      identity: idController.text,
                      dateOfBirth: dobController.text,
                      height: heightController.text,
                      weight: weightController.text,
                      cityId: city?.value,
                      genderId: gender?.value,
                      nationalityId: nationality?.value,
                      languageId: language?.value,
                      departmentId: departement?.value,
                      educationId: education?.value,
                      tshirtSize: tshirtSize?.value,
                    );
              },
              buttonText: 'تعديل الملف الشخصي',
            );
          })),
    );
  }

  Widget _dropdown({
    required String hint,
    required LookUpItem? value,
    required List<LookUpItem>? items,
    required ValueChanged<LookUpItem?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryColor)),
            child: DropdownButton<LookUpItem>(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              value: value,
              underline: const SizedBox(),
              isExpanded: true,
              hint: Text(hint),
              items: items
                  ?.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.text ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }
}
