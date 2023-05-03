import 'package:flutter/material.dart';

import '../commons/commons.dart';

class ChipItem extends StatelessWidget {
  final String label;
  final bool value;
  final VoidCallback callback;

  const ChipItem({
    required this.label,
    required this.callback,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback.call(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(
          0.0,
          0.0,
          10.0,
          10.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
              color: value ? Colors.transparent : ColorPalettes.grayZill),
          gradient: value
              ? const LinearGradient(
                  colors: [
                    ColorPalettes.greenGradient2,
                    ColorPalettes.greenGradient1,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
              : const LinearGradient(
                  colors: [
                    ColorPalettes.white,
                    ColorPalettes.white,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: value ? ColorPalettes.white : ColorPalettes.dark,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.visible,
              ),
          maxLines: 1,
        ),
      ),
    );
  }
}
