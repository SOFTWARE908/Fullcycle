import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';

import '../../../candidate/data/models/experiences_model.dart';
import '../cubit/edit_experience_cubit.dart';

class EditExperienceScreen extends StatelessWidget {
  final ExperienceItem item;

  const EditExperienceScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final positionController = TextEditingController(text: item.position);

    final companyNameController =
        TextEditingController(text: item.companyName ?? "");

    final descriptionController =
        TextEditingController(text: item.description ?? "");

    final yearsController = TextEditingController(text: item.years.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل الخبرة"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: positionController,
              decoration: const InputDecoration(
                labelText: "المسمى الوظيفي",
                border: OutlineInputBorder(),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? "ادخل المسمى" : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: companyNameController,
              decoration: const InputDecoration(
                labelText: "اسم الشركة",
                border: OutlineInputBorder(),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? "ادخل اسم الشركة" : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "الوصف",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: yearsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "عدد سنين الخبرة",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<EditExperienceCubit, CubitState>(
                builder: (context, state) {
              if (state == CubitState.loading) {
                return const CustomLoadingWidget();
              }
              return CustomElevatedButton(
                onTap: () {
                  context.read<EditExperienceCubit>().editExperience(
                        id: item.id!,
                        position: positionController.text,
                        years: int.parse(yearsController.text),
                        description: descriptionController.text,
                        companyName: companyNameController.text,
                      );
                },
                buttonText: 'حفظ التعديلات',
              );
            })
          ],
        ),
      ),
    );
  }
}
