import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/candidate/cubit/get_candidate_experiences_cubit.dart';
import 'package:fullcycle/features/experience/presentation/screens/add_experience_screen.dart';
import 'package:fullcycle/services/navigation/navigation.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';

import '../../../../core/cubit/base_cubit_state.dart';
import '../../../../core/resources/colors.dart';
import '../widgets/delete_experience_popup.dart';
import 'edit_experience_screen.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  late GetCandidateExperiencesCubit getCandidateExperiencesCubit;

  @override
  void initState() {
    super.initState();
    getCandidateExperiencesCubit = context.read<GetCandidateExperiencesCubit>();
    getCandidateExperiencesCubit.getCandidateExperiences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الخبرات والمشاراكات'),
        actions: [
          IconButton(
              onPressed: () => AppNavigation.push(const AddExperienceScreen()),
              icon: const Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      body: BlocBuilder<GetCandidateExperiencesCubit, CubitState>(
          builder: (context, state) {
        if (state == CubitState.done) {
          return ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              itemCount:
                  getCandidateExperiencesCubit.experiencesModel?.data?.length,
              itemBuilder: (context, index) {
                final experience =
                    getCandidateExperiencesCubit.experiencesModel?.data?[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    experience?.position ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'عدد سنوات الخبرة: ${experience?.years ?? 0} سنوات',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.greyText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  AppNavigation.push(
                                    EditExperienceScreen(item: experience!),
                                  );
                                } else if (value == 'delete') {
                                  showDeleteExperienceDialog(experience!.id!);
                                }
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 18),
                                      SizedBox(width: 8),
                                      Text("تعديل الخبرة"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline,
                                          size: 18, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text("مسح الخبرة"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Divider(height: 24),

                        /// Company
                        Row(
                          children: [
                            const Icon(Icons.business, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                experience?.companyName ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),

                        if ((experience?.description ?? '').isNotEmpty) ...[
                          const SizedBox(height: 12),

                          /// Description
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.description_outlined, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  experience!.description!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.greyText,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              });
        } else if (state == CubitState.loading) {
          return const CustomLoadingWidget();
        } else if (state == CubitState.empty || state == CubitState.error) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/noexp.png'),
                  const Text(
                    "لا توجد خبرات مضافة حتى الآن",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "قم بإضافة خبراتك السابقة لتظهر في ملفك الشخصي وتعزز فرصك في التقديم للفرص المناسبة.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff384250)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomElevatedButton(
                    onTap: () =>
                        AppNavigation.push(const AddExperienceScreen()),
                    buttonText: 'اضافة خبرة جديدة',
                    fontColor: const Color(0xffF5DCCB),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
