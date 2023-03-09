import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';

import '../blocs/blocs.dart';
import '../repositories/repositories.dart';
import '../widgets/widgets.dart';

class DetailCarbonEmissionScreen extends StatelessWidget {
  const DetailCarbonEmissionScreen({Key? key}) : super(key: key);

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
                  "Emisi",
                ),
              );
          },
        ),
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<EmisiLogRepository>(context);

            return EmisiLogBloc(repository)
              ..add(
                LoadEmisiLog(
                  1,
                ),
              );
          },
        ),
      ],
      child: const DetailCarbonEmissionContent(),
    );
  }
}

class DetailCarbonEmissionContent extends StatefulWidget {
  const DetailCarbonEmissionContent({Key? key}) : super(key: key);

  @override
  State<DetailCarbonEmissionContent> createState() =>
      _DetailCarbonEmissionContentState();
}

class _DetailCarbonEmissionContentState
    extends State<DetailCarbonEmissionContent> {
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
      floatingActionButton: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.calculateCarbonStep1,
        ),
        child: Container(
          height: 54.0,
          width: 54.0,
          margin: const EdgeInsets.only(
            right: 10.0,
            bottom: 30.0,
          ),
          decoration: BoxDecoration(
            color: ColorPalettes.primary,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: const Icon(
            Icons.add,
            size: 32.0,
            color: ColorPalettes.white,
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
                          onRefresh: _refreshSummaryHistory,
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
                                    ColorPalettes.purpleGradient1,
                                    ColorPalettes.purpleGradient2,
                                  ],
                                ),
                              ),
                              DetailPointComponent(
                                iconHeaderAsset: CarbonIcons.article,
                                caption: "Jumlah emisi karbon",
                                captionColor: ColorPalettes.dark,
                                pointValue: "${data.result ?? '-'} kg",
                                pointColor: ColorPalettes.dark,
                                backgroundColor: ColorPalettes.white,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.carbonFootprint,
                                ),
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
                    "Riwayat Emisi Karbon",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorPalettes.dark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocBuilder<EmisiLogBloc, EmisiLogState>(
                    builder: (context, state) {
                      if (state is EmisiLogError) {
                        return CarbonErrorState(
                          onRefresh: _refreshEmisiLog,
                        );
                      }

                      if (state is EmisiLogLoaded) {
                        var data = state.emisiLogList;
                        String tempDate = DateUtil.sanitizeDateTime(
                            data.first.createdAt ?? "-");

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            bool displayDate = true;

                            if (index != 0) {
                              if (DateUtil.sanitizeDateTime(
                                      data[index].createdAt ?? "-") ==
                                  tempDate) {
                                displayDate = false;
                              } else {
                                tempDate = DateUtil.sanitizeDateTime(
                                    data[index].createdAt ?? "-");
                              }
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (displayDate)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 12.0),
                                    child: Text(
                                      tempDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color:
                                                ColorPalettes.placeholderZill,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                HistoryCarbonEmission(
                                  label:
                                      "${data[index].categoryName} ${data[index].categorySubName}",
                                  caption:
                                      "${data[index].val} ${data[index].unit} -- ${data[index].createdAt}",
                                  pointValue: "${data[index].totalPoint} poin",
                                  leadingIcon: Image.asset(
                                    EmisiUtil.getEmisiIcon(
                                        data[index].categoryName ?? "-"),
                                    height: 24.0,
                                    width: 24.0,
                                  ),
                                  leadingBackgroundColor:
                                      EmisiUtil.getEmisiBackgroundColor(
                                          data[index].categoryName ?? "-"),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      return const CarbonLoadingState();
                    },
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 12.0),
                  //   child: Text(
                  //     "19 Januari 2023",
                  //     style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  //           color: ColorPalettes.placeholderZill,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //   ),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Daging Ayam",
                  //   caption: "5,65 kg",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.food,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.orange.withOpacity(0.1),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Diesel",
                  //   caption: "12,29 kg",
                  //   pointValue: "75 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.tv,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.blue.withOpacity(0.15),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Sampah Organik",
                  //   caption: "89,12 kg",
                  //   pointValue: "126 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.trash,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.green.withOpacity(0.15),
                  // ),
                  // const SizedBox(
                  //   height: 30.0,
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 12.0),
                  //   child: Text(
                  //     "22 Desember 2022",
                  //     style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  //           color: ColorPalettes.placeholderZill,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //   ),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Diesel",
                  //   caption: "12,29 kg",
                  //   pointValue: "75 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.tv,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.blue.withOpacity(0.15),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Daging Ayam",
                  //   caption: "5,65 kg",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.food,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.orange.withOpacity(0.1),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Sampah Organik",
                  //   caption: "89,12 kg",
                  //   pointValue: "126 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.trash,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.green.withOpacity(0.15),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Diesel",
                  //   caption: "12,29 kg",
                  //   pointValue: "75 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.tv,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.blue.withOpacity(0.15),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Sampah Organik",
                  //   caption: "89,12 kg",
                  //   pointValue: "126 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.trash,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.green.withOpacity(0.15),
                  // ),
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
    _refreshSummaryHistory();
    _refreshEmisiLog();
  }

  Future<void> _refreshSummaryHistory() async {
    BlocProvider.of<SummaryHistoryBloc>(context).add(
      LoadSummaryHistory(1, "Emisi"),
    );
  }

  Future<void> _refreshEmisiLog() async {
    BlocProvider.of<EmisiLogBloc>(context).add(
      LoadEmisiLog(1),
    );
  }
}
