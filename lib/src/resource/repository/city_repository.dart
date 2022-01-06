import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/cubit/city_cubit/city_cubit.dart';
import 'package:zong_islamic_web_app/src/error/erro.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';


class CityRepository{
  static CityRepository? _city;

  static CityRepository? getInstance() {
    _city ??= CityRepository();
    return _city;
  }

  final _remoteDataSource = ZongIslamicRemoteDataSourceImpl();


  Future<Either<CityErrorState, List<String>>>
  getListOfCities() async {
    try {
      final listOfCities = await _remoteDataSource.getAllCities();
      return Right(listOfCities);
    } on ServerException {
      return const Left(CityErrorState(message: 'Server Exception'));
    } on Exception {
      return const Left(CityErrorState(message: 'Exception'));
    }
  }
}