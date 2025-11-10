import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullcycle/core/resources/colors.dart';
import 'package:fullcycle/features/attendance/screens/add_qr_screen.dart';
import 'package:fullcycle/features/main/presentation/screens/events_screen.dart';
import 'package:fullcycle/features/profile/presentation/screens/profile_screen.dart';

import '../../../profile/presentation/screens/qr_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  changeIndex(index) {
    currentIndex = index;
    setState(() {});
  }

  final pages = [
    const EventsScreen(),
    const AddQrScreen(),
    const AttendanceQrScreen(),
    const ProfileScreen(),
  ];
  final titles = [
    'الرئيسية',
    'الحضور',
    'قم بالتحضير',
    'حسابي',
  ];
  final icons = [
    'assets/icons/home.svg',
    'assets/icons/qr.svg',
    'assets/icons/qr.svg',
    'assets/icons/profile.svg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.grey,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: changeIndex,
            fixedColor: AppColors.primaryColor,
            elevation: 0,
            items: List.generate(4, (index) {
              return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  icons[index],
                  color: currentIndex == index
                      ? AppColors.primaryColor
                      : Colors.black, // or AppColors.unselectedIconColor
                ),
                label: titles[index],
              );
            })));
  }
}
