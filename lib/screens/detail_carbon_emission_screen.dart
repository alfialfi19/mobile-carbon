import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../widgets/widgets.dart';

class DetailCarbonEmissionScreen extends StatefulWidget {
  const DetailCarbonEmissionScreen({Key? key}) : super(key: key);

  @override
  State<DetailCarbonEmissionScreen> createState() =>
      _DetailCarbonEmissionScreenState();
}

class _DetailCarbonEmissionScreenState
    extends State<DetailCarbonEmissionScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Emisi Karbon",
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        child: PullToRefresh(
          controller: _scrollController,
          onRefresh: () => _refresh(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      children: const [
                        DetailPointComponent(
                          iconHeader: CarbonIcons.coin,
                          caption: "Perolehan poin bulan ini",
                          pointValue: "20 poin",
                          colorGradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              ColorPalettes.purpleGradient1,
                              ColorPalettes.purpleGradient2,
                            ],
                          ),
                        ),
                        DetailPointComponent(
                          iconHeader: CarbonIcons.article,
                          caption: "Jumlah tanaman pengguna",
                          captionColor: ColorPalettes.dark,
                          pointValue: "29 buah",
                          pointColor: ColorPalettes.dark,
                          backgroundColor: ColorPalettes.white,
                        ),
                        DetailPointComponent(
                          iconHeader: CarbonIcons.pointActive,
                          caption: "Peringkat saya saat ini",
                          captionColor: ColorPalettes.dark,
                          pointValue: "17",
                          pointColor: ColorPalettes.dark,
                          backgroundColor: ColorPalettes.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Riwayat Emisi Karbon",
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
                      "19 Januari 2023",
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
