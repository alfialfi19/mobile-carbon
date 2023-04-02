import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';
import '../routes.dart';

class DetailTotalArticleScreen extends StatelessWidget {
  const DetailTotalArticleScreen({Key? key}) : super(key: key);

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
                  "Artikel",
                ),
              );
          },
        ),
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<ArticleRepository>(context);

            return ArticleBloc(repository)
              ..add(
                LoadArticle(
                  page: 1,
                ),
              );
          },
        ),
      ],
      child: const DetailTotalArticleContent(),
    );
  }
}

class DetailTotalArticleContent extends StatefulWidget {
  const DetailTotalArticleContent({Key? key}) : super(key: key);

  @override
  State<DetailTotalArticleContent> createState() =>
      _DetailTotalArticleContentState();
}

class _DetailTotalArticleContentState extends State<DetailTotalArticleContent> {
  final _scrollController = ScrollController();

  bool _isLoading = false;
  int _page = 2;

  List<ArticleDetail> dataLog = [];

  @override
  void initState() {
    _scrollController.addListener(_onLoadMore);
    super.initState();
  }

  void _onLoadMore() {
    if (_scrollController.position.extentAfter <= 0 && !_isLoading) {
      _isLoading = true;

      BlocProvider.of<ArticleBloc>(context).add(
        LoadArticle(
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
          "Jumlah Artikel",
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
          Routes.addArticle,
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
                                    ColorPalettes.blueGradient1,
                                    ColorPalettes.blueGradient2,
                                  ],
                                ),
                              ),
                              DetailPointComponent(
                                iconHeaderAsset: CarbonIcons.article,
                                caption: "Jumlah artikel pengguna",
                                captionColor: ColorPalettes.dark,
                                pointValue: "${data.result ?? '-'} buah",
                                pointColor: ColorPalettes.dark,
                                backgroundColor: ColorPalettes.white,
                              ),
                              DetailPointComponent(
                                iconHeaderAsset: CarbonIcons.rank,
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
                    "Riwayat Jumlah Artikel",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorPalettes.dark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ListArticleError) {
                        return CarbonErrorState(
                          onRefresh: _refreshArticle,
                        );
                      }

                      if (state is ListArticleEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is ListArticleLoadingPaging) {
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
                                      label: currentData[index].title,
                                      pointValue:
                                          "${currentData[index].totalPoint} poin",
                                      leadingIcon: Image.asset(
                                        CarbonIcons.flower,
                                        height: 24.0,
                                        width: 24.0,
                                      ),
                                      leadingBackgroundColor:
                                          ColorPalettes.green.withOpacity(0.1),
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

                      if (state is ListArticleLoaded) {
                        _isLoading = false;

                        dataLog = state.articleList;
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
                                  label: dataLog[index].title,
                                  pointValue:
                                      "${dataLog[index].totalPoint} poin",
                                  leadingIcon: Image.asset(
                                    CarbonIcons.flower,
                                    height: 24.0,
                                    width: 24.0,
                                  ),
                                  leadingBackgroundColor:
                                      ColorPalettes.green.withOpacity(0.1),
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
                  // const SizedBox(
                  //   height: 20.0,
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 12.0),
                  //   child: Text(
                  //     "Hari Ini",
                  //     style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  //           color: ColorPalettes.placeholderZill,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //   ),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Mawar Merah",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.flower,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.green.withOpacity(0.1),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Kaktus Mini Astrophytum",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.flower,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.green.withOpacity(0.1),
                  // ),
                  // HistoryCarbonEmission(
                  //   label:
                  //       "Cara budidaya Kaktus Mini Astrophytum dan cara merawatnya",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.worm,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor: ColorPalettes.red.withOpacity(0.1),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Pemeliharan Biogas",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.biogas,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor: ColorPalettes.blue.withOpacity(0.1),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 12.0),
                  //   child: Text(
                  //     "25 Februari 2022",
                  //     style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  //           color: ColorPalettes.placeholderZill,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //   ),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Pembuatan Listrik Ramah Lingkugan",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.electric,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor:
                  //       ColorPalettes.orange.withOpacity(0.1),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Cara budidaya Pohon Mangga dan cara merawatnya",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.worm,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor: ColorPalettes.red.withOpacity(0.1),
                  // ),
                  // HistoryCarbonEmission(
                  //   label: "Pemeliharan Biogas",
                  //   pointValue: "20 poin",
                  //   leadingIcon: Image.asset(
                  //     CarbonIcons.biogas,
                  //     height: 24.0,
                  //     width: 24.0,
                  //   ),
                  //   leadingBackgroundColor: ColorPalettes.blue.withOpacity(0.1),
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
    _refreshArticle();
  }

  Future<void> _refreshSummaryHistory() async {
    BlocProvider.of<SummaryHistoryBloc>(context).add(
      LoadSummaryHistory(1, "Artikel"),
    );
  }

  Future<void> _refreshArticle() async {
    BlocProvider.of<ArticleBloc>(context).add(
      LoadArticle(
        page: 1,
      ),
    );
  }
}
