import 'package:flutter/material.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class CalculateCarbonStep1Screen extends StatefulWidget {
  const CalculateCarbonStep1Screen({Key? key}) : super(key: key);

  @override
  State<CalculateCarbonStep1Screen> createState() =>
      _CalculateCarbonStep1ScreenState();
}

class _CalculateCarbonStep1ScreenState
    extends State<CalculateCarbonStep1Screen> {
  List<String> label = [
    "Transportasi",
    "Makanan",
    "Alat Elektronik",
    "Pembelian Pakaian",
    "Sampah",
  ];
  String selectedLabel = "";

  @override
  void initState() {
    selectedLabel = label[0];
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
        child: ListView(
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
            Wrap(
              spacing: 10.0,
              runSpacing: 15.0,
              alignment: WrapAlignment.spaceBetween,
              children: [
                CategoryItem(
                  label: label[0],
                  callback: () => onSelectedCategory(label[0]),
                  value: selectedLabel == label[0],
                  imageActive: Image.asset(
                    CarbonIcons.car,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.car,
                  ),
                ),
                CategoryItem(
                  label: label[1],
                  callback: () => onSelectedCategory(label[1]),
                  value: selectedLabel == label[1],
                  imageActive: Image.asset(
                    CarbonIcons.food2,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.food2,
                  ),
                ),
                CategoryItem(
                  label: label[2],
                  callback: () => onSelectedCategory(label[2]),
                  value: selectedLabel == label[2],
                  imageActive: Image.asset(
                    CarbonIcons.tv2,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.tv2,
                  ),
                ),
                CategoryItem(
                  label: label[3],
                  callback: () => onSelectedCategory(label[3]),
                  value: selectedLabel == label[3],
                  imageActive: Image.asset(
                    CarbonIcons.cloth,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.cloth,
                  ),
                ),
                CategoryItem(
                  label: label[4],
                  callback: () => onSelectedCategory(label[4]),
                  value: selectedLabel == label[4],
                  imageActive: Image.asset(
                    CarbonIcons.trash2,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.trash2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            CarbonRoundedButton(
              label: "Selanjutnya",
              backgroundColor: ColorPalettes.primary,
              borderColor: ColorPalettes.primary,
              action: () => Navigator.pushNamed(
                context,
                Routes.calculateCarbonStep2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectedCategory(String value) {
    setState(() {
      selectedLabel = value;
    });
  }
}
