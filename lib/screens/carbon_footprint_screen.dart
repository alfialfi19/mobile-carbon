import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../commons/commons.dart';

class CarbonFootprintScreen extends StatefulWidget {
  const CarbonFootprintScreen({Key? key}) : super(key: key);

  @override
  State<CarbonFootprintScreen> createState() => _CarbonFootprintScreenState();
}

class _CarbonFootprintScreenState extends State<CarbonFootprintScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Jejak Karbon",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 18.0,
                color: ColorPalettes.dark,
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: ColorPalettes.backgroundLight,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: ColorPalettes.dark,
          ),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          40.0,
          20.0,
          20.0,
          20.0,
        ),
        child: PullToRefresh(
          controller: _scrollController,
          onRefresh: () => _refresh(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.topCenter,
                    child: CircularPercentIndicator(
                      radius: 70.0,
                      lineWidth: 10.0,
                      animation: true,
                      percent: 37 / 100,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "bulan ini",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.grayZill,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "37",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                    color: ColorPalettes.dark,
                                    fontWeight: FontWeight.w700,
                                  ),
                              children: [
                                TextSpan(
                                  text: "%",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: ColorPalettes.ecoGradient1.withOpacity(
                        0.2,
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      linearGradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorPalettes.ecoGradient1,
                          ColorPalettes.ecoGradient3,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: "Jumlah karbon yang telah dikeluarkan",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.grayZill,
                              fontWeight: FontWeight.w400,
                            ),
                        children: [
                          TextSpan(
                            text: " 172 Kg",
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: ColorPalettes.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 41.0,
                  ),
                  SizedBox(
                    height: 156.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        SizedBox(
                          width: 156.0,
                          child: DetailPointComponent(
                            iconHeader: CarbonIcons.car,
                            caption: "Transportasi",
                            captionColor: ColorPalettes.grayZill,
                            pointValue: "26 Kg",
                            pointColor: ColorPalettes.dark,
                            backgroundColor: ColorPalettes.white,
                          ),
                        ),
                        SizedBox(
                          width: 156.0,
                          child: DetailPointComponent(
                            iconHeader: CarbonIcons.food2,
                            caption: "Makanan",
                            captionColor: ColorPalettes.grayZill,
                            pointValue: "21 Kg",
                            pointColor: ColorPalettes.dark,
                            backgroundColor: ColorPalettes.white,
                          ),
                        ),
                        SizedBox(
                          width: 156.0,
                          child: DetailPointComponent(
                            iconHeader: CarbonIcons.tv2,
                            caption: "Alat Elektronik",
                            captionColor: ColorPalettes.grayZill,
                            pointValue: "20 Kg",
                            pointColor: ColorPalettes.dark,
                            backgroundColor: ColorPalettes.white,
                          ),
                        ),
                        SizedBox(
                          width: 156.0,
                          child: DetailPointComponent(
                            iconHeader: CarbonIcons.cloth,
                            caption: "Pembelian Pakaian",
                            captionColor: ColorPalettes.grayZill,
                            pointValue: "17 Kg",
                            pointColor: ColorPalettes.dark,
                            backgroundColor: ColorPalettes.white,
                          ),
                        ),
                        SizedBox(
                          width: 156.0,
                          child: DetailPointComponent(
                            iconHeader: CarbonIcons.trash2,
                            caption: "Sampah",
                            captionColor: ColorPalettes.grayZill,
                            pointValue: "9 Kg",
                            pointColor: ColorPalettes.dark,
                            backgroundColor: ColorPalettes.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 58.0,
                  ),
                  Text(
                    "Riwayat Jejak Karbon",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorPalettes.dark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      "Hari Ini",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ColorPalettes.placeholderZill,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  HistoryCarbonEmission(
                    label: "Daging Ayam",
                    caption: "5,65 kg",
                    pointValue: "20 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.food,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.orange.withOpacity(0.1),
                  ),
                  HistoryCarbonEmission(
                    label: "Diesel",
                    caption: "12,29 kg",
                    pointValue: "75 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.tv,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.blue.withOpacity(0.15),
                  ),
                  HistoryCarbonEmission(
                    label: "Sampah Organik",
                    caption: "89,12 kg",
                    pointValue: "126 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.trash,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.15),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      "22 Desember 2022",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ColorPalettes.placeholderZill,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  HistoryCarbonEmission(
                    label: "Diesel",
                    caption: "12,29 kg",
                    pointValue: "75 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.tv,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.blue.withOpacity(0.15),
                  ),
                  HistoryCarbonEmission(
                    label: "Daging Ayam",
                    caption: "5,65 kg",
                    pointValue: "20 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.food,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.orange.withOpacity(0.1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
