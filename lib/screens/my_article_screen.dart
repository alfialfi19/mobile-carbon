import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';

import '../commons/commons.dart';
import '../models/models.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class MyArticleScreen extends StatelessWidget {
  const MyArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (context) {
            final repository =
                RepositoryProvider.of<ArticleRepository>(context);

            return ArticleBloc(repository)
              ..add(
                LoadArticle(
                  page: 1,
                  category: 1,
                  me: 1,
                ),
              );
          },
        ),
      ],
      child: const MyArticleContent(),
    );
  }
}

class MyArticleContent extends StatefulWidget {
  const MyArticleContent({Key? key}) : super(key: key);

  @override
  State<MyArticleContent> createState() => _MyArticleContentState();
}

class _MyArticleContentState extends State<MyArticleContent> {
  final _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorPalettes.backgroundLight,
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      color: ColorPalettes.dark,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Text(
                        "Artikelku",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontSize: 18.0,
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                height: 58.0,
                child: TextField(
                  controller: searchController,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w400,
                      ),
                  onSubmitted: (value) =>
                      BlocProvider.of<ArticleBloc>(context).add(
                    LoadArticle(
                      page: 1,
                      category: _selectedTab + 1,
                      keyword: value,
                      me: 1,
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
            ],
          ),
          backgroundColor: ColorPalettes.backgroundLight,
          leadingWidth: 0.0,
          toolbarHeight: 130.0,
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
            onTap: (index) {
              _selectedTab = index;
              // searchController.clear();

              BlocProvider.of<ArticleBloc>(context).add(
                LoadArticle(
                  page: 1,
                  category: _selectedTab + 1,
                  me: 1,
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
            child: const Icon(
              Icons.add,
              size: 32.0,
              color: ColorPalettes.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MyArticleTabContent(
                selectedIndex: _selectedTab,
              ),
              MyArticleTabContent(
                selectedIndex: _selectedTab,
              ),
              MyArticleTabContent(
                selectedIndex: _selectedTab,
              ),
              MyArticleTabContent(
                selectedIndex: _selectedTab,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class MyArticleTabContent extends StatefulWidget {
  final int selectedIndex;

  const MyArticleTabContent({
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<MyArticleTabContent> createState() => _MyArticleTabContentState();
}

class _MyArticleTabContentState extends State<MyArticleTabContent>
    with AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();

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

      BlocProvider.of<ArticleBloc>(context).add(
        LoadArticle(
          page: _page,
          category: widget.selectedIndex + 1,
          me: 1,
          currentData: data,
        ),
      );
      _page++;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ListArticleError) {
          return CarbonErrorState(
            onRefresh: _refresh,
          );
        }

        if (state is ListArticleEmpty) {
          return const CarbonEmptyState();
        }

        if (state is ListArticleLoadingPaging) {
          var currentData = data;

          return ListView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: currentData.length,
                itemBuilder: (context, index) {
                  return RelatedArticleItem(
                    title: currentData[index].title,
                    author: currentData[index].writerName,
                    imageUrl: currentData[index].file?.first,
                    createdAt: DateUtil.sanitizeDateTime(
                        currentData[index].createdAt ?? "-"),
                    action: () => Navigator.pushNamed(
                      context,
                      Routes.detailArticle,
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
          );
        }

        if (state is ListArticleLoaded) {
          data = state.articleList;
          _isLoading = false;

          return ListView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            children: [
              const SizedBox(
                height: 10.0,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return RelatedArticleItem(
                    title: data[index].title,
                    author: data[index].writerName,
                    imageUrl: data[index].file?.first,
                    createdAt:
                        DateUtil.sanitizeDateTime(data[index].createdAt ?? "-"),
                    action: () => Navigator.pushNamed(
                      context,
                      Routes.detailArticle,
                      arguments: DataArgument(
                        id: data[index].id ?? "0",
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
        _page = 2;

        return const CarbonLoadingState();
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _refresh() async {
    BlocProvider.of<ArticleBloc>(context).add(
      LoadArticle(
        page: 1,
        category: widget.selectedIndex + 1,
        me: 1,
      ),
    );
  }
}
