import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkSession(context);
    Timer(
      const Duration(seconds: 1),
      () => Navigator.pushReplacementNamed(context, Routes.onBoarding1),
    );
  }

  void _checkSession(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    String? token = await PrefHelper().getAccessToken();

    if (token != null) {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, Routes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.5, 0.9],
          colors: [
            ColorPalettes.primary,
            ColorPalettes.primaryLight,
          ],
        ),
      ),
      child: Image.asset(
        Images.splashLogo,
        height: 80.0,
        width: 80.0,
        fit: BoxFit.none,
      ),
    );
  }
}
