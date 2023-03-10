import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/eco_activity/eco_activity_bloc.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
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
                  1,
                  1,
                  null,
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
              onSubmitted: (value) =>
                  BlocProvider.of<EcoActivityBloc>(context).add(
                LoadEcoActivity(1, _selectedTab + 1, value),
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
                LoadEcoActivity(1, _selectedTab + 1, null),
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
            vertical: 20.0,
          ),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              EcoTabContent(),
              EcoTabContent(),
              EcoTabContent(),
              EcoTabContent(),
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
  const EcoTabContent({Key? key}) : super(key: key);

  @override
  State<EcoTabContent> createState() => _EcoTabContentState();
}

class _EcoTabContentState extends State<EcoTabContent>
    with AutomaticKeepAliveClientMixin {
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

        if (state is ListEcoActivityLoaded) {
          var data = state.ecoActivityList;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                MainArticleItem(
                  imageUrl: data.first.file?.first,
                  articleLabel: data.first.title ?? "",
                  authorName: data.first.writerName ?? "-",
                  authorImg: data.first.writerImg,
                  dateCreated:
                      DateUtil.sanitizeDateTime(data.first.createdAt ?? "-"),
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
                        Routes.detailArticle,
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

        return const CarbonLoadingState();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
