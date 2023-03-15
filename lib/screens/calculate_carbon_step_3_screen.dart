import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/routes.dart';

import '../commons/commons.dart';
import '../widgets/widgets.dart';

class CalculateCarbonStep3Screen extends StatelessWidget {
  const CalculateCarbonStep3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as EmisiArgument;

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
      child: CalculateCarbonStep3Content(
        argument: argument,
      ),
    );
  }
}

class CalculateCarbonStep3Content extends StatefulWidget {
  final EmisiArgument? argument;

  const CalculateCarbonStep3Content({
    this.argument,
    Key? key,
  }) : super(key: key);

  @override
  State<CalculateCarbonStep3Content> createState() =>
      _CalculateCarbonStep3ContentState();
}

class _CalculateCarbonStep3ContentState
    extends State<CalculateCarbonStep3Content> {
  // final List<String> _timeCategory = [
  //   "Menit",
  //   "Jam",
  //   "Hari",
  //   "Minggu",
  //   "Bulan",
  // ];

  List<String> unit = [];
  TextEditingController timeController = TextEditingController();

  String _selectedUnit = "";

  @override
  void initState() {
    if (widget.argument?.unit != null) {
      unit.add(widget.argument!.unit!);
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
        padding: const EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 30.0,
        ),
        child: BlocListener<EmisiLogBloc, EmisiLogState>(
          listener: _actionBlocListener,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                "Lama Perjalanan",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 24.0,
                ),
                height: 212.0,
                width: 288.0,
                child: Image.asset(
                  Images.humans,
                ),
              ),
              Wrap(
                children: [
                  TextFieldInput(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    contentPadding: const EdgeInsets.all(
                      16.0,
                    ),
                    prefix: Container(
                      padding: const EdgeInsets.only(
                        right: 12.0,
                        left: 16.0,
                      ),
                      child: Icon(
                        Icons.access_time_rounded,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    width: MediaQuery.of(context).size.width / 3,
                    maxLength: null,
                    controller: timeController,
                    callback: (value) => print(
                      "==> time: $value",
                    ),
                  ),
                  CategoryInput(
                    width: MediaQuery.of(context).size.width / 3,
                    label: null,
                    categoryItem: unit,
                    callback: (value) {
                      print("===> selectedTimeCategory: $value");
                      _selectedUnit = value;
                    },
                  ),
                ],
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
                          if (_selectedUnit.isNotBlank &&
                              timeController.text.isNotBlank) {
                            BlocProvider.of<EmisiLogBloc>(context).add(
                              StoreEmisiLog(
                                  widget.argument?.idCategory,
                                  widget.argument?.idSubCategory,
                                  timeController.text,
                                  _selectedUnit),
                            );
                          }
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
    timeController.dispose();
    super.dispose();
  }

  void _actionBlocListener(
    BuildContext context,
    EmisiLogState state,
  ) {
    if (state is StoreEmisiLogSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

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
