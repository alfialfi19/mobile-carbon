import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/eco_activity/eco_activity_bloc.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../repositories/repositories.dart';
import '../routes.dart';

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
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<EcoActivityRepository>(context);

            return EcoActivityBloc(repository)
              ..add(
                LoadEcoActivity(
                  1,
                  null,
                  null,
                ),
              );
          },
        ),
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
        elevation: 0.0,
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
                  BlocBuilder<EcoActivityBloc, EcoActivityState>(
                    builder: (context, state) {
                      if (state is ListEcoActivityError) {
                        return CarbonErrorState(
                          onRefresh: _refreshEcoActivity,
                        );
                      }

                      if (state is ListEcoActivityEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is ListEcoActivityLoaded) {
                        var data = state.ecoActivityList;
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
                                    label: data[index].title,
                                    pointValue:
                                        "${data[index].totalPoint} poin",
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
                            });
                      }

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
    _refreshEcoActivity();
  }

  Future<void> _refreshSummaryHistory() async {
    BlocProvider.of<SummaryHistoryBloc>(context).add(
      LoadSummaryHistory(1, "Eco"),
    );
  }

  Future<void> _refreshEcoActivity() async {
    BlocProvider.of<EcoActivityBloc>(context).add(
      LoadEcoActivity(1, null, null),
    );
  }
}
