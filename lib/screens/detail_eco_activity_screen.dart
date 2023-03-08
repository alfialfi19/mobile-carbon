import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../repositories/repositories.dart';

class DetailEcoActivityScreen extends StatelessWidget {
  const DetailEcoActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<SummaryRepository>(context);

            return SummaryHistoryBloc(repository)
              ..add(
                LoadSummaryHistory(
                  1,
                  "Eco",
                ),
              );
          },
        ),
        // BlocProvider(
        //   create: (context) {
        //     final repository =
        //         RepositoryProvider.of<EcoActivityRepository>(context);
        //
        //     return EmisiLogBloc(repository)
        //       ..add(
        //         LoadEmisiLog(
        //           1,
        //         ),
        //       );
        //   },
        // ),
      ],
      child: const DetailEcoActivityContent(),
    );
  }
}

class DetailEcoActivityContent extends StatefulWidget {
  const DetailEcoActivityContent({Key? key}) : super(key: key);

  @override
  State<DetailEcoActivityContent> createState() =>
      _DetailEcoActivityContentState();
}

class _DetailEcoActivityContentState extends State<DetailEcoActivityContent> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Eco-Activity",
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
          onRefresh: _refresh,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<SummaryHistoryBloc, SummaryHistoryState>(
                    builder: (context, state) {
                      if (state is SummaryHistoryError) {
                        return CarbonErrorState(
                          onRefresh: _refresh,
                        );
                      }

                      if (state is SummaryHistoryLoaded) {
                        var data = state.summaryHistory;

                        return SizedBox(
                          height: 150.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            children: [
                              DetailPointComponent(
                                iconHeaderAsset: CarbonIcons.coin,
                                caption: "Perolehan poin bulan ini",
                                pointValue: "${data.totalPoint ?? '-'} poin",
                                colorGradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    ColorPalettes.redGradient1,
                                    ColorPalettes.redGradient2,
                                  ],
                                ),
                              ),
                              DetailPointComponent(
                                iconHeaderAsset: CarbonIcons.article,
                                caption: "Jumlah tanaman pengguna",
                                captionColor: ColorPalettes.dark,
                                pointValue: "${data.result ?? '-'} buah",
                                pointColor: ColorPalettes.dark,
                                backgroundColor: ColorPalettes.white,
                              ),
                              DetailPointComponent(
                                iconHeaderAsset: CarbonIcons.pointActive,
                                caption: "Peringkat saya saat ini",
                                captionColor: ColorPalettes.dark,
                                pointValue: data.rank ?? "-",
                                pointColor: ColorPalettes.dark,
                                backgroundColor: ColorPalettes.white,
                              ),
                            ],
                          ),
                        );
                      }

                      return const CarbonLoadingState();
                    },
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Riwayat Eco-Activity",
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
                    label: "Mawar Merah",
                    pointValue: "20 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.flower,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.1),
                  ),
                  HistoryCarbonEmission(
                    label: "Kaktus Mini Astrophytum",
                    pointValue: "20 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.flower,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.1),
                  ),
                  HistoryCarbonEmission(
                    label: "Pohon Mangga",
                    pointValue: "20 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.flower,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      "15 April 2022",
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ColorPalettes.placeholderZill,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  HistoryCarbonEmission(
                    label: "Mawar Merah",
                    pointValue: "20 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.flower,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.1),
                  ),
                  HistoryCarbonEmission(
                    label: "Anggrek Dendronium",
                    pointValue: "15 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.flower,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.1),
                  ),
                  HistoryCarbonEmission(
                    label: "Pohon Mangga",
                    pointValue: "20 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.flower,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.1),
                  ),
                  HistoryCarbonEmission(
                    label: "Pohon Mangrove",
                    pointValue: "25 poin",
                    leadingIcon: Image.asset(
                      CarbonIcons.flower,
                      height: 24.0,
                      width: 24.0,
                    ),
                    leadingBackgroundColor:
                        ColorPalettes.green.withOpacity(0.1),
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
    BlocProvider.of<SummaryHistoryBloc>(context).add(
      LoadSummaryHistory(1, "Eco"),
    );
  }
}
