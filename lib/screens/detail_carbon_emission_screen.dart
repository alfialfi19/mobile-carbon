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
      backgroundColor: ColorPalettes.background,
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
        backgroundColor: ColorPalettes.background,
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
                  HistoryCarbonEmission(),
                  HistoryCarbonEmission(),
                  HistoryCarbonEmission(),
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
                  HistoryCarbonEmission(),
                  HistoryCarbonEmission(),
                  HistoryCarbonEmission(),
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
