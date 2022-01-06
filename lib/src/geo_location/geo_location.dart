import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zong_islamic_web_app/src/resource/repository/location_repository.dart';
enum GeoLocationState { initial, loading, loaded }
class GeoLocationProvider with ChangeNotifier{
  final LocationRepository _geoLocationAccess;
  GeoLocationProvider(this._geoLocationAccess){
    getPosition();
  }
  GeoLocationState _state = GeoLocationState.initial;
  GeoLocationState get state => _state;
  Position get position => _position;
  Position _position = Position(longitude: 73.0479,
      latitude: 33.6844,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);
  setGeoState(GeoLocationState stat) {
    _state = stat;
    notifyListeners();
  }
  setPosition(Position pos) {
    _position = pos;
    notifyListeners();
  }


  Future<void> getPosition()async{
    setGeoState(GeoLocationState.loading);
    await _geoLocationAccess.determinePosition().then((value) {
      print("bilal ${value.latitude},${value.longitude}");
      setPosition(value);
    });
    setGeoState(GeoLocationState.loaded);
  }
}