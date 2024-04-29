import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_lens/util/color.dart';
import 'package:local_lens/view/splash.dart';

import 'binding/controllerbinding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyAryKD2CsAxfzKbltErSbsAVIEfmgCVySo",
            appId: "1:654509187366:android:8d6a06cbc09d626c2f21e7",
            messagingSenderId: "654509187366",
            projectId: "local-lens-ce688",
            storageBucket: "local-lens-ce688.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Lens',
      theme: ThemeData(
        primaryColor: ColorApp.kPrimary,
        appBarTheme:
            const AppBarTheme(elevation: 1, backgroundColor: Colors.white),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: ControllerBinding(),
      home: const SplashView(),
    );
  }
}
