import 'package:flutter/material.dart';

import '../../commons/commons.dart';

class RelatedArticleItem extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? author;
  final String? createdAt;
  final VoidCallback? action;
  final EdgeInsets? margin;

  const RelatedArticleItem({
    Key? key,
    this.imageUrl,
    this.title,
    this.author,
    this.createdAt,
    this.action,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action?.call(),
      child: Container(
        margin: margin ?? const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Container(
              height: 61.0,
              width: 61.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: imageUrl != null
                  ? Image.network(imageUrl!)
                  : Image.asset(
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
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      title ?? "-",
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
                        author ?? "-",
                        style: Theme.of(context).textTheme.overline?.copyWith(
                              color: ColorPalettes.grayZill,
                              fontWeight: FontWeight.w400,
                            ),
                        overflow: TextOverflow.ellipsis,
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
                      Expanded(
                        flex: 3,
                        child: Text(
                          createdAt ?? "-",
                          style: Theme.of(context).textTheme.overline?.copyWith(
                                color: ColorPalettes.grayZill,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
