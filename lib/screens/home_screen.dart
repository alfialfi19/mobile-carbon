import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/article/article_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';

import '../repositories/repositories.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final repository = RepositoryProvider.of<AuthRepository>(context);

            return AuthBloc(repository)
              ..add(
                LoadDetailAccount(),
              );
          },
        ),
        BlocProvider<ArticleBloc>(
          create: (context) {
            final repository =
                RepositoryProvider.of<ArticleRepository>(context);

            return ArticleBloc(repository)
              ..add(
                LoadArticle(
                  1,
                  1,
                  null,
                  "Rekomendasi",
                ),
              );
          },
        ),
      ],
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
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
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is DetailAccountError) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          alignment: Alignment.center,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                    "Oops, terjadi kesalahan. Silahkan coba lagi nanti."),
                              ),
                              CarbonRoundedButton(
                                label: 'Coba lagi',
                                action: _refreshDetailAccount,
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is DetailAccountLoaded) {
                        var data = state.accountDetail;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 56.0,
                                  width: 56.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: data.file != null
                                        ? Image.network(data.file!)
                                        : Image.asset(Images.dummyProfile),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Halo, ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                              color: ColorPalettes.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: data.fullName ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                  color: ColorPalettes.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: ColorPalettes.primary
                                            .withOpacity(0.2),
                                      ),
                                      child: Text(
                                        data.levelDetail?.level ?? "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                              color: ColorPalettes.primary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.maxFinite,
                                    alignment: Alignment.centerRight,
                                    child: Stack(
                                      children: [
                                        IconButton(
                                          onPressed: () => Navigator.pushNamed(
                                            context,
                                            Routes.notification,
                                          ),
                                          icon: const Icon(
                                            Icons.notifications_rounded,
                                          ),
                                        ),
                                        Positioned(
                                          right: 15,
                                          top: 13,
                                          child: Container(
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              color: ColorPalettes.primary,
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              border: Border.all(
                                                color: ColorPalettes
                                                    .backgroundLight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 430,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    image: DecorationImage(
                                      image: const AssetImage(
                                        Images.dummyHome,
                                      ),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                        ColorPalettes.blackZill
                                            .withOpacity(0.9),
                                        BlendMode.modulate,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Apa itu Daur Karbon?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              fontSize: 18.0,
                                              color: ColorPalettes.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        "Daur karbon merupakan siklus pertukaran yang berlangsung"
                                        " terus menerus antara komponen abiotik dengan komponen"
                                        " biotik yang sudah ada di bumi sejak jutaan tahun.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                              color: ColorPalettes.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 52.0,
                            ),
                            Text(
                              "Poin yang dimiliki",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorPalettes.dark,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 190.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                children: [
                                  PointOwned(
                                    iconHeader: CarbonIcons.carbon,
                                    label: "Emisi Karbon",
                                    caption:
                                        "Jumlah emisi yang dikeluarkan pengguna",
                                    pointValue:
                                        int.parse(data.totalPoint1 ?? "0"),
                                    action: () => Navigator.pushNamed(
                                      context,
                                      Routes.detailCarbonEmission,
                                    ),
                                  ),
                                  PointOwned(
                                    iconHeader: CarbonIcons.carbon,
                                    label: "Eco-Activity",
                                    caption:
                                        "Aktivitas peduli lingkungan yang dilakukan",
                                    pointValue:
                                        int.parse(data.totalPoint2 ?? "0"),
                                    colorGradient: const LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        ColorPalettes.redGradient1,
                                        ColorPalettes.redGradient2,
                                      ],
                                    ),
                                    action: () => Navigator.pushNamed(
                                      context,
                                      Routes.detailEcoActivity,
                                    ),
                                  ),
                                  PointOwned(
                                    iconHeader: CarbonIcons.carbon,
                                    label: "Jumlah Artikel",
                                    caption:
                                        "Jumlah artikel yang sudah dipublikasikan",
                                    pointValue:
                                        int.parse(data.totalPoint3 ?? "0"),
                                    colorGradient: const LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        ColorPalettes.blueGradient1,
                                        ColorPalettes.blueGradient2,
                                      ],
                                    ),
                                    action: () => Navigator.pushNamed(
                                      context,
                                      Routes.detailTotalArticle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 52.0,
                            ),
                            Text(
                              "Fitur yang Tersedia",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorPalettes.dark,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      Routes.carbonFootprint,
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          CarbonIcons.carbonFootprint,
                                        ),
                                        Text(
                                          "Jejak Karbon",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                color: ColorPalettes.dark,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      Routes.donation,
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          CarbonIcons.donation,
                                        ),
                                        Text(
                                          "Donasi",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                color: ColorPalettes.dark,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 52.0,
                            ),
                            Text(
                              "Lencana yang Dimiliki",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: ColorPalettes.dark,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              margin: const EdgeInsets.only(right: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    ColorPalettes.greenGradient2,
                                    ColorPalettes.greenGradient1,
                                  ],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          color: ColorPalettes.white
                                              .withOpacity(0.2),
                                        ),
                                        child: Text(
                                          "${data.levelDetail?.deadlineDay ?? "0"} hari lagi",
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline
                                              ?.copyWith(
                                                color: ColorPalettes
                                                    .backgroundZill,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 27.0,
                                      ),
                                      Text(
                                        data.levelDetail?.level ?? "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                              color: ColorPalettes.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 9.0,
                                      ),
                                      Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 6.0,
                                                ),
                                                height: 16.0,
                                                width: 16.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorPalettes.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: data
                                                              .levelDetail
                                                              ?.participantList[
                                                                  0]
                                                              .file !=
                                                          null
                                                      ? Image.network(
                                                          data
                                                              .levelDetail!
                                                              .participantList[
                                                                  0]
                                                              .file!,
                                                        )
                                                      : Image.asset(
                                                          Images.dummyProfile,
                                                        ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 6.0,
                                                  left: 8.0,
                                                ),
                                                height: 16.0,
                                                width: 16.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorPalettes.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: data
                                                              .levelDetail
                                                              ?.participantList[
                                                                  1]
                                                              .file !=
                                                          null
                                                      ? Image.network(
                                                          data
                                                              .levelDetail!
                                                              .participantList[
                                                                  1]
                                                              .file!,
                                                        )
                                                      : Image.asset(
                                                          Images.dummyProfile,
                                                        ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  right: 6.0,
                                                  left: 16.0,
                                                ),
                                                height: 16.0,
                                                width: 16.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorPalettes.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: data
                                                              .levelDetail
                                                              ?.participantList[
                                                                  2]
                                                              .file !=
                                                          null
                                                      ? Image.network(
                                                          data
                                                              .levelDetail!
                                                              .participantList[
                                                                  2]
                                                              .file!,
                                                        )
                                                      : Image.asset(
                                                          Images.dummyProfile,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${data.levelDetail?.participant ?? "-"} peserta",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(
                                                  color: ColorPalettes.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    CarbonIcons.personGroup,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorPalettes.primary,
                        ),
                      );
                    },
                  ),
                  BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ListArticleError) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          alignment: Alignment.center,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                    "Oops, terjadi kesalahan. Silahkan coba lagi nanti."),
                              ),
                              CarbonRoundedButton(
                                label: 'Coba lagi',
                                action: _refreshArticle,
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is ListArticleLoaded) {
                        var data = state.articleList;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 52.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rekomendasi Artikel",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Lihat Semua",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: ColorPalettes.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            SizedBox(
                              height: 340.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length > 3 ? 3 : data.length,
                                itemBuilder: (context, index) {
                                  return MainArticleItem(
                                    articleLabel: data[index].title,
                                    authorName: data[index].writerName,
                                    articleCategory: data[index].categoryName,
                                    dateCreated: DateUtil.sanitizeDateTime(
                                        data[index].createdAt!),
                                    imageUrl: data[index].file?.first,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      return const Padding(
                        padding: EdgeInsets.only(top: 200.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorPalettes.primary,
                          ),
                        ),
                      );
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
    BlocProvider.of<AuthBloc>(context).add(
      LoadDetailAccount(),
    );
    BlocProvider.of<ArticleBloc>(context).add(
      LoadArticle(
        1,
        1,
        null,
        "Rekomendasi",
      ),
    );
  }

  Future<void> _refreshDetailAccount() async {
    BlocProvider.of<AuthBloc>(context).add(
      LoadDetailAccount(),
    );
  }

  Future<void> _refreshArticle() async {
    BlocProvider.of<ArticleBloc>(context).add(
      LoadArticle(
        1,
        1,
        null,
        "Rekomendasi",
      ),
    );
  }
}
