import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/donation/donation_bloc.dart';

import '../commons/commons.dart';
import '../repositories/repositories.dart';
import '../widgets/widgets.dart';

class DetailDonationScreen extends StatelessWidget {
  const DetailDonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as DataArgument;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<DonationRepository>(context);

            return DonationBloc(repository)
              ..add(
                LoadDonationDetail(
                  int.parse(argument.id),
                ),
              );
          },
        ),
      ],
      child: DetailDonationContent(
        id: argument.id,
      ),
    );
  }
}

class DetailDonationContent extends StatelessWidget {
  final String id;

  const DetailDonationContent({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DonationBloc, DonationState>(
        builder: (context, state) {
          if (state is DetailDonationError) {
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
                    onRefresh: () => BlocProvider.of<DonationBloc>(context).add(
                      LoadDonationDetail(
                        int.parse(id),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is DetailDonationLoaded) {
            var data = state.donationDetail;

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
                            Text(
                              "Tempat Kegiatan",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              data.location ?? "-",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.grayZill,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Waktu Kegiatan",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              DateUtil.sanitizeDateTime(
                                  data.activityAt ?? "Unknown"),
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.grayZill,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Kontak",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              data.contact ?? "-",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.grayZill,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Batas Waktu Donasi",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              DateUtil.sanitizeDateTime(data.deadlineAt ?? "-"),
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.grayZill,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Link Donasi",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              data.url ?? "-",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.primary,
                                        fontWeight: FontWeight.w400,
                                      ),
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
