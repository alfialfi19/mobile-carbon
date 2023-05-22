import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/models/models.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../routes.dart';

class AddArticleScreen extends StatelessWidget {
  const AddArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as ArticleArgument?;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<ArticleRepository>(context);

            return ArticleBloc(repository);
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = RepositoryProvider.of<MasterRepository>(context);

            return MasterBloc(repository)
              ..add(
                LoadMasterArticleCategory(),
              );
          },
        ),
      ],
      child: AddArticleContent(
        currentArticle: argument?.currentArticle,
      ),
    );
  }
}

class AddArticleContent extends StatefulWidget {
  final ArticleDetail? currentArticle;

  const AddArticleContent({
    this.currentArticle,
    Key? key,
  }) : super(key: key);

  @override
  State<AddArticleContent> createState() => _AddArticleContentState();
}

class _AddArticleContentState extends State<AddArticleContent> {
  final List<String> _categoryItem = [
    "Tanamanku",
    "Manggot",
    "Biogas",
    "Listrik Ramah Lingkungan",
  ];
  List<String> category = [];
  List<String> categoryId = [];
  List<String> filePaths = [];

  TextEditingController plantTypeController = TextEditingController();
  TextEditingController plantDescriptionController = TextEditingController();
  String _selectedCategory = "";
  String _selectedCategoryId = "";

  @override
  void initState() {
    if (widget.currentArticle?.title != null) {
      plantTypeController.text = widget.currentArticle!.title!;
    }

    if (widget.currentArticle?.desc != null) {
      plantDescriptionController.text = widget.currentArticle!.desc!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.currentArticle != null ? "Ubah Artikel" : "Tambah Artikel",
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
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: BlocListener<ArticleBloc, ArticleState>(
          listener: _actionBlocListener,
          child: BlocBuilder<MasterBloc, MasterState>(
            builder: (context, state) {
              if (state is MasterArticleCategoryError) {
                return const CarbonErrorState();
              }

              if (state is MasterArticleCategoryEmpty) {
                return const CarbonEmptyState();
              }

              if (state is MasterArticleCategoryLoaded) {
                var data = state.articleCategory;

                for (var item in data) {
                  category.add(item.opt ?? "");
                  categoryId.add(item.id ?? "0");
                }

                return ListView(
                  children: [
                    CategoryInput(
                      item: widget.currentArticle?.categoryName,
                      categoryItem: category,
                      callback: (value) {
                        print("===> selectedCategory: $value");
                        _selectedCategory = value;
                        for (int i = 0; i < category.length; i++) {
                          if (_selectedCategory == category[i]) {
                            _selectedCategoryId = categoryId[i];
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFieldInput(
                      labelText: "Judul",
                      hintText: "Masukkan judul artikel",
                      maxLength: null,
                      controller: plantTypeController,
                      callback: (value) => print(
                        "==> article title: $value",
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    AttachmentInput(
                      // formzError: "errorText",
                      callback: (attachmentIds) =>
                          // BlocProvider.of<CreateReimbursementBloc>(context).add(
                          //   AttachmentIdsChanged(attachmentIds),
                          // ),
                          print("===> this is attachmentIds: $attachmentIds"),
                      onAddCallback: (filePath) {
                        print("==> filePath before: $filePaths");
                        filePaths.add(filePath);
                        print("==> filePath after: $filePaths");
                      },
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextFieldInput(
                      labelText: "Isi Artikel",
                      hintText: "Masukkan isi artikel",
                      maxLength: null,
                      minLines: 5,
                      controller: plantDescriptionController,
                      callback: (value) => print(
                        "==> description article: $value",
                      ),
                    ),
                    const SizedBox(
                      height: 46.0,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: CarbonRoundedButton(
                              label: "Batal",
                              labelColor: ColorPalettes.dark,
                              backgroundColor: ColorPalettes.backgroundLight,
                              borderColor: ColorPalettes.line,
                              action: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: CarbonRoundedButton(
                              label: "Kirim",
                              backgroundColor: ColorPalettes.primary,
                              borderColor: ColorPalettes.primary,
                              action: () {
                                if (widget.currentArticle?.id != null) {
                                  BlocProvider.of<ArticleBloc>(context).add(
                                    UpdateArticle(
                                      articleId: widget.currentArticle?.id,
                                      categoryId:
                                          int.parse(_selectedCategoryId),
                                      title: plantTypeController.text,
                                      filePath: filePaths,
                                      desc: plantDescriptionController.text,
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<ArticleBloc>(context).add(
                                    StoreArticle(
                                      categoryId:
                                          int.parse(_selectedCategoryId),
                                      title: plantTypeController.text,
                                      filePath: filePaths,
                                      desc: plantDescriptionController.text,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return const CarbonLoadingState();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    plantTypeController.dispose();
    plantDescriptionController.dispose();
    super.dispose();
  }

  void _actionBlocListener(
    BuildContext context,
    ArticleState state,
  ) {
    if (state is StoreArticleSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.info(
        context,
        "Berhasil menambahkan artikel.",
      );

      // navigate to other screen
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.main,
        (route) => false,
      );
    } else if (state is UpdateArticleSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.info(
        context,
        "Berhasil mengupdate artikel.",
      );

      // navigate to other screen
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.main,
        (route) => false,
      );
    } else if (state is StoreArticleError) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ??
            "Terjadi kesalahan, silahkan coba lagi nanti.",
      );
    } else if (state is UpdateArticleError) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ??
            "Terjadi kesalahan, silahkan coba lagi nanti.",
      );
    } else if (state is StoreArticleLoading) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(),
      );
    } else if (state is UpdateArticleLoading) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(),
      );
    }
  }
}
