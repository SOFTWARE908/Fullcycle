import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullcycle/features/candidate/presentation/screens/update_bank_information_screen.dart';
import 'package:fullcycle/features/events/screens/joined_events_screen.dart';
import 'package:fullcycle/features/experience/presentation/screens/experience_screen.dart';
import 'package:fullcycle/features/profile/presentation/widgets/profile_header.dart';
import 'package:fullcycle/features/user_documents/presentation/screens/edit_personal_documents_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/services/cache/cache_helper.dart';
import 'package:fullcycle/shared/widgets/custom_divider.dart';
import '../../../../core/resources/colors.dart';
import '../../../security/screens/security_screen.dart';
import '../widgets/delete_account_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 130), child: ProfileHeader()),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 12),
              child: Text(
                'تفاصيل الملف الشخصي',
                style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  buildItem('المعلومات البنكية', 'bank',
                      () => AppNavigation.navigate(const UserBanksScreen())),
                  const CustomDivider(),
                  buildItem(
                      'مستنداتي  الشخصية',
                      'folder',
                      () => AppNavigation.navigate(
                          const EditPersonalDocumentsScreen())),
                  const CustomDivider(),
                  buildItem('الخبرات والمشاراكات', 'exp',
                      () => AppNavigation.navigate(const ExperienceScreen())),
                  const CustomDivider(),
                  GestureDetector(
                    onTap: () {
                      AppNavigation.navigate(const JoinedEventsScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.event_available_sharp,
                          ),
                          const SizedBox(width: 10),
                          const Text('فعالياتي'),
                          const Spacer(),
                          SvgPicture.asset('assets/icons/arrow.svg'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (Platform.isAndroid) ...[
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 12),
                child: Text(
                  'الإعدادات والأمان',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    buildItem('الامان', 'security',
                        () => AppNavigation.navigate(const SecurityScreen())),
                    const CustomDivider(),
                    buildItem('الاعدادت', 'settings', () {}),
                    const CustomDivider(),
                    buildItem('الاشعارات', 'notif', () {}),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 12),
                child: Text(
                  'الدعم والمعلومات',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    buildItem('المساعدة', 'help', () {}),
                    const CustomDivider(),
                    buildItem('سياسة الخصوصية', 'privacy', () {}),
                    const CustomDivider(),
                    buildItem('تعرف عنا', 'info', () {}),
                  ],
                ),
              ),
            ],
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: buildItem('تسجيل الخروج', 'logout',
                  () => CacheHelper.logOut(), AppColors.errorColor),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 50),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: buildItem('حذف الحساب', 'logout', () {
                showDeleteAccountDialog(context);
              }, AppColors.errorColor),
            ),
          ],
        ),
      ),
    );
  }

  buildItem(String title, String icon, Function function, [color]) {
    return GestureDetector(
      onTap: () => function(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/$icon.svg'),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(color: color),
            ),
            const Spacer(),
            SvgPicture.asset('assets/icons/arrow.svg'),
          ],
        ),
      ),
    );
  }
}
