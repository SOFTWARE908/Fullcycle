import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/core/resources/colors.dart';
import 'package:fullcycle/features/events/cubit/get_active_events_cubit.dart';
import 'package:fullcycle/features/events/data/model/event_model.dart';
import 'package:fullcycle/features/events/data/model/zone_model.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../candidate/cubit/get_qr_code_cubit.dart';

class AttendanceQrScreen extends StatefulWidget {
  const AttendanceQrScreen({super.key});

  @override
  State<AttendanceQrScreen> createState() => _AttendanceQrScreenState();
}

class _AttendanceQrScreenState extends State<AttendanceQrScreen> {
  EventModel? event;
  ZoneModel? zone;
  ZoneModel? subZone;
  String? supervisorId;

  late GetCandidateQRCodeCubit qrCodeCubit;
  late GetActiveEventsCubit eventsCubit;

  @override
  void initState() {
    super.initState();
    qrCodeCubit = context.read<GetCandidateQRCodeCubit>();
    qrCodeCubit.clearQRCode();
    eventsCubit = context.read<GetActiveEventsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رمز ال QR ')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<GetCandidateQRCodeCubit, CubitState>(
            builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              const Text('الفعالية'),
              DropdownButtonFormField<EventModel>(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                hint: Text(event?.eventName ?? 'اختر الفعالية',
                    style: const TextStyle(fontSize: 12)),
                isExpanded: true,
                padding: EdgeInsets.zero,
                items: eventsCubit.events
                    .map((e) => DropdownMenuItem<EventModel>(
                          value: e,
                          child: Text(e.eventName!),
                        ))
                    .toList(),
                onChanged: (value) {
                  event = value;
                  zone = null;
                  subZone = null;

                  setState(() {});
                  qrCodeCubit.getZones(value?.id);
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  if (event != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('المنطقة'),
                          DropdownButtonFormField<ZoneModel>(
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                            hint: Text(zone?.text ?? 'اختر المنطقة',
                                style: const TextStyle(fontSize: 12)),
                            isExpanded: true,
                            padding: EdgeInsets.zero,
                            items: qrCodeCubit.zones
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.text ?? "",
                                          style: const TextStyle(fontSize: 12)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              zone = value!;
                              setState(() {});
                              qrCodeCubit.getSubZones(event!.id,value.value);
                            },
                          ),
                        ],
                      ),
                    ),
                  if (zone != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('المنطقة الفرعية'),
                            DropdownButtonFormField<ZoneModel>(
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder()),
                              hint: Text(
                                  subZone?.text ?? 'اختر المنطقة الفرعية',
                                  style: const TextStyle(fontSize: 12)),
                              isExpanded: true,
                              padding: EdgeInsets.zero,
                              items: qrCodeCubit.subZones
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.text ?? "",
                                            style:
                                                const TextStyle(fontSize: 12)),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                subZone = value;
                                setState(() {});
                                qrCodeCubit.getQRCode(
                                    event?.id, zone?.value, subZone?.value, supervisorId);

                              },
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 30),
              (qrCodeCubit.qrLoading)
                  ? const CustomLoadingWidget(padding: 150)
                  : qrCodeCubit.qrCodeModel == null
                      ? const SizedBox.shrink()
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                QrImageView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    data: qrCodeCubit.qrCodeModel?.data?.code
                                            .toString() ??
                                        "",
                                    size: 250,
                                    version: QrVersions.auto),
                                Text(
                                  '${qrCodeCubit.qrCodeModel?.data?.code ?? ""}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'عدد الحضور',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${qrCodeCubit.qrCodeModel?.data?.count ?? ""}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
            ],
          );
        }),
      ),
      //todo

      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 30),
      //   child: CustomElevatedButton(
      //     onTap: () {
      //       qrCodeCubit.getQRCode(
      //           event?.id, zone?.value, subZone?.value, supervisorId);
      //     },
      //     buttonText: 'إعادة تحميل',
      //   ),
      // ),
    );
  }
}
