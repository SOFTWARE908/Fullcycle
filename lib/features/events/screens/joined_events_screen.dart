import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/main/presentation/widgets/event_card.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../../../core/resources/colors.dart';
import '../cubit/my_events_cubit.dart';

class JoinedEventsScreen extends StatefulWidget {
  const JoinedEventsScreen({super.key});

  @override
  State<JoinedEventsScreen> createState() => _JoinedEventsScreenState();
}

class _JoinedEventsScreenState extends State<JoinedEventsScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MyEventsCubit>().getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفعاليات المنضم إليها'),
        centerTitle: true,
      ),
      
      body: BlocBuilder<MyEventsCubit, CubitState>(
        builder: (_, state) {
          if (state == CubitState.done) {
            final cubit = context.read<MyEventsCubit>();
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
                            controller: searchController,
                            hintText: 'بحث عن طريق الاسم',
                            hintColor: Colors.grey,
                          )),
                      const SizedBox(width: 16),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.lightGrey
                                      .withValues(alpha: .2)),
                              borderRadius: BorderRadius.circular(8)),
                          height: 48,
                          width: 48,
                          child: Center(
                              child:
                              SvgPicture.asset('assets/icons/filter.svg')))
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, index) =>
                        EventCard(event: cubit.events[index]),
                    itemCount: cubit.events.length,
                  ),
                ),
              ],
            );
          } else if (state == CubitState.loading) {
            return const CustomLoadingWidget(padding: 50);
          } else if (state == CubitState.error) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  context.read<MyEventsCubit>().getMyEvents();

                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('حدث خطأ ما'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        'إعادة تحميل',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    Icon(Icons.refresh, color: AppColors.primaryColor)
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


