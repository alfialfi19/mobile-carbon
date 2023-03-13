import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';

import '../commons/commons.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class DetailEcoUpdateScreen extends StatelessWidget {
  const DetailEcoUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as DataArgument;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<EcoActivityRepository>(context);

            return EcoActivityBloc(repository)
              ..add(
                LoadEcoActivityDetail(
                  int.parse(argument.id),
                ),
              );
          },
        ),
      ],
      child: DetailEcoUpdateContent(
        id: argument.id,
      ),
    );
  }
}

class DetailEcoUpdateContent extends StatelessWidget {
  final String id;

  const DetailEcoUpdateContent({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.detailComment,
          arguments: DataArgument(id: id),
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
          child: SizedBox(
            height: 32.0,
            width: 32.0,
            child: Image.asset(
              CarbonIcons.comment,
            ),
          ),
        ),
      ),
      body: BlocBuilder<EcoActivityBloc, EcoActivityState>(
        builder: (context, state) {
          if (state is DetailEcoActivityError) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: ColorPalettes.white,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0.0,
                  title: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        top: 10.0,
                      ),
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: ColorPalettes.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        size: 32.0,
                        color: ColorPalettes.dark,
                      ),
                    ),
                  ),
                  expandedHeight: 300.0,
                ),
                SliverToBoxAdapter(
                  child: CarbonErrorState(
                    onRefresh: () =>
                        BlocProvider.of<EcoActivityBloc>(context).add(
                      LoadEcoActivityDetail(
                        int.parse(id),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is DetailEcoActivityLoaded) {
            var data = state.ecoActivity;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: ColorPalettes.white,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0.0,
                  title: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        top: 10.0,
                      ),
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: ColorPalettes.white,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        size: 32.0,
                        color: ColorPalettes.dark,
                      ),
                    ),
                  ),
                  expandedHeight: 300.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  elevation: 50.0,
                  flexibleSpace: Stack(
                    children: [
                      data.file != null &&
                              data.file!.isNotEmpty &&
                              data.file?.first != null
                          ? FlexibleSpaceBar(
                              background: Image.network(
                                data.file?.first,
                                fit: BoxFit.cover,
                              ),
                            )
                          : FlexibleSpaceBar(
                              background: Image.asset(
                                Images.dummyPlant3,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        top: 310.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          width: double.maxFinite,
                          height: 30.0,
                          decoration: const BoxDecoration(
                            color: ColorPalettes.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(40.0),
                        decoration: const BoxDecoration(
                          color: ColorPalettes.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              24.0,
                            ),
                            topRight: Radius.circular(
                              24.0,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title ?? "-",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    color: ColorPalettes.dark,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                  ),
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            AuthorItem(
                              author: data.writerName,
                              dateCreated: DateUtil.sanitizeDateTime(
                                  data.createdAt ?? "Unknown"),
                              imageUrl: data.writerImg,
                              authorTextColor: ColorPalettes.dark,
                              dateTextColor: ColorPalettes.grayZill,
                              dividerColor: ColorPalettes.line,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Text(
                              data.desc ?? "-",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.black,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const CarbonLoadingState(
            marginTop: 50.0,
          );
        },
      ),
    );
  }
}
