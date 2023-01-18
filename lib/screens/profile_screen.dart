import 'package:flutter/material.dart';

import '../commons/commons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalettes.background,
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
