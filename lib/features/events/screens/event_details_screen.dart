import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/core/resources/colors.dart';
import 'package:fullcycle/features/events/cubit/join_event_cubit.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:geocoding/geocoding.dart';

import '../../../services/date_helper.dart';
import '../data/model/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, required this.event});
  final EventModel event;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String? placeName;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await getLocationName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/camel.png',
                  height: 260,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 200,
                  left: 10,
                  right: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          margin: const EdgeInsets.only(top: 20),
                          elevation: 0,
                          color: AppColors.primaryColor.withValues(alpha: .1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: AppColors.primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset('assets/icons/lc.svg'),
                                Text(
                                  '${widget.event.cityName}',
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            widget.event.eventName!,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/humans.png'),
                            const SizedBox(width: 5),
                            const Text('السن : 18 - 24'),
                            const SizedBox(width: 16),
                            Image.asset('assets/images/gender.png'),
                            const SizedBox(width: 5),
                            const Text('النوع : انثي - ذكر'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 10,
                    child: Container(
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
                                  DateTime.parse(widget.event.eventEndDate!)),
                              style: const TextStyle(fontSize: 11.4),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    )),
                const Positioned(
                    top: 40,
                    right: 10,
                    child: BackButton(
                      color: Colors.black,
                    )),
                Positioned(
                    top: 130,
                    right: 20,
                    child: Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.text,
                        ),
                        child: Image.asset('assets/images/loglog.png'))),
              ],
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                          text: "الوصف",
                          icon: SvgPicture.asset('assets/icons/doc.svg')),
                      Tab(
                          text: "الفترات",
                          icon: SvgPicture.asset('assets/icons/timer.svg')),
                      Tab(
                          text: "الموقع",
                          icon: SvgPicture.asset('assets/icons/location.svg')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Description Tab
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.event.description!,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const Center(child: Text("")),
                        Center(child: Text("$placeName")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: BlocBuilder<JoinEventCubit, CubitState>(builder: (_, state) {
              if (state == CubitState.loading) {
                return const CustomLoadingButtonWidget();
              }
              return CustomElevatedButton(
                onTap: () {
                  context.read<JoinEventCubit>().joinEvent(widget.event.id);
                },
                buttonText: 'قدم الآن',
              );
            }),
          )
        ],
      ),
    );
  }

  getLocationName() async {
    try {
      final placemarks = await placemarkFromCoordinates(
          widget.event.latitude!, widget.event.latitude!);

      if (placemarks.isNotEmpty) {
        placeName = placemarks.first.name;
        setState(() {});
      }
      return "Unknown location";
    } catch (e) {
      placeName = 'خطأ في جلب العنوان';
      setState(() {});
      // print("Error: $e");
    }
  }
}

// class EventDetailsScreen extends StatefulWidget {
//   const EventDetailsScreen({super.key, required this.event});
//   final EventModel event;
//
//   @override
//   State<EventDetailsScreen> createState() => _EventDetailsScreenState();
// }
//
// class _EventDetailsScreenState extends State<EventDetailsScreen> {
//   String? placeName;
//
//   @override
//   Future<void> didChangeDependencies() async {
//     super.didChangeDependencies();
//     await getLocationName();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 320,
//             child: Stack(
//               children: [
//                 Container(
//                   height: 240,
//                   width: double.infinity,
//                   padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [Color(0xff37538E), Color(0xff35415B)],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter),
//                   ),
//                   child: const Align(
//                       alignment: Alignment.topCenter,
//                       child: Text(
//                         'تفاصيل الفعالية',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                         ),
//                       )),
//                 ),
//                 Positioned(
//                   top: 120,
//                   left: 10,
//                   right: 10,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 188,
//                     decoration: BoxDecoration(
//                         boxShadow: const [
//                           BoxShadow(
//                               color: Colors.grey,
//                               blurRadius: 1,
//                               spreadRadius: 1)
//                         ],
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16)),
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 55, bottom: 10),
//                           child: Text(widget.event.eventName),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(placeName ?? "loading..."),
//                             const Icon(Icons.location_pin,
//                                 color: AppColors.primaryColor),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Card(
//                               elevation: 0,
//                               color: const Color(0xF5DCCB80)
//                                   .withValues(alpha: 0.5),
//                               child: const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('السن : 18 - 24'),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Card(
//                               elevation: 0,
//                               color: const Color(0xF5DCCB80)
//                                   .withValues(alpha: 0.5),
//                               child: const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text('النوع : انثي - ذكر'),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     top: 80,
//                     child: SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         child: Center(
//                             child:
//                                 SvgPicture.asset('assets/icons/lologo.svg')))),
//                 const Positioned(
//                     top: 36,
//                     child: BackButton(
//                       color: Colors.white,
//                     )),
//               ],
//             ),
//           ),
//           DefaultTabController(
//             length: 3,
//             child: Expanded(
//               child: Column(
//                 children: [
//                   TabBar(
//                     indicatorColor: Colors.black,
//                     labelColor: Colors.black,
//                     unselectedLabelColor: Colors.grey,
//                     tabs: [
//                       Tab(
//                           text: "الوصف",
//                           icon: SvgPicture.asset('assets/icons/doc.svg')),
//                       Tab(
//                           text: "الفترات",
//                           icon: SvgPicture.asset('assets/icons/timer.svg')),
//                       Tab(
//                           text: "الموقع",
//                           icon: SvgPicture.asset('assets/icons/location.svg')),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   const Expanded(
//                     child: TabBarView(
//                       children: [
//                         // Description Tab
//                         Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           child: SingleChildScrollView(
//                             child: Text(
//                               "تفاصيل الوظيفة:\n\nهنا تظهر تفاصيل الوظيفة هنا تظهر تفاصيل الوظيفة هنا تظهر تفاصيل الوظيفة هنا تظهر تفاصيل الوظيفة هنا تظهر تفاصيل الوظيفة هنا تظهر تفاصيل الوظيفة هنا تظهر تفاصيل الوظيفة هنا تظهر تفاصيل الوظيفة.",
//                               textAlign: TextAlign.justify,
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ),
//                         Center(child: Text("الفترات")),
//                         Center(child: Text("الموقع")),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1A3C6E),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "قدم الآن",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   getLocationName() async {
//     try {
//       final placemarks = await placemarkFromCoordinates(
//           widget.event.latitude, widget.event.latitude);
//
//       if (placemarks.isNotEmpty) {
//         placeName = placemarks.first.name;
//         setState(() {});
//       }
//       return "Unknown location";
//     } catch (e) {
//       placeName = 'خطأ في جلب العنوان';
//       setState(() {});
//       print("Error: $e");
//     }
//   }
// }
