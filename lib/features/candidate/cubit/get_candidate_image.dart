import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/candidate/data/repository/candidate_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/user_image_model.dart';

class GetCandidateImageCubit extends Cubit<CubitState> {
  GetCandidateImageCubit() : super(CubitState.initial);

  UserImageModel? imageModel;
  XFile? currentImg;

  String? get profileImage => imageModel?.data?.url;

  Future<void> getCandidateImage() async {
    if (imageModel != null) {
      return;
    }
    emit(CubitState.loading);

    try {
      final response = await Repo.getImage();
      if (response != null) {
        imageModel = UserImageModel.fromJson(response.data);
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }
    } catch (e) {
      emit(CubitState.error);
    }
  }

  Future<void> updatePic() async {
    currentImg = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (currentImg == null) {
      return;
    }
    emit(CubitState.loading);

      final response = await Repo.updateImage(currentImg?.path);
      if (response != null) {
        emit(CubitState.done);
      } else {
        emit(CubitState.error);
      }

  }
}
