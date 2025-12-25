import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/cubit/get_candidate_image.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';

import '../../../../core/resources/colors.dart';
import '../../../../services/cache/cache_helper.dart';
import '../screens/share_qr_screen.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 56, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<GetCandidateImageCubit, CubitState>(
              builder: (context, state) {
            if (state == CubitState.done) {
              return CircleAvatar(
                radius: 37,
                backgroundImage: MemoryImage(base64Decode(context
                    .read<GetCandidateImageCubit>()
                    .imageModel!
                    .data!
                    .base64Data!)),
              );
            } else if (state == CubitState.loading) {
              return const CustomLoadingWidget();
            }
            return const SizedBox.shrink();
          }),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CacheHelper.candidate?.fullNameAr ?? "No name",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // _ActionButton(
                    //   label: "تعديل حسابي",
                    //   iconAsset: 'assets/icons/edit.svg',
                    //   function: () {
                    //     AppNavigation.navigate(const EditProfileScreen());
                    //   },
                    // ),
                    // const SizedBox(width: 8),
                    _ActionButton(
                      label: "مشاركة QR",
                      iconAsset: 'assets/icons/qr.svg',
                      function: () {
                        AppNavigation.push(const ProfileQrScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final String iconAsset;
  final Function function;

  const _ActionButton({
    required this.label,
    required this.iconAsset,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.grey,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      onPressed: () => function(),
      icon: SvgPicture.asset(iconAsset),
      label: Text(label),
    );
  }
}
