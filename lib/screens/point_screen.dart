import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/summary_rank/summary_rank_bloc.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
import '../repositories/repositories.dart';
import '../routes.dart';

class PointScreen extends StatelessWidget {
  const PointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<SummaryRepository>(context);

            return SummaryRankBloc(repository)
              ..add(
                LoadSummaryRank(
                  1,
                  "Emisi",
                ),
              );
          },
        ),
      ],
      child: const PointContent(),
    );
  }
}

class PointContent extends StatefulWidget {
  const PointContent({Key? key}) : super(key: key);

  @override
  State<PointContent> createState() => _PointContentState();
}

class _PointContentState extends State<PointContent> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorPalettes.greenGradient1,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorPalettes.ecoGradient1,
                  ColorPalettes.ecoGradient2,
                ],
              ),
            ),
          ),
          elevation: 0.0,
          toolbarHeight: 40.0,
          backgroundColor: ColorPalettes.greenGradient1,
          leading: Container(),
          leadingWidth: 0.0,
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            labelColor: ColorPalettes.white,
            unselectedLabelColor: ColorPalettes.white.withOpacity(0.5),
            labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
            onTap: (index) => BlocProvider.of<SummaryRankBloc>(context).add(
              LoadSummaryRank(
                1,
                index.toString().toTypeNameFromRankIndex(),
              ),
            ),
            tabs: const [
              Tab(
                text: 'Emisi Karbon',
              ),
              Tab(text: 'Eco-Activity'),
              Tab(
                text: 'Jumlah Artikel',
              ),
            ],
            indicatorColor: Colors.transparent,
          ),
        ),
        floatingActionButton: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
            horizontal: 27.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: ColorPalettes.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  0.0,
                  15.0,
                ),
                child: Text(
                  "Peringkatku",
                  style: Theme.of(context).textTheme.overline?.copyWith(
                        color: ColorPalettes.grayZill,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 18.0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: const PointTabSelectedRankContent(),
              ),
              InkWell(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: defaultBottomSheetShape,
                  builder: (context) => DeleteArticleBottomSheet(
                    label: "Tukar Poin",
                    caption:
                        "Penukaran poin, Anda bisa langsung menghubungi Fulan di"
                        "nomor 082134688237 / fulan@gmail.com",
                    negativeLabel: "Kembali",
                    negativeCallback: () => Navigator.pop(context),
                  ),
                ),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(
                    top: 13.0,
                    bottom: 12.0,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorPalettes.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Tukar Poin",
                    style: Theme.of(context).textTheme.overline?.copyWith(
                          color: ColorPalettes.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PointTabContent(),
            PointTabContent(),
            PointTabContent(),
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

class PointTabSelectedRankContent extends StatefulWidget {
  const PointTabSelectedRankContent({Key? key}) : super(key: key);

  @override
  State<PointTabSelectedRankContent> createState() =>
      _PointTabSelectedRankContentState();
}

class _PointTabSelectedRankContentState
    extends State<PointTabSelectedRankContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryRankBloc, SummaryRankState>(
      builder: (context, state) {
        if (state is SummaryRankError) {
          return const CarbonErrorState();
        }

        if (state is SummaryRankLoaded) {
          var data = state.summaryRank;

          return PointStandingItem(
            standingNumber: data.listSelected?.rank ?? "-",
            standingName: data.listSelected?.fullName ?? "-",
            point: data.listSelected?.totalPoint ?? "-",
          );
        }

        return const CarbonLoadingState();
      },
    );
  }
}

class PointTabContent extends StatefulWidget {
  const PointTabContent({Key? key}) : super(key: key);

  @override
  State<PointTabContent> createState() => _PointTabContentState();
}

class _PointTabContentState extends State<PointTabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SummaryRankBloc, SummaryRankState>(
      builder: (context, state) {
        if (state is SummaryRankError) {
          return const CarbonErrorState();
        }

        if (state is SummaryRankLoaded) {
          var data = state.summaryRank;

          return Container(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorPalettes.ecoGradient1,
                  ColorPalettes.ecoGradient2,
                ],
              ),
            ),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 50.0,
                        left: 50.0,
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.badge,
                        ),
                        child: Container(
                          height: 24.0,
                          width: 24.0,
                          decoration: BoxDecoration(
                            color: ColorPalettes.white,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: const Icon(
                            Icons.question_mark_rounded,
                            size: 14.0,
                            color: ColorPalettes.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 45.0,
                                  width: 45.0,
                                  child: data.list?[1].file != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            data.list![1].file!,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                            Images.dummyProfile,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    height: 14.0,
                                    width: 14.0,
                                    decoration: BoxDecoration(
                                      color: ColorPalettes.orange2,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "2",
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline
                                          ?.copyWith(
                                            fontSize: 8.0,
                                            color: ColorPalettes.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 12.0,
                                bottom: 2.0,
                              ),
                              child: Text(
                                data.list?[1].fullName ?? "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: ColorPalettes.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${data.list?[1].totalPoint ?? '-'} poin",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                    color: ColorPalettes.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 8.0,
                              ),
                              height: 46.0,
                              width: 94.0,
                              decoration: const BoxDecoration(
                                color: ColorPalettes.orange2,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    16.0,
                                  ),
                                  topRight: Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 17.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 66.0,
                                  width: 66.0,
                                  child: data.list?[0].file != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            data.list![0].file!,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                            Images.dummyProfile,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    height: 17.0,
                                    width: 17.0,
                                    decoration: BoxDecoration(
                                      color: ColorPalettes.orange2,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "1",
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline
                                          ?.copyWith(
                                            color: ColorPalettes.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 12.0,
                                bottom: 2.0,
                              ),
                              child: Text(
                                data.list?[0].fullName ?? "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: ColorPalettes.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${data.list?[0].totalPoint ?? '-'} poin",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                    color: ColorPalettes.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 8.0,
                              ),
                              height: 80.0,
                              width: 94.0,
                              decoration: const BoxDecoration(
                                color: ColorPalettes.orange2,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    16.0,
                                  ),
                                  topRight: Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 17.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 45.0,
                                  width: 45.0,
                                  child: data.list?[2].file != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            data.list![2].file!,
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                            Images.dummyProfile,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    height: 14.0,
                                    width: 14.0,
                                    decoration: BoxDecoration(
                                      color: ColorPalettes.orange2,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "3",
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline
                                          ?.copyWith(
                                            fontSize: 8.0,
                                            color: ColorPalettes.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 12.0,
                                bottom: 2.0,
                              ),
                              child: Text(
                                data.list?[2].fullName ?? "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: ColorPalettes.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${data.list?[2].totalPoint ?? '-'} poin",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                    color: ColorPalettes.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 8.0,
                              ),
                              height: 40.0,
                              width: 94.0,
                              decoration: const BoxDecoration(
                                color: ColorPalettes.orange2,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    16.0,
                                  ),
                                  topRight: Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 43.0,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorPalettes.backgroundLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        24.0,
                      ),
                      topRight: Radius.circular(
                        24.0,
                      ),
                    ),
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.list?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == 1 || index == 2) {
                        return Container();
                      }

                      return PointStandingItem(
                        standingNumber: data.list?[index].rank ?? "-",
                        standingName: data.list?[index].fullName ?? "-",
                        point: data.list?[index].totalPoint ?? "-",
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (index == 0 || index == 1 || index == 2) {
                        return Container();
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 18.0,
                        ),
                        child: const Divider(
                          color: ColorPalettes.line,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const CarbonLoadingState();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
