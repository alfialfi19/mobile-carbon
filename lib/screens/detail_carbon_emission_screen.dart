import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
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
                  page: 1,
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

  bool _isLoading = false;
  int _page = 2;

  List<EmisiLog> dataLog = [];

  @override
  void initState() {
    _scrollController.addListener(_onLoadMore);
    super.initState();
  }

  void _onLoadMore() {
    if (_scrollController.position.extentAfter <= 0 && !_isLoading) {
      _isLoading = true;

      BlocProvider.of<EmisiLogBloc>(context).add(
        LoadEmisiLog(
          page: _page,
          currentData: dataLog,
        ),
      );
      _page++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        elevation: 0.0,
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
        padding: const EdgeInsets.fromLTRB(
          30.0,
          0.0,
          30.0,
          20.0,
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
                  BlocBuilder<EmisiLogBloc, EmisiLogState>(
                    builder: (context, state) {
                      if (state is EmisiLogError) {
                        return CarbonErrorState(
                          onRefresh: _refreshEmisiLog,
                        );
                      }

                      if (state is EmisiLogEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is EmisiLogLoadingPaging) {
                        var currentData = dataLog;

                        String tempDate = DateUtil.sanitizeDateTime(
                            currentData.first.createdAt ?? "-");

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentData.length,
                              itemBuilder: (context, index) {
                                bool displayDate = true;

                                if (index != 0) {
                                  if (DateUtil.sanitizeDateTime(
                                          currentData[index].createdAt ??
                                              "-") ==
                                      tempDate) {
                                    displayDate = false;
                                  } else {
                                    tempDate = DateUtil.sanitizeDateTime(
                                        currentData[index].createdAt ?? "-");
                                  }
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (displayDate)
                                      Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 12.0,
                                          top: 24.0,
                                        ),
                                        child: Text(
                                          tempDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                color: ColorPalettes
                                                    .placeholderZill,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ),
                                    HistoryCarbonEmission(
                                      label:
                                          "${currentData[index].categoryName} ${currentData[index].categorySubName}",
                                      caption:
                                          "${currentData[index].val} ${currentData[index].unit}",
                                      pointValue:
                                          "${currentData[index].totalPoint} poin",
                                      leadingIcon: Image.asset(
                                        CarbonUtil.getEmisiIcon(
                                            currentData[index].categoryName ??
                                                "-"),
                                        height: 24.0,
                                        width: 24.0,
                                      ),
                                      leadingBackgroundColor:
                                          CarbonUtil.getEmisiBackgroundColor(
                                              currentData[index].categoryName ??
                                                  "-"),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Container(
                              color: ColorPalettes.backgroundLight,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: ColorPalettes.primary,
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      if (state is EmisiLogLoaded) {
                        _isLoading = false;

                        dataLog = state.emisiLogList;
                        String tempDate = DateUtil.sanitizeDateTime(
                            dataLog.first.createdAt ?? "-");

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataLog.length,
                          itemBuilder: (context, index) {
                            bool displayDate = true;

                            if (index != 0) {
                              if (DateUtil.sanitizeDateTime(
                                      dataLog[index].createdAt ?? "-") ==
                                  tempDate) {
                                displayDate = false;
                              } else {
                                tempDate = DateUtil.sanitizeDateTime(
                                    dataLog[index].createdAt ?? "-");
                              }
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (displayDate)
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 12.0,
                                      top: 24.0,
                                    ),
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
                                      "${dataLog[index].categoryName} ${dataLog[index].categorySubName}",
                                  caption:
                                      "${dataLog[index].val} ${dataLog[index].unit}",
                                  pointValue:
                                      "${dataLog[index].totalPoint} poin",
                                  leadingIcon: Image.asset(
                                    CarbonUtil.getEmisiIcon(
                                        dataLog[index].categoryName ?? "-"),
                                    height: 24.0,
                                    width: 24.0,
                                  ),
                                  leadingBackgroundColor:
                                      CarbonUtil.getEmisiBackgroundColor(
                                          dataLog[index].categoryName ?? "-"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      _page = 2;

                      return const CarbonLoadingState();
                    },
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
      LoadEmisiLog(page: 1),
    );
  }
}
