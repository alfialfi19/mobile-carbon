import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
import '../routes.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  List<String> _mockTitle = [
    "Kegiatan Penanaman Pohon Bakau di Pantai Balekambang",
    "Kegiatan Penanaman Pohon Mangrove di Surabaya",
    "Kegiatan Penanaman Pohon Bakau di Pantai Bawean Gresik",
    "Kegiatan Penanaman Pohon Mangrove di Sidoarjo",
    "Kegiatan Penanaman Pohon Mangrove di Gunung Anyar",
    "Kegiatan Penanaman Pohon Mangrove di Mojokerto",
  ];

  List<String> _mockAuthor = [
    "Taylor Akabane",
    "Boruto Uzumaki",
    "Sasuke Uchiha",
    "Boruto Uzumaki",
    "Haruno Sakura",
    "Taylor Akabane",
  ];

  List<String> _mockCreatedAt = [
    "10 Januari 2022",
    "7 April 2023",
    "10 Januari 2022",
    "7 April 2023",
    "10 Januari 2022",
    "7 April 2023",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Donasi",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: PullToRefresh(
          controller: _scrollController,
          onRefresh: () => _refresh(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
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
                      hintText: 'Cari donasi',
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 333,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          image: DecorationImage(
                            image: const AssetImage(
                              Images.dummyDonation,
                            ),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                              ColorPalettes.blackZill.withOpacity(0.9),
                              BlendMode.modulate,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30.0,
                        left: 20.0,
                        right: 20.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Donasi Untuk Lingkungan",
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
                              "Dengan berdonasi, kita dapat membantu "
                              "memperbaiki lingkungan sekitar kita.",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
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
                    height: 40.0,
                  ),
                  Text(
                    "Donasi Terkait",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorPalettes.dark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemCount: _mockTitle.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RelatedArticleItem(
                        margin: const EdgeInsets.only(bottom: 0.0),
                        title: _mockTitle[index],
                        author: _mockAuthor[index],
                        createdAt: _mockCreatedAt[index],
                        action: () => Navigator.pushNamed(
                          context,
                          Routes.detailArticle,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: const Divider(
                        color: ColorPalettes.line,
                      ),
                    ),
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
    await Future.delayed(const Duration(seconds: 2));
  }
}
