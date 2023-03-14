import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/routes.dart';

import '../commons/commons.dart';
import '../repositories/repositories.dart';
import '../widgets/widgets.dart';

class CalculateCarbonStep2Screen extends StatelessWidget {
  const CalculateCarbonStep2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as DataArgument;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository = RepositoryProvider.of<MasterRepository>(context);

            return MasterBloc(repository)
              ..add(
                LoadMasterSubCategory(int.parse(argument.id)),
              );
          },
        ),
      ],
      child: CalculateCarbonStep2Content(
        id: int.parse(argument.id),
        label: argument.source,
      ),
    );
  }
}

class CalculateCarbonStep2Content extends StatefulWidget {
  final int id;
  final String? label;

  const CalculateCarbonStep2Content({
    required this.id,
    this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<CalculateCarbonStep2Content> createState() =>
      _CalculateCarbonStep2ContentState();
}

class _CalculateCarbonStep2ContentState
    extends State<CalculateCarbonStep2Content> {
  final _scrollController = ScrollController();

  // List<String> label = [
  //   "Motor",
  //   "Mobil",
  //   "Kereta Api",
  //   "Pesawat Terbang",
  // ];
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
        padding: const EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 30.0,
        ),
        child: PullToRefresh(
          controller: _scrollController,
          onRefresh: () => _refresh(id: widget.id),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilih Jenis ${widget.label}",
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
                      if (state is MasterSubCategoryError) {
                        return CarbonErrorState(
                          onRefresh: _refresh,
                        );
                      }

                      if (state is MasterSubCategoryEmpty) {
                        return const CarbonEmptyState();
                      }

                      if (state is MasterSubCategoryLoaded) {
                        var data = state.emisiCategory;

                        return GridView.builder(
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
                            label: "Sebelumnya",
                            labelColor: ColorPalettes.dark,
                            backgroundColor: ColorPalettes.backgroundLight,
                            borderColor: ColorPalettes.line,
                            action: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        if (selectedId != 0)
                          Expanded(
                            child: CarbonRoundedButton(
                              label: "Selanjutnya",
                              backgroundColor: ColorPalettes.primary,
                              borderColor: ColorPalettes.primary,
                              action: () => Navigator.pushNamed(
                                context,
                                Routes.calculateCarbonStep3,
                              ),
                            ),
                          ),
                      ],
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

  Future<void> _refresh({
    int? id,
  }) async {
    BlocProvider.of<MasterBloc>(context).add(LoadMasterSubCategory(id));
  }
}
