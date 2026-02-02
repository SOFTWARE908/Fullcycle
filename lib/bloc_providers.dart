import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/auth/cubit/change_password_cubit.dart';
import 'package:fullcycle/features/auth/cubit/forget_password_cubit.dart';
import 'package:fullcycle/features/events/cubit/get_event_subzones_cubit.dart';
import 'package:fullcycle/features/user_documents/cubit/cv_cubit.dart';
import 'package:fullcycle/features/user_documents/cubit/iban_cubit.dart';

import 'features/auth/cubit/login_cubit.dart';
import 'features/auth/cubit/lookups_cubit.dart';
import 'features/auth/cubit/register_cubit.dart';
import 'features/candidate/cubit/attend_candidate_cubit.dart';
import 'features/candidate/cubit/get_candidate_banks_cubit.dart';
import 'features/candidate/cubit/get_candidate_experiences_cubit.dart';
import 'features/candidate/cubit/get_candidate_image.dart';
import 'features/candidate/cubit/get_qr_code_cubit.dart';
import 'features/candidate/cubit/share_qrcode_cubit.dart';
import 'features/candidate/cubit/validate_iban_cubit.dart';
import 'features/events/cubit/get_active_events_cubit.dart';
import 'features/events/cubit/get_event_zones_cubit.dart';
import 'features/events/cubit/join_event_cubit.dart';
import 'features/events/cubit/my_events_cubit.dart';
import 'features/experience/presentation/cubit/add_experience_cubit.dart';
import 'features/experience/presentation/cubit/edit_experience_cubit.dart';
import 'features/profile/cubit/edit_profile_cubit.dart';
import 'features/user_documents/cubit/delegation_cubit.dart';
import 'features/user_documents/cubit/fesh_cubit.dart';

final providers = [
  BlocProvider<GetExperiencesCubit>(create: (context) => GetExperiencesCubit()),
  BlocProvider<GetEventZonesCubit>(create: (context) => GetEventZonesCubit()),
  BlocProvider<GetEventSubZonesCubit>(
      create: (context) => GetEventSubZonesCubit()),
  BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
  BlocProvider<GetCandidateImageCubit>(
      create: (context) => GetCandidateImageCubit()),
  BlocProvider<GetActiveEventsCubit>(
      create: (context) => GetActiveEventsCubit()),
  BlocProvider<GetCandidateBanksCubit>(
      create: (context) => GetCandidateBanksCubit()),
  BlocProvider<AddExperienceCubit>(create: (context) => AddExperienceCubit()),
  BlocProvider<EditProfileCubit>(create: (context) => EditProfileCubit()),
  BlocProvider<ValidateIbanCubit>(create: (context) => ValidateIbanCubit()),
  BlocProvider<DelegationCubit>(create: (context) => DelegationCubit()),
  BlocProvider<MyEventsCubit>(create: (context) => MyEventsCubit()),
  BlocProvider<GetCandidateQRCodeCubit>(
      create: (context) => GetCandidateQRCodeCubit()),
  BlocProvider<QrProfileCubit>(create: (context) => QrProfileCubit()),
  BlocProvider<EditExperienceCubit>(create: (context) => EditExperienceCubit()),
  BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
  BlocProvider<IbanCubit>(create: (context) => IbanCubit()),
  BlocProvider<CvCubit>(create: (context) => CvCubit()),
  BlocProvider<JoinEventCubit>(create: (context) => JoinEventCubit()),
  BlocProvider<AttendCandidateCubit>(
      create: (context) => AttendCandidateCubit()),
  BlocProvider<ForgetPasswordCubit>(create: (context) => ForgetPasswordCubit()),
  BlocProvider<FeshCubit>(create: (context) => FeshCubit()),
  BlocProvider<LookupsCubit>(create: (context) => LookupsCubit()),
  BlocProvider<ChangePasswordCubit>(create: (context) => ChangePasswordCubit()),
];
