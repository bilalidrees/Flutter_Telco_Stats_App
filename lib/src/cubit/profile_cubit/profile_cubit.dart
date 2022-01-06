import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/cubit/home_cubit/main_menu_trending/main_menu_trending_cubit.dart';
import 'package:zong_islamic_web_app/src/model/profile.dart';
import 'package:zong_islamic_web_app/src/resource/repository/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepository profileRepository;

  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  void getProfileData(String number) async {
    emit(ProfileLoadingState());
    final Either<ProfileErrorState, Profile> eitherResponse =
        await profileRepository.getProfileData(number);
    emit(eitherResponse.fold(
      (l) => ProfileErrorState(),
      (r) => ProfileSuccessState(profle: r),
    ));
  }
}
