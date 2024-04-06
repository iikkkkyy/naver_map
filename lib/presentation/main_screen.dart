import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

import 'main_view_model.dart';

class NaverMapApp extends StatefulWidget {
  const NaverMapApp({Key? key});
  @override
  State<NaverMapApp> createState() => _NaverMapAppState();
}

class _NaverMapAppState extends State<NaverMapApp> {
  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();
    final viewModel = context.watch<MainViewModel>();
    return MaterialApp(
      home: Scaffold(
        body: NaverMap(
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
                target: NLatLng(viewModel.longitude, viewModel.latitude),
                // 시작시 경도,위도
                zoom: 15,
                // 확대 정도
                bearing: 0,
                tilt: 0),
            indoorEnable: true, // 실내 맵 사용 가능 여부 설정
            locationButtonEnable: false, // 위치 버튼 표시 여부 설정
            consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
          ),
          onMapReady: (controller) async {
            // 지도 준비 완료 시 호출되는 콜백 함수
            mapControllerCompleter
                .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
            log("onMapReady", name: "onMapReady");
            // await viewModel.getLocationData();
            var nMarker = NMarker(id: "test", position: NLatLng(viewModel.longitude,viewModel.latitude));
            controller.addOverlay(nMarker);
            controller.updateCamera(NCameraUpdate.withParams(
                target: NLatLng(viewModel.longitude,viewModel.latitude)
            ));
          },
        ),
      ),
    );
  }
}
