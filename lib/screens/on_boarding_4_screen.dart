import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

class OnBoarding4Screen extends StatelessWidget {
  const OnBoarding4Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingSection(
      imageHeader: Images.onboard4,
      label: "",
      caption: "Aplikasi Daur Karbon akan membantu Anda untuk"
          " memantau jejak emisi karbon yang telah Anda"
          " keluarkan dan juga memberi informasi terkait"
          " dengan lingkungan sekitar Anda.",
      countStep: 4,
      actionLabel: "Mulai",
      actionCallback: () => Navigator.pushNamed(
        context,
        Routes.signIn,
      ),
    );
  }
}
