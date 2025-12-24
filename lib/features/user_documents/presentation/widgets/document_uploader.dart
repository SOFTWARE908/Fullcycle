import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';

import '../../../../core/resources/colors.dart';
import '../../../../shared/widgets/custom_button.dart';

class DocumentUploader extends StatelessWidget {
  final String title;
  final String? fileName;
  final bool isLoading;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  const DocumentUploader({
    super.key,
    required this.title,
    required this.fileName,
    required this.isLoading,
    required this.onUpload,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, color: AppColors.textColor)),
        const SizedBox(height: 8),
        const Text(
          'Maximum file size allowed is 2MB, supported file formats include .jpg, .png, and .pdf.',
          style: TextStyle(fontSize: 12, color: AppColors.textColor),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  border: Border.all(color: AppColors.greyText),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    if (hasFile) SvgPicture.asset('assets/icons/iconGreen.svg'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        fileName ?? "لا يوجد ملف مرفوع",
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (hasFile)
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onRemove,
                        icon: const Icon(Icons.clear),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            isLoading
                ? const CustomLoadingWidget()
                : CustomElevatedButton(
                    padding: 10,
                    width: 90,
                    height: 36,
                    color: Colors.black,
                    onTap: onUpload,
                    buttonText: "رفع الملف",
                  ),
          ],
        ),
      ],
    );
  }
}
