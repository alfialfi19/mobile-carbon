import 'package:flutter/material.dart';

import '../commons/commons.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class MyArticleScreen extends StatefulWidget {
  const MyArticleScreen({Key? key}) : super(key: key);

  @override
  State<MyArticleScreen> createState() => _MyArticleScreenState();
}

class _MyArticleScreenState extends State<MyArticleScreen> {
  TextEditingController searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorPalettes.backgroundLight,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Artikelku",
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
        floatingActionButton: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.addArticle,
          ),
          child: Container(
            height: 54.0,
            width: 54.0,
            margin: const EdgeInsets.only(
              left: 20.0,
              top: 10.0,
            ),
            decoration: BoxDecoration(
              color: ColorPalettes.primary,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Icon(
              Icons.add,
              size: 32.0,
              color: ColorPalettes.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
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
    return ListView(
      children: [
        SizedBox(
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
        const SizedBox(
          height: 30.0,
        ),
        RelatedArticleItem(
          title: "Cara Budidaya Tanaman Hias Di Dalam Media Pot",
          author: "Taylor Akabane",
          createdAt: "11 April 2022",
          action: () => Navigator.pushNamed(
            context,
            Routes.detailArticle,
          ),
        ),
        RelatedArticleItem(
          title: "Cara Budidaya Pohon Mangga",
          author: "Boruto Uzumaki",
          createdAt: "10 Januari 2022",
        ),
        RelatedArticleItem(
          title: "Cara Melestarikan Tanaman Enceng Gondok",
          author: "Akaba",
          createdAt: "12 Desember 2021",
        ),
        RelatedArticleItem(
          title: "Cara Budidaya Tanaman Hias Di Dalam Media Pot",
          author: "Taylor Akabane",
          createdAt: "11 April 2022",
        ),
        RelatedArticleItem(
          title: "Cara Budidaya Pohon Mangga",
          author: "Boruto Uzumaki",
          createdAt: "10 Januari 2022",
        ),
        RelatedArticleItem(
          title: "Cara Budidaya Tanaman Hias Di Dalam Media Pot",
          author: "Taylor Akabane",
          createdAt: "11 April 2022",
        ),
        RelatedArticleItem(
          title: "Cara Budidaya Pohon Mangga",
          author: "Boruto Uzumaki",
          createdAt: "10 Januari 2022",
        ),
        RelatedArticleItem(
          title: "Cara Melestarikan Tanaman Enceng Gondok",
          author: "Akaba",
          createdAt: "12 Desember 2021",
        ),
        RelatedArticleItem(
          title: "Cara Melestarikan Tanaman Enceng Gondok",
          author: "Akaba",
          createdAt: "12 Desember 2021",
        ),
      ],
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
}
