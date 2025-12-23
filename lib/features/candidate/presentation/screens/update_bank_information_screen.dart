import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/cubit/get_candidate_banks_cubit.dart';
import 'package:fullcycle/features/candidate/cubit/validate_iban_cubit.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';
import 'package:fullcycle/shared/widgets/custom_text_field.dart';

import '../../data/models/user_banks_model.dart';

class UserBanksScreen extends StatefulWidget {
  const UserBanksScreen({super.key});

  @override
  State<UserBanksScreen> createState() => _UserBanksScreenState();
}

class _UserBanksScreenState extends State<UserBanksScreen> {
  late final GetCandidateBanksCubit getCandidateBanksCubit;
  late ValidateIbanCubit validateIbanCubit;

  final ibanController = TextEditingController();
  final delegateNameController = TextEditingController();
  final delegateIdController = TextEditingController();

  BankInfoModel? selectedBank;
  bool hasDelegate = false;

  @override
  void initState() {
    super.initState();
    validateIbanCubit = context.read<ValidateIbanCubit>();
    getCandidateBanksCubit = context.read<GetCandidateBanksCubit>();

    validateIbanCubit.getUserBankData();
    getCandidateBanksCubit.getUserBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضف بيانات البنك'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: BlocListener<ValidateIbanCubit, CubitState>(
          listener: (context, state) {
            if (validateIbanCubit.userBankDataModel != null &&
                state != CubitState.updateIban) {
              final bankData = validateIbanCubit.userBankDataModel!;

              if (bankData.bankId != null && bankData.bankName != null) {
                selectedBank = BankInfoModel(
                  text: bankData.bankName,
                  value: bankData.bankId!,
                );
              }

              ibanController.text = bankData.iBan ?? '';
              if (bankData.delegateId != null &&
                  bankData.delegateName != null) {
                hasDelegate = true;
                delegateNameController.text = bankData.delegateName ?? '';
                delegateIdController.text = bankData.delegateId ?? '';
              }

              setState(() {});
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ===== Banks Dropdown =====
              BlocBuilder<GetCandidateBanksCubit, CubitState>(
                builder: (context, state) {
                  if (state == CubitState.loading) {
                    return const CustomLoadingWidget();
                  }

                  if (state == CubitState.done) {
                    final banks =
                        getCandidateBanksCubit.userBanksModel?.data ?? [];

                    if (banks.isEmpty) {
                      return const Text('لا توجد بنوك متاحة');
                    }

                    return DropdownButtonFormField<BankInfoModel>(
                      initialValue: selectedBank,
                      decoration: const InputDecoration(
                        labelText: 'اختر بنك',
                        border: OutlineInputBorder(),
                      ),
                      items: banks
                          .map(
                            (bank) => DropdownMenuItem<BankInfoModel>(
                              value: bank,
                              child: Text(bank.text ?? ''),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedBank = value);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 20),

              /// ===== IBAN =====
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: ibanController,
                      hintText: 'رقم الـ IBAN',
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      if (selectedBank != null &&
                          ibanController.text.isNotEmpty) {
                        validateIbanCubit.validateIban(
                          ibanController.text,
                          selectedBank!.value,
                        );
                      }
                    },
                    child: const Text('تحقق'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// ===== Delegate Checkbox =====
              CheckboxListTile(
                value: hasDelegate,
                onChanged: (val) {
                  setState(() => hasDelegate = val ?? false);
                },
                title: const Text('هل يوجد مفوض؟'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              if (hasDelegate) ...[
                const SizedBox(height: 10),
                CustomTextField(
                  controller: delegateNameController,
                  hintText: 'اسم المفوض',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: delegateIdController,
                  hintText: 'رقم هوية المفوض',
                ),
              ],

              const SizedBox(height: 24),

              BlocBuilder<ValidateIbanCubit, CubitState>(
                builder: (context, state) {
                  if (state == CubitState.updateIban) {
                    return const CustomLoadingButtonWidget();
                  }

                  return CustomElevatedButton(
                    buttonText: 'إضافة بيانات البنك',
                    onTap: () {
                      validateIbanCubit.updateIban(
                        ibanController.text,
                        selectedBank?.value,
                        hasDelegate,
                        hasDelegate ? delegateIdController.text : null,
                        hasDelegate ? delegateNameController.text : null,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
