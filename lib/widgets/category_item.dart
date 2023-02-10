import 'package:flutter/material.dart';

import '../commons/commons.dart';

class CategoryItem extends StatelessWidget {
  final Widget imageActive;
  final Widget imageInactive;
  final String label;
  final bool value;
  final VoidCallback callback;

  const CategoryItem({
    Key? key,
    required this.label,
    required this.callback,
    required this.value,
    required this.imageActive,
    required this.imageInactive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback.call(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          0.0,
          52.0,
          0.0,
          43.0,
        ),
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
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
          boxShadow: [
            BoxShadow(
              color: ColorPalettes.slate.withOpacity(0.2),
              offset: const Offset(0.0, 12.0),
              blurRadius: 20.0,
            ),
            BoxShadow(
              color: ColorPalettes.slate.withOpacity(0.1),
              offset: const Offset(0.0, 4.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          children: [
            value ? imageActive : imageInactive,
            Text(
              label,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: value ? ColorPalettes.white : ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
