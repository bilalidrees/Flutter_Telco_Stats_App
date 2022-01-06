import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/resource/repository/city_repository.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityRepository cityRepository;
  CityCubit(this.cityRepository) : super(CityInitial());


  void getListOfCities() async {
    emit(const CityLoadingState());
    final Either<CityErrorState, List<String>> eitherResponse =
    await cityRepository.getListOfCities();
    emit(eitherResponse.fold(
          (l) => const CityErrorState(message: 'Something Went Wrong'),
          (r) => CitySuccessState(city: r),
    ));
  }
}
