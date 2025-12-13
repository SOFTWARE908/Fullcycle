import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullcycle/features/events/data/model/event_model.dart';
import 'package:fullcycle/services/date_helper.dart';

import '../../../../core/resources/colors.dart';
import '../../../../services/navigation/navigation.dart';
import '../../../events/screens/event_details_screen.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, this.isJoined});

  final EventModel event;
  final bool? isJoined;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigation.navigate(
          EventDetailsScreen(event: event, isJoined: isJoined)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/date.svg'),
                const SizedBox(width: 4),
                Text(
                  'نشر في ${(event.eventStartDate.toString().split('T').first)}',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.text),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/icons/hour.svg'),
                        const SizedBox(width: 5),
                        Text(
                          EventDateHelper.timeLeftUntil(
                              DateTime.parse(event.eventEndDate!)),
                          style: const TextStyle(fontSize: 11.4),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child: Image.asset('assets/images/loglog.png',
                          width: 40, height: 40)),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        event.eventName!,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      color: AppColors.primaryColor.withValues(alpha: .1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: AppColors.primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/lc.svg'),
                            Text(
                              '${event.cityName}',
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            buildItem('النوع : ', 'انثي - ذكر'),
            buildItem('السن : ', '18 - 24'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الوصف : ',
                  style: TextStyle(color: Color(0xff4D5761), fontSize: 16),
                ),
                Flexible(
                    child: Text(event.description ?? "",
                        style: const TextStyle(fontSize: 16))),
              ],
            ),
            const SizedBox(height: 14),
            if (event.departments?.isNotEmpty == true)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xff384250),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Specializations
                    const Text(
                      "التخصصات المطلوبة:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Wrap(
                      spacing: 3,
                      children: [
                        for (var tag in event.departments ?? [])
                          Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(tag),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  buildItem(label, title) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xff4D5761), fontSize: 16),
        ),
        Flexible(child: Text(title, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
