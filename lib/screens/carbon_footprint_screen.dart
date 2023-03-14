import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';

class CarbonFootprintScreen extends StatelessWidget {
  const CarbonFootprintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<SummaryRepository>(context);

            return SummaryEmisiLogBloc(repository)
              ..add(
                LoadSummaryEmisiLog(),
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
      child: const CarbonFootprintContent(),
    );
  }
}

class CarbonFootprintContent extends StatefulWidget {
  const CarbonFootprintContent({Key? key}) : super(key: key);

  @override
  State<CarbonFootprintContent> createState() => _CarbonFootprintContentState();
}

class _CarbonFootprintContentState extends State<CarbonFootprintContent> {
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
          40.0,
          20.0,
          20.0,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<SummaryEmisiLogBloc, SummaryEmisiLogState>(
                          builder: (context, state) {
                        if (state is SummaryEmisiLogError) {
                          return CarbonErrorState(
                            onRefresh: _refreshSummaryEmisiLog,
                          );
                        }

                        if (state is SummaryEmisiLogLoaded) {
                          var data = state.summaryEmisiLog;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.maxFinite,
                                alignment: Alignment.topCenter,
                                child: CircularPercentIndicator(
                                  radius: 70.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: double.parse(
                                          data.detail?.percentage ?? "0") /
                                      100,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "bulan ini",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                              color: ColorPalettes.grayZill,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: data.detail?.percentage ?? "-",
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
                                  backgroundColor:
                                      ColorPalettes.ecoGradient1.withOpacity(
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
                                    text:
                                        "Jumlah karbon yang telah dikeluarkan",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: ColorPalettes.grayZill,
                                          fontWeight: FontWeight.w400,
                                        ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " ${data.detail?.totalCarbon ?? '-'} Kg",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
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
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.list?.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: 200.0,
                                      child: DetailPointComponent(
                                        caption: data.list?[index].opt ?? "-",
                                        captionColor: ColorPalettes.grayZill,
                                        pointValue:
                                            "${data.list?[index].val ?? "-"} ${data.list?[index].unit ?? "-"}",
                                        pointColor: ColorPalettes.dark,
                                        backgroundColor: ColorPalettes.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }

                        return const CarbonLoadingState();
                      }),
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
                                        margin:
                                            const EdgeInsets.only(bottom: 12.0),
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
                                          "${data[index].categoryName} ${data[index].categorySubName}",
                                      caption:
                                          "${data[index].val} ${data[index].unit} -- ${data[index].createdAt}",
                                      pointValue:
                                          "${data[index].totalPoint} poin",
                                      leadingIcon: Image.asset(
                                        CarbonUtil.getEmisiIcon(
                                            data[index].categoryName ?? "-"),
                                        height: 24.0,
                                        width: 24.0,
                                      ),
                                      leadingBackgroundColor:
                                          CarbonUtil.getEmisiBackgroundColor(
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
                      //     "Hari Ini",
                      //     style:
                      //         Theme.of(context).textTheme.subtitle2?.copyWith(
                      //               color: ColorPalettes.placeholderZill,
                      //               fontWeight: FontWeight.w700,
                      //             ),
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
                      //     style:
                      //         Theme.of(context).textTheme.subtitle2?.copyWith(
                      //               color: ColorPalettes.placeholderZill,
                      //               fontWeight: FontWeight.w700,
                      //             ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    _refreshSummaryEmisiLog();
    _refreshEmisiLog();
  }

  Future<void> _refreshSummaryEmisiLog() async {
    BlocProvider.of<SummaryEmisiLogBloc>(context).add(
      LoadSummaryEmisiLog(),
    );
  }

  Future<void> _refreshEmisiLog() async {
    BlocProvider.of<EmisiLogBloc>(context).add(
      LoadEmisiLog(1),
    );
  }
}
