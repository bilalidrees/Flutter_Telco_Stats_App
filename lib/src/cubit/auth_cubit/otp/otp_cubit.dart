import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/resource/repository/auth_repository.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepository authRepository;
  OtpCubit(this.authRepository) : super(OtpInitial());



  void getOtp(String number, String code) async {
    emit(OtpLoadingState());
    final Either<OtpErrorState, String> eitherResponse =
    (await authRepository.verifyOtp(number, code));
    emit(eitherResponse.fold(
          (l) => OtpErrorState(message: 'Something Went Wrong'),
          (r) => OtpSuccessState(string: r),
    ));
  }
}
