import 'package:flutter/material.dart';

import '../commons/commons.dart';

class PointScreen extends StatelessWidget {
  const PointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalettes.background,
      body: Center(
        child: Text("Point Screen"),
      ),
    );
  }
}
