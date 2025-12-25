import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/main/presentation/widgets/event_card.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../../../core/resources/colors.dart';
import '../../../events/cubit/get_active_events_cubit.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late GetActiveEventsCubit getActiveEventsCubit;

  @override
  void initState() {
    super.initState();
    getActiveEventsCubit = context.read<GetActiveEventsCubit>();
    getActiveEventsCubit.getActiveEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفعاليات'),
        centerTitle: true,
      ),
      body: BlocBuilder<GetActiveEventsCubit, CubitState>(
        builder: (_, state) {
          if (state == CubitState.done) {
            final events = getActiveEventsCubit.filteredEvents;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomTextField(
                          hintText: 'بحث عن طريق الاسم',
                          hintColor: Colors.grey,
                          onChanged: (text) =>
                              getActiveEventsCubit.searchEvents(text),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          // If withValues() is an extension, keep it. Otherwise use withOpacity(.2)
                          border: Border.all(
                              color: AppColors.lightGrey.withValues(alpha: .2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 48,
                        width: 48,
                        child: Center(
                          child: SvgPicture.asset('assets/icons/filter.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (events.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text('لا توجد نتائج مطابقة',
                        style: TextStyle(color: Colors.grey)),
                  )
                else
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, index) =>
                          EventCard(event: events[index]),
                      itemCount: events.length,
                    ),
                  ),
              ],
            );
          } else if (state == CubitState.loading) {
            return const CustomLoadingWidget(padding: 50);
          } else if (state == CubitState.error) {
            return Center(
              child: GestureDetector(
                onTap: () => getActiveEventsCubit.getActiveEvents(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('حدث خطأ'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        'إعادة تحميل',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    Icon(Icons.refresh, color: AppColors.primaryColor),
                  ],
                ),
              ),
            );
          } else if (state == CubitState.empty) {
            return const Center(
                child: Text(
              'لا يوجد فعاليات',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            ));
          } else if (state == CubitState.userInactive) {
            return const Center(
                child: Text(
              'هذا الحساب معلق',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            ));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
