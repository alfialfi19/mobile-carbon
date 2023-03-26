import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class EcoUpdateScreen extends StatelessWidget {
  const EcoUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EcoActivityBloc>(
          create: (context) {
            final repository =
                RepositoryProvider.of<EcoActivityRepository>(context);

            return EcoActivityBloc(repository)
              ..add(
                LoadEcoActivity(
                  page: 1,
                  category: 1,
                ),
              );
          },
        ),
      ],
      child: const EcoUpdateContent(),
    );
  }
}

class EcoUpdateContent extends StatefulWidget {
  const EcoUpdateContent({Key? key}) : super(key: key);

  @override
  State<EcoUpdateContent> createState() => _EcoUpdateContentState();
}

class _EcoUpdateContentState extends State<EcoUpdateContent> {
  TextEditingController searchController = TextEditingController();
  final _scrollController = ScrollController();
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorPalettes.backgroundLight,
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 80.0,
          backgroundColor: ColorPalettes.backgroundLight,
          leading: Container(),
          leadingWidth: 0.0,
          centerTitle: true,
          title: Container(
            height: 58.0,
            margin: const EdgeInsets.only(
              top: 40.0,
            ),
            child: TextField(
              controller: searchController,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
              onSubmitted: (value) =>
                  BlocProvider.of<EcoActivityBloc>(context).add(
                LoadEcoActivity(
                  page: 1,
                  category: _selectedTab + 1,
                  keyword: value,
                ),
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
            onTap: (index) {
              _selectedTab = index;
              searchController.clear();

              BlocProvider.of<EcoActivityBloc>(context).add(
                LoadEcoActivity(
                  page: 1,
                  category: _selectedTab + 1,
                ),
              );
            },
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
        floatingActionButton: CarbonRoundedButton(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 30.0,
          ),
          label: "Lihat Artikelku",
          action: () => Navigator.pushNamed(
            context,
            Routes.myArticle,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              EcoTabContent(
                categoryId: 1,
              ),
              EcoTabContent(
                categoryId: 2,
              ),
              EcoTabContent(
                categoryId: 3,
              ),
              EcoTabContent(
                categoryId: 4,
              ),
            ],
          ),
        ),
      ),
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

class EcoTabContent extends StatefulWidget {
  final int categoryId;

  const EcoTabContent({
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  @override
  State<EcoTabContent> createState() => _EcoTabContentState();
}

class _EcoTabContentState extends State<EcoTabContent>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  bool _isLoading = false;
  int _page = 2;

  List<ArticleDetail> data = [];

  @override
  void initState() {
    _scrollController.addListener(_onLoadMore);
    super.initState();
  }

  void _onLoadMore() {
    if (_scrollController.position.extentAfter <= 0 && !_isLoading) {
      _isLoading = true;

      BlocProvider.of<EcoActivityBloc>(context).add(
        LoadEcoActivity(
          page: _page,
          category: widget.categoryId,
          currentData: data,
        ),
      );
      _page++;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<EcoActivityBloc, EcoActivityState>(
      builder: (context, state) {
        if (state is ListEcoActivityError) {
          return const CarbonErrorState();
        }

        if (state is ListEcoActivityEmpty) {
          return const CarbonEmptyState();
        }

        if (state is ListEcoActivityLoadingPaging) {
          var currentData = data;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              children: [
                MainArticleItem(
                  imageUrl: currentData.first.file?.first,
                  articleLabel: currentData.first.title ?? "",
                  authorName: currentData.first.writerName ?? "-",
                  authorImg: currentData.first.writerImg,
                  dateCreated: DateUtil.sanitizeDateTime(
                      currentData.first.createdAt ?? "-"),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.detailEcoUpdate,
                    arguments: DataArgument(
                      id: currentData.first.id ?? "0",
                    ),
                  ),
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: currentData.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container();
                    }

                    return RelatedArticleItem(
                      title: currentData[index].title,
                      author: currentData[index].writerName,
                      imageUrl: currentData[index].file?.first,
                      createdAt: DateUtil.sanitizeDateTime(
                          currentData[index].createdAt ?? "-"),
                      action: () => Navigator.pushNamed(
                        context,
                        Routes.detailEcoUpdate,
                        arguments: DataArgument(
                          id: currentData[index].id ?? "0",
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  color: ColorPalettes.white,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: ColorPalettes.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is ListEcoActivityLoaded) {
          data = state.ecoActivityList;
          _isLoading = false;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              children: [
                MainArticleItem(
                  imageUrl: data.first.file?.first,
                  articleLabel: data.first.title ?? "",
                  authorName: data.first.writerName ?? "-",
                  authorImg: data.first.writerImg,
                  dateCreated:
                      DateUtil.sanitizeDateTime(data.first.createdAt ?? "-"),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.detailEcoUpdate,
                    arguments: DataArgument(
                      id: data.first.id ?? "0",
                    ),
                  ),
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container();
                    }

                    return RelatedArticleItem(
                      title: data[index].title,
                      author: data[index].writerName,
                      imageUrl: data[index].file?.first,
                      createdAt: DateUtil.sanitizeDateTime(
                          data[index].createdAt ?? "-"),
                      action: () => Navigator.pushNamed(
                        context,
                        Routes.detailEcoUpdate,
                        arguments: DataArgument(
                          id: data[index].id ?? "0",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        _page = 2;

        return const CarbonLoadingState();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
