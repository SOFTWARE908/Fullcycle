import 'package:flutter/material.dart';

import '../widgets/cv_uploader.dart';
import '../widgets/delegation_uploader.dart';
import '../widgets/fesh_uploader.dart';
import '../widgets/iban_uploader.dart';

class EditPersonalDocumentsScreen extends StatelessWidget {
  const EditPersonalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل مستنداتي الشخصية')),
      body: const SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CvUploader(),
            SizedBox(height: 15),
            FeshUploader(),
            SizedBox(height: 15),
            IbanUploader(),
            SizedBox(height: 15),
            DelegationUploader(),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
