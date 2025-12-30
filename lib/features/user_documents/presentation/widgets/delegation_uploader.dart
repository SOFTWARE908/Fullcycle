import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/user_documents/cubit/delegation_cubit.dart';

import '../../../../core/cubit/base_cubit_state.dart';
import 'document_uploader.dart';

class DelegationUploader extends StatefulWidget {
  const DelegationUploader({super.key});

  @override
  State<DelegationUploader> createState() => _DelegationUploaderState();
}

class _DelegationUploaderState extends State<DelegationUploader> {
  late DelegationCubit delegationCubit;

  @override
  void initState() {
    super.initState();
    delegationCubit = context.read<DelegationCubit>();
    delegationCubit.getDelegation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DelegationCubit, CubitState>(
      builder: (context, state) {
        return DocumentUploader(
          fileUrl: delegationCubit.delegationModel?.url,
          title: 'رفع ملف المفوض',
          fileName: delegationCubit.filePath ??
              delegationCubit.delegationModel?.name ??
              "لا يوجد ملف مفوض",
          onUpload: () async {
            final result = await FilePicker.platform.pickFiles();
            if (result?.files.single.path != null) {
              delegationCubit.uploadDelegation(result!.files.single.path!);
            }
          },
          onRemove: delegationCubit.remove,
          isLoading: state == CubitState.loading,
        );
      },
    );
  }
}
