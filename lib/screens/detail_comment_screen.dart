import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/widgets/comment_section.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class DetailCommentScreen extends StatelessWidget {
  const DetailCommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as DataArgument;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<CommentRepository>(context);

            return CommentBloc(repository)
              ..add(
                LoadComment(
                  1,
                  int.parse(argument.id),
                ),
              );
          },
        ),
      ],
      child: DetailCommentContent(
        id: argument.id,
      ),
    );
  }
}

class DetailCommentContent extends StatefulWidget {
  final String id;

  const DetailCommentContent({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailCommentContent> createState() => _DetailCommentContentState();
}

class _DetailCommentContentState extends State<DetailCommentContent> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Komentar",
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
      floatingActionButton: InkWell(
        onTap: () => _showAddComment(context),
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
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: PullToRefresh(
          controller: _scrollController,
          onRefresh: _refresh,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    "Semua Komentar",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: 18.0,
                          color: ColorPalettes.dark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      if (state is ListCommentError) {
                        return CarbonErrorState(
                          onRefresh: _refresh,
                        );
                      }

                      if (state is ListCommentEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is ListCommentLoaded) {
                        var data = state.commentList;

                        return Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return CommentSection(
                                  imgUrl: data[index].file,
                                  author: data[index].writerName,
                                  createdAt: DateUtil.sanitizeDateTime(
                                      data[index].createdAt ?? "-"),
                                  comment: data[index].desc,
                                  childComment: data[index].item,
                                  optionsCallback: () =>
                                      _showActionOptions(context),
                                );
                              },
                            ),
                          ],
                        );
                      }

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

  Future<void> _showActionOptions(BuildContext context) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => CommentActionBottomSheet(),
    );

    if (data != null) {
      if (data == 1 || data == 2) {
        _showAddComment.call(context);
      } else if (data == 3) {
        _showDeleteArticle.call(context);
      } else {}
    }
  }

  Future<void> _showAddComment(BuildContext context) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => PostCommentBottomSheet(),
    );

    if (data != null) {
      // do something
    }
  }

  Future<void> _showDeleteArticle(BuildContext context) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => DeleteArticleBottomSheet(
        label: "Hapus Artikel",
        caption:
            "Apakah Anda ingin menghapus artikel? Artikel yang telah dihapus "
            "tidak dapat dikembalikan lagi.",
        negativeCallback: () => Navigator.pop(context),
        positiveLabel: "Hapus",
      ),
    );

    if (data != null) {
      // do something
    }
  }

  Future<void> _refresh() async {
    BlocProvider.of<CommentBloc>(context).add(
      LoadComment(
        1,
        int.parse(widget.id),
      ),
    );
  }
}
