import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class PersonalInformationItem extends StatelessWidget {
  final String label;
  final String? value;
  const PersonalInformationItem({
    Key? key,
    required this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.placeholderZill,
                ),
          ),
          Text(
            value ?? "-",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
