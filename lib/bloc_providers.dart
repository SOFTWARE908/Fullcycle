import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/features/events/cubit/get_event_subzones_cubit.dart';
import 'features/auth/cubit/login_cubit.dart';
import 'features/auth/cubit/register_cubit.dart';
import 'features/auth/cubit/send_otp_cubit.dart';
import 'features/candidate/cubit/attend_candidate_cubit.dart';
import 'features/candidate/cubit/get_candidate_banks_cubit.dart';
import 'features/candidate/cubit/get_candidate_doc_cubit.dart';
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
import 'features/user_documents/edit_personal_document_cubit.dart';

final providers = [
  BlocProvider<GetCandidateExperiencesCubit>(
      create: (context) => GetCandidateExperiencesCubit()),
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
  BlocProvider<SendOtpCubit>(create: (context) => SendOtpCubit()),
  BlocProvider<GetCandidateDocsCubit>(
      create: (context) => GetCandidateDocsCubit()),
  BlocProvider<ValidateIbanCubit>(create: (context) => ValidateIbanCubit()),
  BlocProvider<MyEventsCubit>(create: (context) => MyEventsCubit()),
  BlocProvider<GetCandidateQRCodeCubit>(create: (context) => GetCandidateQRCodeCubit()),
  BlocProvider<QrProfileCubit>(create: (context) => QrProfileCubit()),
  BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
  BlocProvider<PersonalDocumentsCubit>(create: (context) => PersonalDocumentsCubit()),
  BlocProvider<JoinEventCubit>(create: (context) => JoinEventCubit()),
  BlocProvider<AttendCandidateCubit>(create: (context) => AttendCandidateCubit()),
];
