import 'package:flutter/material.dart';

import '../commons/commons.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class OnBoarding2Screen extends StatelessWidget {
  const OnBoarding2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingSection(
      imageHeader: Images.onboard2,
      label: "Apa penyebab emisi karbon?",
      caption: "Penyebab emisi karbon yang dapat kita amati yaitu"
          "penggunaan bahan bakar fosil (minyak, gas bumi, dan batu bara)"
          " untuk memenuhi kebutuhan manusia.",
      countStep: 2,
      actionLabel: "Selanjutnya",
      actionCallback: () => Navigator.pushNamed(
        context,
        Routes.onBoarding3,
      ),
    );
  }
}
