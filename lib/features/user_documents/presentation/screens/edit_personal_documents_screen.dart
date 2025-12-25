import 'package:flutter/material.dart';

import '../widgets/criminal_record_uploader.dart';
import '../widgets/cv_uploader.dart';

class EditPersonalDocumentsScreen extends StatelessWidget {
  const EditPersonalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل مستنداتي الشخصية')),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          CvUploader(),
          SizedBox(height: 24),
          CriminalRecordUploader(),
          SizedBox(height: 24),
          // DelegationUploader(),
        ],
      ),
    );
  }
}
