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

    print("==> argument: ${argument.source}");
    print("==> argument: ${argument.idCategory}");
    print("==> argument: ${argument.idSubCategory}");
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

  TextEditingController distanceController = TextEditingController();

  TextEditingController wheatController = TextEditingController();
  TextEditingController vegetableController = TextEditingController();
  TextEditingController milkController = TextEditingController();

  TextEditingController refrigeratorAmountController = TextEditingController();
  TextEditingController refrigeratorUnitController = TextEditingController();
  TextEditingController fanAmountController = TextEditingController();
  TextEditingController fanUnitController = TextEditingController();
  TextEditingController acAmountController = TextEditingController();
  TextEditingController acUnitController = TextEditingController();

  TextEditingController topsController = TextEditingController();
  TextEditingController bottomsController = TextEditingController();
  TextEditingController jacketsController = TextEditingController();

  TextEditingController trashWeightController = TextEditingController();

  String _selectedUnit = "";

  String? trashIngredient;

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
                "Jarak Perjalanan",
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
              // Row(
              //   children: [
              //     Expanded(
              //       child: TextFieldInput(
              //         padding: const EdgeInsets.only(
              //           left: 15.0,
              //         ),
              //         contentPadding: const EdgeInsets.all(
              //           16.0,
              //         ),
              //         prefix: Container(
              //           padding: const EdgeInsets.only(
              //             right: 12.0,
              //             left: 16.0,
              //           ),
              //           child: Icon(
              //             Icons.access_time_rounded,
              //             color: Colors.black.withOpacity(0.3),
              //           ),
              //         ),
              //         keyboardType: TextInputType.number,
              //         width: MediaQuery.of(context).size.width,
              //         maxLength: null,
              //         source: DropdownSource.calculateCarbon,
              //         controller: timeController,
              //         callback: (value) => print(
              //           "==> time: $value",
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: CategoryInput(
              //         width: MediaQuery.of(context).size.width,
              //         label: null,
              //         source: DropdownSource.calculateCarbon,
              //         categoryItem: unit,
              //         callback: (value) {
              //           print("===> selectedTimeCategory: $value");
              //           _selectedUnit = value;
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              TextFieldInputBackground(
                labelText: "Jarak",
                hintText: "Masukkan jarak",
                maxLength: null,
                controller: distanceController,
                callback: (value) => print(
                  "==> jarak: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "km",
              ),
              Text(
                "Jumlah Pembelian",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInputBackground(
                labelText: "Gandum",
                hintText: "Masukkan berat gandum",
                maxLength: null,
                controller: wheatController,
                callback: (value) => print(
                  "==> gandum: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "kg",
              ),
              TextFieldInputBackground(
                labelText: "Sayuran",
                hintText: "Masukkan berat sayuran",
                maxLength: null,
                controller: vegetableController,
                callback: (value) => print(
                  "==> sayuran: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "kg",
              ),
              TextFieldInputBackground(
                labelText: "Susu",
                hintText: "Masukkan berat susu",
                maxLength: null,
                controller: milkController,
                callback: (value) => print(
                  "==> sus: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "kg",
              ),
              Text(
                "Lama Penggunaan (3 bulan)",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInputBackground(
                labelText: "Kulkas",
                hintText: "Masukkan jumlah kulkas",
                maxLength: null,
                controller: refrigeratorAmountController,
                callback: (value) => print(
                  "==> jumlah kulkas: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "buah",
                secondaryHintText: "Masukkan penggunaan",
                secondaryController: refrigeratorUnitController,
                secondaryCallback: (value) => print(
                  "==> jumlah penggunaan kulkas: $value",
                ),
                secondarySuffixLabel: "jam/hari",
              ),
              TextFieldInputBackground(
                labelText: "Kipas Angin",
                hintText: "Masukkan jumlah kipas angin",
                maxLength: null,
                controller: fanAmountController,
                callback: (value) => print(
                  "==> jumlah kipas angin: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "buah",
                secondaryHintText: "Masukkan penggunaan",
                secondaryController: fanUnitController,
                secondaryCallback: (value) => print(
                  "==> jumlah penggunaan kipas angin: $value",
                ),
                secondarySuffixLabel: "jam/hari",
              ),
              TextFieldInputBackground(
                labelText: "AC",
                hintText: "Masukkan jumlah ac",
                maxLength: null,
                controller: acAmountController,
                callback: (value) => print(
                  "==> jumlah ac: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "buah",
                secondaryHintText: "Masukkan penggunaan",
                secondaryController: acUnitController,
                secondaryCallback: (value) => print(
                  "==> jumlah penggunaan ac: $value",
                ),
                secondarySuffixLabel: "jam/hari",
              ),
              Text(
                "Jumlah Pembelian",
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInputBackground(
                labelText: "Atasan",
                hintText: "Masukkan jumlah atasan",
                maxLength: null,
                controller: topsController,
                callback: (value) => print(
                  "==> atasan: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "buah",
              ),
              TextFieldInputBackground(
                labelText: "Bawahan",
                hintText: "Masukkan jumlah bawahan",
                maxLength: null,
                controller: bottomsController,
                callback: (value) => print(
                  "==> bawahan: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "buah",
              ),
              TextFieldInputBackground(
                labelText: "Jaket",
                hintText: "Masukkan jumlah jaket",
                maxLength: null,
                controller: jacketsController,
                callback: (value) => print(
                  "==> jaket: $value",
                ),
                keyboardType: TextInputType.number,
                suffixLabel: "buah",
              ),
              Text(
                "Emisi Sampah",
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
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  0.0,
                  6.0,
                  0.0,
                  6.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kandungan Sampah",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorPalettes.grayTextField2,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: ColorPalettes.primary,
                            title: const Text("Anorganik"),
                            value: "anorganik",
                            groupValue: trashIngredient,
                            onChanged: (value) {
                              setState(() {
                                trashIngredient = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: ColorPalettes.primary,
                            title: const Text("Organik"),
                            value: "organik",
                            groupValue: trashIngredient,
                            onChanged: (value) {
                              setState(() {
                                trashIngredient = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
    distanceController.dispose();
    wheatController.dispose();
    vegetableController.dispose();
    milkController.dispose();
    refrigeratorAmountController.dispose();
    refrigeratorUnitController.dispose();
    fanAmountController.dispose();
    fanUnitController.dispose();
    acAmountController.dispose();
    acUnitController.dispose();
    topsController.dispose();
    bottomsController.dispose();
    jacketsController.dispose();
    trashWeightController.dispose();
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
