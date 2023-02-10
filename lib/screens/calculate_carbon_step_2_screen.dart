import 'package:flutter/material.dart';
import 'package:mobile_carbon/routes.dart';

import '../commons/commons.dart';
import '../widgets/widgets.dart';

class CalculateCarbonStep2Screen extends StatefulWidget {
  const CalculateCarbonStep2Screen({Key? key}) : super(key: key);

  @override
  State<CalculateCarbonStep2Screen> createState() =>
      _CalculateCarbonStep2ScreenState();
}

class _CalculateCarbonStep2ScreenState
    extends State<CalculateCarbonStep2Screen> {
  List<String> label = [
    "Motor",
    "Mobil",
    "Kereta Api",
    "Pesawat Terbang",
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
              "Pilih Jenis Transportasi",
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
                    CarbonIcons.motorcycle,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.motorcycle,
                    color: ColorPalettes.orange2,
                  ),
                ),
                CategoryItem(
                  label: label[1],
                  callback: () => onSelectedCategory(label[1]),
                  value: selectedLabel == label[1],
                  imageActive: Image.asset(
                    CarbonIcons.car2,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.car2,
                  ),
                ),
                CategoryItem(
                  label: label[2],
                  callback: () => onSelectedCategory(label[2]),
                  value: selectedLabel == label[2],
                  imageActive: Image.asset(
                    CarbonIcons.train,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.train,
                  ),
                ),
                CategoryItem(
                  label: label[3],
                  callback: () => onSelectedCategory(label[3]),
                  value: selectedLabel == label[3],
                  imageActive: Image.asset(
                    CarbonIcons.plane,
                    color: ColorPalettes.white,
                  ),
                  imageInactive: Image.asset(
                    CarbonIcons.plane,
                  ),
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
    );
  }

  void onSelectedCategory(String value) {
    setState(() {
      selectedLabel = value;
    });
  }
}
