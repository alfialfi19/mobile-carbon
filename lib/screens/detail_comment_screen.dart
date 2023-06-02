import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/widgets/comment_section.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
import '../models/models.dart';

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
                  page: 1,
                  id: int.parse(argument.id),
                  source: argument.source,
                ),
              );
          },
        ),
      ],
      child: DetailCommentContent(
        idArticle: argument.id,
        source: argument.source,
      ),
    );
  }
}

class DetailCommentContent extends StatefulWidget {
  final String idArticle;
  final String? source;

  const DetailCommentContent({
    required this.idArticle,
    this.source,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailCommentContent> createState() => _DetailCommentContentState();
}

class _DetailCommentContentState extends State<DetailCommentContent> {
  final _scrollController = ScrollController();

  bool _isLoading = false;
  int _page = 2;

  List<Comments> data = [];

  @override
  void initState() {
    _scrollController.addListener(_onLoadMore);
    super.initState();
  }

  void _onLoadMore() {
    if (_scrollController.position.extentAfter <= 0 && !_isLoading) {
      _isLoading = true;

      BlocProvider.of<CommentBloc>(context).add(
        LoadComment(
          page: _page,
          id: int.parse(widget.idArticle),
          source: widget.source,
          currentData: data,
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
        onTap: () => _showAddComment(
          context,
          idArticle: int.parse(widget.idArticle),
          source: widget.source,
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
                  BlocConsumer<CommentBloc, CommentState>(
                    listener: _actionBlocListener,
                    builder: (context, state) {
                      if (state is ListCommentError) {
                        return CarbonErrorState(
                          onRefresh: _refresh,
                        );
                      }

                      if (state is ListCommentEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is ListCommentLoadingPaging) {
                        var currentData = data;

                        return Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentData.length,
                              itemBuilder: (context, index) {
                                return CommentSection(
                                  imgUrl: currentData[index].file,
                                  author: currentData[index].writerName,
                                  createdAt: DateUtil.sanitizeDateTime(
                                      currentData[index].createdAt ?? "-"),
                                  comment: currentData[index].desc,
                                  childComment: currentData[index].item,
                                  optionsCallback: () => _showActionOptions(
                                    context,
                                    idArticle: int.parse(widget.idArticle),
                                    idParent: int.parse(
                                        currentData[index].idParent ?? "0"),
                                    idComment: data[index].id,
                                    source: widget.source,
                                    currentComment: data[index].desc,
                                  ),
                                );
                              },
                            ),
                            Container(
                              color: ColorPalettes.backgroundLight,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: ColorPalettes.primary,
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      if (state is ListCommentLoaded) {
                        data = state.commentList;
                        _isLoading = false;

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
                                  optionsCallback: () => _showActionOptions(
                                    context,
                                    idArticle: int.parse(widget.idArticle),
                                    idParent:
                                        int.parse(data[index].idParent ?? "0"),
                                    idComment: data[index].id,
                                    source: widget.source,
                                    currentComment: data[index].desc,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showActionOptions(
    BuildContext context, {
    int? idArticle,
    int? idParent,
    String? idComment,
    String? source,
    String? currentComment,
  }) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => CommentActionBottomSheet(),
    );

    if (data != null) {
      if (data == 1) {
        _showAddComment.call(
          context,
          idArticle: idArticle,
          idParent: int.parse(idComment ?? "0"),
          source: source,
        );
      } else if (data == 2) {
        _showAddComment.call(
          context,
          idArticle: idArticle,
          idParent: idParent,
          idComment: idComment,
          source: source,
          currentComment: currentComment,
        );
      } else if (data == 3) {
        _showDeleteComment.call(
          context,
          idComment: idComment,
          source: source,
        );
      } else {}
    }
  }

  Future<void> _showAddComment(
    BuildContext context, {
    int? idArticle,
    int? idParent,
    String? idComment,
    String? source,
    String? currentComment,
  }) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => PostCommentBottomSheet(
        currentComment: currentComment,
      ),
    );

    if (data != null) {
      BlocProvider.of<CommentBloc>(context).add(
        StoreComment(
          idArticle: idArticle,
          idParent: idParent,
          idComment: idComment,
          desc: data,
          source: source,
        ),
      );
    }
  }

  Future<void> _showDeleteComment(
    BuildContext context, {
    String? idComment,
    String? source,
  }) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => DeleteArticleBottomSheet(
        label: "Hapus Komentar",
        caption:
            "Apakah Anda ingin menghapus komentar? Komentar yang telah dihapus "
            "tidak dapat dikembalikan lagi.",
        negativeCallback: () => Navigator.pop(context),
        positiveLabel: "Hapus",
      ),
    );

    if (data != null) {
      BlocProvider.of<CommentBloc>(context).add(
        DeleteComment(
          idComment: idComment,
          source: source,
        ),
      );
    }
  }

  void _actionBlocListener(
    BuildContext context,
    CommentState state,
  ) {
    if (state is StoreCommentSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.info(
        context,
        "Berhasil memperbarui komentar.",
      );

      _refresh();
    } else if (state is DeleteCommentSuccess) {
      ToastUtil.info(
        context,
        "Berhasil menghapus komentar.",
      );

      _refresh();
    } else if (state is StoreCommentError) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ??
            "Terjadi kesalahan, silahkan coba lagi nanti.",
      );
    } else if (state is DeleteCommentError) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ??
            "Terjadi kesalahan, silahkan coba lagi nanti.",
      );
    } else if (state is StoreCommentLoading) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(),
      );
    }
  }

  Future<void> _refresh() async {
    BlocProvider.of<CommentBloc>(context).add(
      LoadComment(
        page: 1,
        id: int.parse(widget.idArticle),
        source: widget.source,
      ),
    );
  }
}
