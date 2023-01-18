import 'package:flutter/material.dart';

import '../commons/commons.dart';

class EcoUpdateScreen extends StatelessWidget {
  const EcoUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalettes.background,
      body: Center(
        child: Text("Eco Update Screen"),
      ),
    );
  }
}
