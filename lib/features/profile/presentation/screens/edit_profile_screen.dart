import 'package:flutter/material.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final arabicNameController =
      TextEditingController(text: "${CacheHelper.candidate?.fullNameAr}");
  final englishNameController =
      TextEditingController(text: "${CacheHelper.candidate?.fullNameEn}");
  final idController =
      TextEditingController(text: "${CacheHelper.candidate?.identity}");
  final cityController =
      TextEditingController(text: "${CacheHelper.candidate?.cityId}");
  final dobController =
      TextEditingController(text: "${CacheHelper.candidate?.dateOfBirth}");
  final nationalityController =
      TextEditingController(text: "${CacheHelper.candidate?.nationalityId}");
  final heightController =
      TextEditingController(text: "${CacheHelper.candidate?.height}");
  final weightController =
      TextEditingController(text: "${CacheHelper.candidate?.weight}");
  final sizeController =
      TextEditingController(text: "${CacheHelper.candidate?.tShirtSize}");
  final phoneController = TextEditingController(text: "---");

  String gender = CacheHelper.candidate?.genderId == 1 ? 'ذكر' : "انثى";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل حسابي"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("الهوية الشخصية"),
            buildTextField("الاسم بالعربي", arabicNameController),
            buildTextField("الاسم باللغة الانجليزية", englishNameController),
            buildTextField("رقم الهوية", idController),
            buildTextField("المدينة", cityController),

            // const Divider(height: 10),

            sectionTitle("البيانات الشخصية"),
            buildTextField("تاريخ الميلاد", dobController),
            buildDropdown("الجنس", gender, ["ذكر", "انثى"]),
            buildTextField("الجنسية", nationalityController),
            buildTextField("الطول", heightController),
            buildTextField("الوزن (كجم)", weightController),
            buildTextField("مقاس التيشرت", sizeController),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: CustomElevatedButton(
          onTap: () {},
          buttonText: 'تعديل الملف الشخصي',
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, String value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onChanged: (val) {
          setState(() => gender = val!);
        },
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child:
                      Align(alignment: Alignment.centerRight, child: Text(e)),
                ))
            .toList(),
      ),
    );
  }
}
