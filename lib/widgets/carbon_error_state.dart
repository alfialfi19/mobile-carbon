import 'package:flutter/material.dart';

import '../commons/commons.dart';
import 'widgets.dart';

class CarbonErrorState extends StatelessWidget {
  final VoidCallback? onRefresh;

  const CarbonErrorState({
    this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0,
      ),
      alignment: Alignment.center,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 20.0,
            ),
            alignment: Alignment.center,
            child: Text(
              "Oops, terjadi kesalahan. Silahkan coba lagi nanti.",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          if (onRefresh != null)
            CarbonRoundedButton(
              label: 'Coba lagi',
              action: () => onRefresh?.call(),
            ),
        ],
      ),
    );
  }
}
