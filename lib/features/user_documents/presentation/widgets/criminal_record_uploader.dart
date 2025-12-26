import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/user_documents/cubit/fesh_cubit.dart';

import '../../../../core/cubit/base_cubit_state.dart';
import 'document_uploader.dart';

class CriminalRecordUploader extends StatefulWidget {
  const CriminalRecordUploader({super.key});

  @override
  State<CriminalRecordUploader> createState() => _CriminalRecordUploaderState();
}

class _CriminalRecordUploaderState extends State<CriminalRecordUploader> {
  late FeshCubit feshCubit;

  @override
  void initState() {
    super.initState();
    feshCubit = context.read<FeshCubit>();
    feshCubit.getFesh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FeshCubit, CubitState>(
          builder: (context, state) {
            return DocumentUploader(
              fileUrl: feshCubit.feshModel?.url,
              title: 'الملف الجنائي',
              fileName: feshCubit.filePath ??
                  feshCubit.feshModel?.name ??
                  "لا يوجد ملف جنائي",
              onUpload: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result?.files.single.path != null) {
                  feshCubit.uploadFesh(result!.files.single.path!);
                }
              },
              onRemove: feshCubit.remove,
              isLoading: state == CubitState.loading,
            );
          },
        ),
      ],
    );
  }
}
