import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:naver_map_test/data/data_source/my_locate.dart';

class MainViewModel extends ChangeNotifier {
  // final NaverMapController _mapController;
  double longitude = 36.8431728;
  double latitude = 127.173850;

  // MainViewModel(this._mapController);

  // 기존 naver_map_plugin에서 사용하는 LocationService는 사용불가
  // GeoLocator로 구현
  Future<void> getLocationData() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getCurrentLocation();
    longitude = myLocation.longitude;
    latitude = myLocation.latitude;
    final cameraUpdate = NCameraUpdate.withParams(
      target: NLatLng(longitude,latitude)
    );
    notifyListeners();
  }
}
