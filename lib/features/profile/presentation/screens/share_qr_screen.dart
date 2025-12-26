import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../candidate/cubit/share_qrcode_cubit.dart';

class ProfileQrScreen extends StatefulWidget {
  const ProfileQrScreen({super.key});

  @override
  State<ProfileQrScreen> createState() => _ProfileQrScreenState();
}

class _ProfileQrScreenState extends State<ProfileQrScreen> {
  late QrProfileCubit qrProfileCubit;

  @override
  void initState() {
    super.initState();
    qrProfileCubit = context.read<QrProfileCubit>();
    qrProfileCubit.getQRCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشاركة حسابي '),
      ),
      body: BlocBuilder<QrProfileCubit, CubitState>(
        builder: (context, state) {
          if (state == CubitState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 26),
                      child: Text(
                        'قم بمسح رمز QR الظاهر أمامك باستخدام كاميرا '
                        'هاتفك للوصول السريع إلى الصفحة المطلوبة أو لإكمال العملية.',
                        style: TextStyle(color: Color(0xff384250)),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 400,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          margin: const EdgeInsets.only(top: 30),
                          height: 380,
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffF3F4F6)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrImageView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                data:
                                    '${qrProfileCubit.qrProfileModel?.data?.qr}',
                                size: 200,
                                version: QrVersions.auto,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 12),
                                child: Text(
                                  'تصريح حضور للمشاريع',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                  "${qrProfileCubit.qrProfileModel?.data?.name}"),
                              // const SizedBox(height: 5),
                              Text("${qrProfileCubit.qrProfileModel?.data?.id}")
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset('assets/images/medal.png'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state == CubitState.loading) {
            return const CustomLoadingWidget();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
