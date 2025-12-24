import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/services/navigation/navigation.dart';

import '../../../../core/cubit/base_cubit_state.dart';
import '../../cubit/cv_cubit.dart';
import 'document_uploader.dart';

class CvUploader extends StatelessWidget {
  const CvUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CvCubit, CubitState>(
      builder: (context, state) {
        return DocumentUploader(
          title: 'رفع السيرة الذاتية',
          fileName: context.read<CvCubit>().filePath,
          onUpload: () async {
            final result = await FilePicker.platform.pickFiles();
            if (result?.files.single.path != null &&
                AppNavigation.context.mounted) {
              AppNavigation.context
                  .read<CvCubit>()
                  .upload(result!.files.single.path!);
            }
          },
          onRemove: context.read<CvCubit>().remove,
          isLoading: state == CubitState.loading,
        );
      },
    );
  }
}
