import 'package:flutter/material.dart';

class TransparentLoadingDialog extends StatelessWidget {
  const TransparentLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        height: 280,
        width: 280,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
