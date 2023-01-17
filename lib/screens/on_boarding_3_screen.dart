import 'package:flutter/material.dart';

import '../commons/commons.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class OnBoarding3Screen extends StatelessWidget {
  const OnBoarding3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingSection(
      imageHeader: Images.onboard3,
      label: "Apa dampak dari emisi karbon?",
      caption: "Secara umum, dampak yang dapat dirasakan dari emisi karbon"
          " yaitu meningkatnya suhu bumi per tahun dan cuaca esktrem yang"
          " menyebabkan timbulnya berbagai penyakit baru yang berevolusi.",
      countStep: 3,
      actionLabel: "Selanjutnya",
      actionCallback: () => Navigator.pushNamed(
        context,
        Routes.onBoarding4,
      ),
    );
  }
}
