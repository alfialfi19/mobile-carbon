import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class HistoryCarbonEmission extends StatelessWidget {
  const HistoryCarbonEmission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.orange.withOpacity(0.1),
            ),
            child: Image.asset(
              CarbonIcons.food,
              height: 24.0,
              width: 24.0,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daging Ayam",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                "5,65 kg",
                style: Theme.of(context).textTheme.overline?.copyWith(
                      color: ColorPalettes.placeholderZill,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: Text(
                "20 poin",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
