import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
import '../routes.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({Key? key}) : super(key: key);

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
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
                child: const PointStandingItem(
                  standingNumber: "1",
                  standingName: "Keyra Allisya",
                  point: "200",
                ),
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
        body: TabBarView(
          children: [
            _buildTab1Widget(context),
            _buildTab2Widget(context),
            _buildTab3Widget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTab1Widget(BuildContext context) {
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
                          const SizedBox(
                            height: 45.0,
                            width: 45.0,
                            child: CircleAvatar(
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
                                borderRadius: BorderRadius.circular(100.0),
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
                          "Andi Adinata",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.white,
                                fontWeight: FontWeight.w700,
                              ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "154 poin",
                        style: Theme.of(context).textTheme.overline?.copyWith(
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
                          const SizedBox(
                            height: 66.0,
                            width: 66.0,
                            child: CircleAvatar(
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
                                borderRadius: BorderRadius.circular(100.0),
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
                          "Keyra Allisya",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.white,
                                fontWeight: FontWeight.w700,
                              ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "200 poin",
                        style: Theme.of(context).textTheme.overline?.copyWith(
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
                          const SizedBox(
                            height: 45.0,
                            width: 45.0,
                            child: CircleAvatar(
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
                                borderRadius: BorderRadius.circular(100.0),
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
                          "Seyreen Khiel",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.white,
                                fontWeight: FontWeight.w700,
                              ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "110 poin",
                        style: Theme.of(context).textTheme.overline?.copyWith(
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
              itemCount: 15,
              itemBuilder: (context, index) {
                if (index == 0 || index == 1 || index == 2) {
                  return Container();
                }

                return PointStandingItem(
                  standingNumber: "${index + 1}",
                  standingName: "Alfonso Culhane",
                  point: "${102 - (index * 2)}",
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

  Widget _buildTab2Widget(BuildContext context) {
    return ListView(
      children: [
        Text("This is tab 2"),
        Text("Test test 2"),
        Text("Lorem ipsum til damet 2"),
      ],
    );
  }

  Widget _buildTab3Widget(BuildContext context) {
    return ListView(
      children: [
        Text("This is tab 3"),
        Text("Test test 3"),
        Text("Lorem ipsum til damet 3"),
      ],
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
