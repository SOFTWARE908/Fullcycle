import 'package:flutter/material.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';

import '../../../../core/resources/colors.dart';
import '../../../../services/dio_helper/network_downloader.dart';
import '../../../../shared/widgets/custom_button.dart';

class DocumentUploader extends StatelessWidget {
  final String title;
  final String? fileName;
  final bool isLoading;
  final VoidCallback onUpload;
  final VoidCallback onRemove;
  final String? fileUrl;

  const DocumentUploader({
    super.key,
    required this.title,
    required this.fileName,
    required this.isLoading,
    required this.onUpload,
    required this.onRemove,
    required this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 6),

        /// Subtitle
        const Text(
          'Maximum file size 2MB • JPG, PNG, PDF',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyText,
          ),
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hasFile
                  ? AppColors.primaryColor.withOpacity(0.5)
                  : AppColors.greyText.withOpacity(0.5),
            ),
          ),
          child: Column(
            children: [
              /// File Row
              Row(
                children: [
                  /// Icon
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: hasFile
                          ? AppColors.primaryColor.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      hasFile ? Icons.check_circle : Icons.insert_drive_file,
                      color:
                          hasFile ? AppColors.primaryColor : AppColors.greyText,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      fileName ?? 'لا يوجد ملف مرفوع',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: hasFile ? FontWeight.w500 : FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),

                  if (hasFile)
                    IconButton(
                      onPressed: onRemove,
                      icon: const Icon(Icons.close),
                      splashRadius: 18,
                      color: AppColors.greyText,
                    ),
                ],
              ),

              const SizedBox(height: 12),

              /// Actions
              Row(
                children: [
                  Expanded(
                    child: isLoading
                        ? const CustomLoadingWidget()
                        : CustomElevatedButton(
                            height: 40,
                            onTap: onUpload,
                            buttonText: 'رفع ملف',
                          ),
                  ),

                  /// Download
                  if (fileUrl != null && hasFile) ...[
                    const SizedBox(width: 8),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final file = await FileDownloader.downloadPdf(
                            url: fileUrl!,
                            fileName: fileName!,
                          );
                          if (file != null) {
                            debugPrint("Saved at: ${file.path}");
                          }
                        },
                        icon: const Icon(
                          Icons.download_rounded,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
