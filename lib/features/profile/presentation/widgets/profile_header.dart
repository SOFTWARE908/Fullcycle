import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/cubit/get_candidate_image.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';

import '../../../../core/resources/colors.dart';
import '../../../../services/cache/cache_helper.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/share_qr_screen.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late GetCandidateImageCubit userImageCubit;

  @override
  void initState() {
    super.initState();
    userImageCubit = context.read<GetCandidateImageCubit>();
    userImageCubit.getCandidateImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<GetCandidateImageCubit, CubitState>(
              builder: (context, state) {
            if (state == CubitState.done) {
              return SizedBox(
                height: 75,
                width: 75,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: (userImageCubit.currentImg != null)
                          ? FileImage(
                              File(userImageCubit.currentImg!.path),
                            )
                          : userImageCubit.profileImage != null
                              ? NetworkImage(userImageCubit.profileImage!)
                              : const NetworkImage(
                                  'https://www.shutterstock.com/image-vector/default-avatar-social-media-display-600nw-2632690107.jpg',
                                ),
                    ),

                    /// Edit button
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: GestureDetector(
                        onTap: userImageCubit.updatePic,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state == CubitState.loading) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 20, right: 5, left: 5),
                child: CustomLoadingWidget(),
              );
            }
            return const SizedBox.shrink();
          }),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                CacheHelper.candidate?.fullNameAr ?? "No name",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  _ActionButton(
                    label: "تعديل حسابي",
                    iconAsset: 'assets/icons/edit.svg',
                    function: () {
                      AppNavigation.push(const EditProfileScreen());
                    },
                  ),
                  const SizedBox(width: 8),
                  _ActionButton(
                    label: "مشاركة QR",
                    iconAsset: 'assets/icons/qr.svg',
                    function: () => AppNavigation.push(const ProfileQrScreen()),
                  ),
                ],
              ),
            ],
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
