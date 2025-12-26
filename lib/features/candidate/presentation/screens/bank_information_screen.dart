import 'package:flutter/material.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../../../core/resources/colors.dart';

class BankInformationScreen extends StatefulWidget {
  const BankInformationScreen({super.key});

  @override
  State<BankInformationScreen> createState() => _BankInformationScreenState();
}

class _BankInformationScreenState extends State<BankInformationScreen> {
  final bankNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تعديل المعلومات البنكية'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'تعديل',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'اسم البنك',
                style: TextStyle(fontSize: 16, color: AppColors.textColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: CustomTextField(controller: bankNameController),
              ),
              const Text(
                'رفع ملف الآيبان ',
                style: TextStyle(fontSize: 16, color: AppColors.textColor),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 16),
                child: Text(
                  'Maximum file size allowed is 2MB, supported file formats include .jpg, .png, and .pdf. ',
                  style: TextStyle(fontSize: 12, color: AppColors.textColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: const Text(
                  "تصفح الملفات",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 35),
          child: CustomElevatedButton(
            onTap: () {},
            buttonText: 'حفظ التغييرات',
          ),
        ),
      ),
    );
  }
}
