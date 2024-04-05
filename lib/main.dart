import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:naver_map_test/presentation/main_screen.dart';

void main() async {
  await _initialize();
  runApp(const MyApp());
}

// 지도 초기화하기
Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: 'xx6avh2ob2', // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NaverMapApp(),
    );
  }
}


