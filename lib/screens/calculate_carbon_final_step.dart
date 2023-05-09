import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class CalculateCarbonFinalStep extends StatelessWidget {
  const CalculateCarbonFinalStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as EmisiArgument;

    print("==> argument: ${argument.source}");
    print("==> argument: ${argument.idCategory}");
    print("==> argument: ${argument.idSubCategory}");
    print("==> argument showing form: ${argument.selectedCategory}");

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<EmisiLogRepository>(context);

            return EmisiLogBloc(repository);
          },
        ),
      ],
      child: CalculateCarbonFinalStepContent(
        argument: argument,
        selectedCategory: argument.selectedCategory,
      ),
    );
  }
}

class CalculateCarbonFinalStepContent extends StatefulWidget {
  final EmisiArgument? argument;
  final List<EmisiCategory> selectedCategory;

  const CalculateCarbonFinalStepContent({
    this.argument,
    this.selectedCategory = const [],
    Key? key,
  }) : super(key: key);

  @override
  State<CalculateCarbonFinalStepContent> createState() =>
      _CalculateCarbonFinalStepContentState();
}

class _CalculateCarbonFinalStepContentState
    extends State<CalculateCarbonFinalStepContent> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    if (widget.argument?.selectedCategory != null) {
      for (var category in widget.argument!.selectedCategory) {
        _controllers.add(TextEditingController());
      }
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
          40.0,
          30.0,
          40.0,
          0.0,
        ),
        child: BlocListener<EmisiLogBloc, EmisiLogState>(
          listener: _actionBlocListener,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                "Jumlah Jejak Karbon",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.selectedCategory.length,
                itemBuilder: (context, index) {
                  return TextFieldInputBackground(
                    labelText: widget.selectedCategory[index].opt,
                    hintText:
                        "Masukkan berat ${widget.selectedCategory[index].opt}",
                    maxLength: null,
                    controller: _controllers[index],
                    callback: (value) => print(
                      "==> ${widget.selectedCategory[index].opt}: $value",
                    ),
                    keyboardType: TextInputType.number,
                    suffixLabel: widget.selectedCategory[index].unit,
                  );
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
                        label: "Simpan",
                        backgroundColor: ColorPalettes.primary,
                        borderColor: ColorPalettes.primary,
                        action: () {
                          List<String> listVal = [];

                          for (var element in _controllers) {
                            listVal.add(element.text);
                          }
                          // if (_selectedUnit.isNotBlank &&
                          //     timeController.text.isNotBlank) {
                          BlocProvider.of<EmisiLogBloc>(context).add(
                            StoreEmisiLogMultiple(
                              listEmisi: widget.selectedCategory,
                              listVal: listVal,
                            ),
                          );
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    super.dispose();
  }

  void _actionBlocListener(
    BuildContext context,
    EmisiLogState state,
  ) {
    if (state is StoreEmisiLogSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.info(
        context,
        "Berhasil menambahkan jejak karbon.",
      );

      // navigate to other page
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.main,
        (route) => false,
      );
    } else if (state is StoreEmisiLogError) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ??
            "Terjadi kesalahan, silahkan coba lagi nanti.",
      );
    } else if (state is StoreEmisiLogLoading) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(),
      );
    }
  }
}
