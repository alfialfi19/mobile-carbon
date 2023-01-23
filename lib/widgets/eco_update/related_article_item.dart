import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class RelatedArticleItem extends StatelessWidget {
  const RelatedArticleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            height: 61.0,
            width: 61.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Image.asset(
              Images.dummyPlant2,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    "Cara Budidaya Tanaman Hias Di Dalam Media Pot",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorPalettes.dark,
                          fontWeight: FontWeight.w700,
                        ),
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Taylor Akabane",
                      style: Theme.of(context).textTheme.overline?.copyWith(
                            color: ColorPalettes.grayZill,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 5.0,
                      width: 5.0,
                      decoration: BoxDecoration(
                        color: ColorPalettes.grayDivider,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Text(
                      "11 April 2022",
                      style: Theme.of(context).textTheme.overline?.copyWith(
                            color: ColorPalettes.grayZill,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
