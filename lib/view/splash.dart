import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_lens/view/home.dart';

import '../util/color.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  splashDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => const HomeView());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: Text( 
          "Local Lens",
          style: TextStyle(
              fontSize: 35,
              color: ColorApp.kSecondary,
              fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
