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
  @override
  void initState() {
    super.initState();
    context.read<GetActiveEventsCubit>().getActiveEvents();
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
          final cubit = context.read<GetActiveEventsCubit>();

          if (state == CubitState.done) {
            final events = cubit.filteredEvents;

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
                          onChanged: (text) => context
                              .read<GetActiveEventsCubit>()
                              .searchEvents(text),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          // If withValues() is an extension, keep it. Otherwise use withOpacity(.2)
                          border: Border.all(
                              color: AppColors.lightGrey.withOpacity(.2)),
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
                onTap: () =>
                    context.read<GetActiveEventsCubit>().getActiveEvents(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('حدث خطأ ما'),
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
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// Widget buildEventCard(EventModel event) {
//   return GestureDetector(
//     onTap: () {
//       AppNavigation.navigate(EventDetailsScreen(event: event));
//     },
//     child: Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.1),
//             blurRadius: 6,
//             spreadRadius: 2,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 88,
//                 width: 88,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffFF630B),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Center(
//                     child: SvgPicture.asset('assets/icons/wrda.svg',
//                         width: 40, height: 40)),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       event.eventName,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         SvgPicture.asset('assets/icons/locloc.svg'),
//                         const SizedBox(width: 4),
//                         const Text("هنا تظهر تفاصيل العنوان"),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         SvgPicture.asset('assets/icons/date.svg'),
//                         const SizedBox(width: 4),
//                         const Text("تم النشر منذ يوم"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 12),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(child: Text("الفترة : ${event.startTime} إلى ${event.endTime}")),
//               const Text("السن : 18 - 24"),
//               const Text("النوع : ذكر / أنثى"),
//             ],
//           ),
//
//           const SizedBox(height: 12),
//
//           // Specializations
//           const Text(
//             "التخصصات المطلوبة:",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Wrap(
//             spacing: 8,
//             children: [
//               for (var tag in ["اسم التخصص", "اسم التخصص", "اسم التخصص"])
//                 Card(
//                   elevation: 0,
//                   color: Colors.amber.withValues(alpha: .3),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       tag,
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   final searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<GetActiveEventsCubit>().getActiveEvents();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 150,
//             floating: false,
//             pinned: true,
//             automaticallyImplyLeading: false,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xff35415B), Color(0xff37538E)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: FlexibleSpaceBar(
//                 centerTitle: true,
//                 background: Padding(
//                   padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
//                   child: Row(
//                     children: [
//                       Flexible(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4),
//                           child: CustomTextField(
//                             hintText: "بحث عن طريق الاسم",
//                             prefixIcon: const Icon(Icons.search),
//                             controller: searchController,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: IconButton(
//                           icon: SvgPicture.asset('assets/icons/filter.svg'),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 title: const Padding(
//                   padding: EdgeInsets.only(bottom: 60),
//                   child: Text(
//                     "الفعاليات",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           BlocBuilder<GetActiveEventsCubit, CubitState>(
//             builder: (context, state) {
//               if (state == CubitState.done) {
//                 final cubit = context.read<GetActiveEventsCubit>();
//                 return SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) => buildEventCard(cubit.events[index]),
//                     childCount: cubit.events.length,
//                   ),
//                 );
//               } else if (state == CubitState.loading) {
//                 return const SliverToBoxAdapter(
//                   child: CustomLoadingWidget(padding: 50),
//                 );
//               }
//               return const SliverToBoxAdapter(child: SizedBox.shrink());
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildEventCard(EventModel event) {
//     return GestureDetector(
//       onTap: () {
//         AppNavigation.navigate(EventDetailsScreen(event: event));
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withValues(alpha: 0.1),
//               blurRadius: 6,
//               spreadRadius: 2,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//              Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 88,
//                   width: 88,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffFF630B),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                       child: SvgPicture.asset('assets/icons/wrda.svg',
//                           width: 40, height: 40)),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         event.eventName,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           SvgPicture.asset('assets/icons/locloc.svg'),
//                           const SizedBox(width: 4),
//                           const Text("هنا تظهر تفاصيل العنوان"),
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           SvgPicture.asset('assets/icons/date.svg'),
//                           const SizedBox(width: 4),
//                           const Text("تم النشر منذ يوم"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(child: Text("الفترة : ${event.startTime} إلى ${event.endTime}")),
//                 const Text("السن : 18 - 24"),
//                 const Text("النوع : ذكر / أنثى"),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             // Specializations
//             const Text(
//               "التخصصات المطلوبة:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 8,
//               children: [
//                 for (var tag in ["اسم التخصص", "اسم التخصص", "اسم التخصص"])
//                   Card(
//                     elevation: 0,
//                     color: Colors.amber.withValues(alpha: .3),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         tag,
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
