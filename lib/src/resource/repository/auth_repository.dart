import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/otp/otp_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  static AuthRepository? _authRepository;

  static AuthRepository? getInstance() {
    _authRepository ??= AuthRepository();
    return _authRepository;
  }

  final remoteDataSource = ZongIslamicRemoteDataSourceImpl();

  Future<Either<LoginErrorState, String>> login(String number) async {
    try {
      final menuCategories = await remoteDataSource.login(number);
      return Right(menuCategories);
    } on ServerException {
      return Left(LoginErrorState(message: ''));
    } on Exception {
      return Left(LoginErrorState(message: ''));
    }
  }

  Future<Either<OtpErrorState, String>> verifyOtp(
      String number, String code) async {
    try {
      final menuCategories = await remoteDataSource.verifyOtp(number, code);
      return Right(menuCategories);
    } on ServerException {
      return Left(OtpErrorState(message: ''));
    } on Exception {
      return Left(OtpErrorState(message: ''));
    }
  }
}
