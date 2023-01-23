import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class EcoUpdateScreen extends StatefulWidget {
  const EcoUpdateScreen({Key? key}) : super(key: key);

  @override
  State<EcoUpdateScreen> createState() => _EcoUpdateScreenState();
}

class _EcoUpdateScreenState extends State<EcoUpdateScreen> {
  TextEditingController searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorPalettes.backgroundLight,
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 120.0,
          backgroundColor: ColorPalettes.backgroundLight,
          leading: Container(),
          leadingWidth: 0.0,
          centerTitle: true,
          title: SizedBox(
            height: 58.0,
            child: TextField(
              controller: searchController,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                labelStyle: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.placeholderZill,
                      fontWeight: FontWeight.w400,
                    ),
                hintText: 'Cari artikel',
                hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.placeholderZill,
                      fontWeight: FontWeight.w400,
                    ),
                suffixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    100.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorPalettes.line,
                  ),
                  borderRadius: BorderRadius.circular(
                    100.0,
                  ),
                ),
                focusColor: ColorPalettes.primary,
                filled: true,
                fillColor: ColorPalettes.grayTextField,
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: ColorPalettes.dark,
            unselectedLabelColor: ColorPalettes.placeholderZill,
            labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
            tabs: const [
              Tab(
                text: 'Tanamanku',
              ),
              Tab(text: 'Manggot'),
              Tab(
                text: 'Biogas',
              ),
              Tab(
                text: 'Listrik Ramah Lingkungan',
              ),
            ],
            indicatorColor: Colors.transparent,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 20.0,
          ),
          child: TabBarView(
            children: [
              _buildTab1Widget(context),
              _buildTab2Widget(context),
              _buildTab3Widget(context),
              _buildTab4Widget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab1Widget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: const AssetImage(
                      Images.dummyPlant,
                    ),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      ColorPalettes.black.withOpacity(0.4),
                      BlendMode.luminosity,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 20.0,
                right: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pengaruh Emisi Karbon Terhadap Tanaman Hidroponik",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 18.0,
                            color: ColorPalettes.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          height: 24.0,
                          width: 24.0,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              Images.dummyProfile,
                            ),
                          ),
                        ),
                        Text(
                          "Serean Waiyene",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: 5.0,
                          width: 5.0,
                          decoration: BoxDecoration(
                            color: ColorPalettes.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        Text(
                          "11 April 2022",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.white,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            "Artikel Terkait",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          RelatedArticleItem(),
          RelatedArticleItem(),
          RelatedArticleItem(),
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

  Widget _buildTab4Widget(BuildContext context) {
    return ListView(
      children: [
        Text("This is tab 4"),
        Text("Test test 4"),
        Text("Lorem ipsum til damet 4"),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
