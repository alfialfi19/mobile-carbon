import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

class OnBoarding1Screen extends StatelessWidget {
  const OnBoarding1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingSection(
      swipeNextCallback: () => Navigator.pushNamed(
        context,
        Routes.onBoarding2,
      ),
      imageHeader: Images.onboard1,
      label: "Apa itu emisi karbon?",
      caption: "Emisi karbon adalah proses pelepasan senyawa-senyawa "
          "karbon ke atmosfer bumi akibat fenomena dan kejadian yang terjadi dalam kehidupan kita.",
      countStep: 1,
      actionLabel: "Selanjutnya",
      actionCallback: () => Navigator.pushNamed(
        context,
        Routes.onBoarding2,
      ),
    );
  }
}
