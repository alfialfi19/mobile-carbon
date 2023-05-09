import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/routes.dart';

import '../commons/commons.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';
import '../widgets/widgets.dart';

class CalculateCarbonStep2Screen extends StatelessWidget {
  const CalculateCarbonStep2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as EmisiArgument;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository = RepositoryProvider.of<MasterRepository>(context);

            return MasterBloc(repository)
              ..add(
                LoadMasterSubCategory(
                  int.parse(argument.idCategory ?? "0"),
                ),
              );
          },
        ),
      ],
      child: CalculateCarbonStep2Content(
        id: int.parse(argument.idCategory ?? "0"),
        label: argument.source,
        argument: argument,
      ),
    );
  }
}

class CalculateCarbonStep2Content extends StatefulWidget {
  final int id;
  final String? label;
  final EmisiArgument? argument;

  const CalculateCarbonStep2Content({
    required this.id,
    this.label,
    this.argument,
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
  String selectedUnit = "";

  List<EmisiCategory> _selectedSubCategory = [];

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

                        return Wrap(
                          direction: Axis.horizontal,
                          children: List<Widget>.generate(
                            data.length,
                            (index) {
                              return ChipItem(
                                label: data[index].opt ?? "-",
                                callback: () {
                                  setState(() {
                                    data[index] = data[index].copyWith(
                                      value: !data[index].value,
                                    );
                                  });

                                  onSelectedSubCategory(
                                    data[index].opt ?? "-",
                                    int.parse(data[index].id ?? "0"),
                                    data[index].unit ?? "",
                                    subCategory: data[index],
                                  );
                                },
                                value: data[index].value,
                              );
                            },
                          ),
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
                    margin: const EdgeInsets.only(
                      bottom: 20.0,
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
                                Routes.calculateCarbonFinalStep,
                                arguments: EmisiArgument(
                                    idCategory: widget.argument?.idCategory,
                                    idSubCategory: selectedId.toString(),
                                    unit: selectedUnit,
                                    source: widget.label,
                                    selectedCategory: _selectedSubCategory),
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

  void onSelectedSubCategory(
    String value,
    int id,
    String unit, {
    EmisiCategory? subCategory,
  }) {
    setState(() {
      selectedLabel = value;
      selectedId = id;
      selectedUnit = unit;
    });

    print("===> _selectedSubCategory before: $_selectedSubCategory");
    if (_selectedSubCategory.isNotEmpty) {
      if (subCategory != null) {
        if (!_selectedSubCategory.contains(subCategory)) {
          _selectedSubCategory.add(subCategory);
        } else {
          _selectedSubCategory.remove(subCategory);
        }
      }
    } else {
      if (subCategory != null) {
        print("===> enter if on else");
        _selectedSubCategory.add(subCategory);
      }
    }
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
