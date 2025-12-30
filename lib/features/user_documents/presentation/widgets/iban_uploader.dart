import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/base_cubit_state.dart';
import '../../cubit/iban_cubit.dart';
import 'document_uploader.dart';

class IbanUploader extends StatefulWidget {
  const IbanUploader({super.key});

  @override
  State<IbanUploader> createState() => _IbanUploaderState();
}

class _IbanUploaderState extends State<IbanUploader> {
  late IbanCubit ibanCubit;

  @override
  void initState() {
    super.initState();
    ibanCubit = context.read<IbanCubit>();
    ibanCubit.getIban();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IbanCubit, CubitState>(
      builder: (context, state) {
        return DocumentUploader(
          fileUrl: ibanCubit.cvModel?.url,
          title: 'رفع ال Iban',
          fileName:
              ibanCubit.filePath ?? ibanCubit.cvModel?.name ?? "لا يوجد Iban",
          onUpload: () async {
            final result = await FilePicker.platform.pickFiles();
            if (result?.files.single.path != null) {
              ibanCubit.uploadIban(result!.files.single.path!);
            }
          },
          onRemove: ibanCubit.remove,
          isLoading: state == CubitState.loading,
        );
      },
    );
  }
}
