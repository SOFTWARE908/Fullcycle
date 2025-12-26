import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/base_cubit_state.dart';
import '../../cubit/cv_cubit.dart';
import 'document_uploader.dart';

class CvUploader extends StatefulWidget {
  const CvUploader({super.key});

  @override
  State<CvUploader> createState() => _CvUploaderState();
}

class _CvUploaderState extends State<CvUploader> {
  late CvCubit cvCubit;

  @override
  void initState() {
    super.initState();
    cvCubit = context.read<CvCubit>();
    cvCubit.getCV();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CvCubit, CubitState>(
      builder: (context, state) {
        return DocumentUploader(
          fileUrl: cvCubit.cvModel?.url,
          title: 'رفع السيرة الذاتية',
          fileName:
              cvCubit.filePath ?? cvCubit.cvModel?.name ?? "لا يوجد سيرة ذاتية",
          onUpload: () async {
            final result = await FilePicker.platform.pickFiles();
            if (result?.files.single.path != null) {
              cvCubit.uploadCV(result!.files.single.path!);
            }
          },
          onRemove: cvCubit.remove,
          isLoading: state == CubitState.loading,
        );
      },
    );
  }
}
