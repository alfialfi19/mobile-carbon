import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class CalculateCarbonStep1Screen extends StatelessWidget {
  const CalculateCarbonStep1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository = RepositoryProvider.of<MasterRepository>(context);

            return MasterBloc(repository)
              ..add(
                LoadMasterCategory(),
              );
          },
        ),
      ],
      child: const CalculateCarbonStep1Content(),
    );
  }
}

class CalculateCarbonStep1Content extends StatefulWidget {
  const CalculateCarbonStep1Content({Key? key}) : super(key: key);

  @override
  State<CalculateCarbonStep1Content> createState() =>
      _CalculateCarbonStep1ContentState();
}

class _CalculateCarbonStep1ContentState
    extends State<CalculateCarbonStep1Content> {
  final _scrollController = ScrollController();

  String selectedLabel = "";
  int selectedId = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Hitung Jejak Karbon",
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
        padding: const EdgeInsets.fromLTRB(
          30.0,
          40.0,
          30.0,
          0.0,
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
                    "Pilih Kategori",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: ColorPalettes.dark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  BlocBuilder<MasterBloc, MasterState>(
                    builder: (context, state) {
                      if (state is MasterCategoryError) {
                        return CarbonErrorState(
                          onRefresh: _refresh,
                        );
                      }

                      if (state is MasterCategoryEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is MasterCategoryLoaded) {
                        var data = state.emisiCategory;

                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryItem(
                              label: data[index].opt ?? "-",
                              callback: () => onSelectedCategory(
                                  data[index].opt ?? "-",
                                  int.parse(data[index].id ?? "0")),
                              value: selectedLabel == data[index].opt,
                              imageActive: Image.asset(
                                width: 32.0,
                                height: 32.0,
                                CarbonUtil.getCategoryIcon(data[index].opt),
                                color: ColorPalettes.white,
                              ),
                              imageInactive: Image.asset(
                                width: 32.0,
                                height: 32.0,
                                CarbonUtil.getCategoryIcon(data[index].opt),
                              ),
                            );
                          },
                        );
                      }

                      return const CarbonLoadingState();
                    },
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  if (selectedId != 0)
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: CarbonRoundedButton(
                        label: "Selanjutnya",
                        backgroundColor: ColorPalettes.primary,
                        borderColor: ColorPalettes.primary,
                        action: () => Navigator.pushNamed(
                          context,
                          Routes.calculateCarbonStep2,
                          arguments: EmisiArgument(
                            idCategory: selectedId.toString(),
                            source: selectedLabel,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectedCategory(
    String value,
    int id,
  ) {
    setState(() {
      selectedLabel = value;
      selectedId = id;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    BlocProvider.of<MasterBloc>(context).add(LoadMasterCategory());
  }
}
