import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/donation/donation_bloc.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
import '../models/models.dart';
import '../routes.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DonationBloc>(
          create: (context) {
            final repository =
                RepositoryProvider.of<DonationRepository>(context);

            return DonationBloc(repository)
              ..add(
                LoadDonationList(
                  page: 1,
                  category: "Terupdate",
                ),
              );
          },
        ),
      ],
      child: const DonationContent(),
    );
  }
}

class DonationContent extends StatefulWidget {
  const DonationContent({Key? key}) : super(key: key);

  @override
  State<DonationContent> createState() => _DonationContentState();
}

class _DonationContentState extends State<DonationContent> {
  final _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  bool _isLoading = false;
  int _page = 2;

  List<DonationDetail> listData = [];

  @override
  void initState() {
    _scrollController.addListener(_onLoadMore);
    super.initState();
  }

  void _onLoadMore() {
    if (_scrollController.position.extentAfter <= 0 && !_isLoading) {
      _isLoading = true;

      BlocProvider.of<DonationBloc>(context).add(
        LoadDonationList(
          page: _page,
          category: "Terupdate",
          currentData: listData,
        ),
      );
      _page++;
    }
  }

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
          onRefresh: _refresh,
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
                    onSubmitted: (value) =>
                        BlocProvider.of<DonationBloc>(context).add(
                      LoadDonationList(
                        page: 1,
                        category: "Terupdate",
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
                  BlocBuilder<DonationBloc, DonationState>(
                    builder: (context, state) {
                      if (state is ListDonationError) {
                        return CarbonErrorState(
                          onRefresh: _refresh,
                        );
                      }

                      if (state is ListDonationEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is ListDonationLoadingPaging) {
                        var currentData = listData;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              itemCount: currentData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return RelatedArticleItem(
                                  margin: const EdgeInsets.only(bottom: 0.0),
                                  title: currentData[index].title,
                                  author: currentData[index].writerName,
                                  imageUrl: currentData[index].file?.first,
                                  createdAt: DateUtil.sanitizeDateTime(
                                      currentData[index].createdAt!),
                                  action: () => Navigator.pushNamed(
                                    context,
                                    Routes.detailDonation,
                                    arguments: DataArgument(
                                      id: currentData[index].id ?? "0",
                                    ),
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

                      if (state is ListDonationLoaded) {
                        listData = state.donationList;
                        _isLoading = false;

                        return ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          itemCount: listData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return RelatedArticleItem(
                              margin: const EdgeInsets.only(bottom: 0.0),
                              title: listData[index].title,
                              author: listData[index].writerName,
                              imageUrl: listData[index].file?.first,
                              createdAt: DateUtil.sanitizeDateTime(
                                  listData[index].createdAt!),
                              action: () => Navigator.pushNamed(
                                context,
                                Routes.detailDonation,
                                arguments: DataArgument(
                                  id: listData[index].id ?? "0",
                                ),
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
                        );
                      }
                      _page = 2;

                      return const CarbonLoadingState();
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
    BlocProvider.of<DonationBloc>(context).add(
      LoadDonationList(
        page: 1,
        category: "Terupdate",
      ),
    );
  }
}
