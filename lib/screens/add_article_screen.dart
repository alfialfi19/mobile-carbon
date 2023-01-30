import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({Key? key}) : super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final List<String> _categoryItem = [
    "Tanamanku",
    "Manggot",
    "Biogas",
    "Listrik Ramah Lingkungan",
  ];
  TextEditingController plantTypeController = TextEditingController();
  TextEditingController plantDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tambah Artikel",
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
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: ListView(
          children: [
            CategoryInput(
              categoryItem: _categoryItem,
              callback: (value) => print("===> selectedCategory: $value"),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextFieldInput(
              labelText: "Jenis Tanaman",
              hintText: "Masukkan jenis tanaman",
              maxLength: null,
              controller: plantTypeController,
              callback: (value) => print(
                "==> plant type: $value",
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextFieldInput(
              labelText: "Deskripsi Tanaman",
              hintText: "Masukkan deskripsi tanaman",
              maxLength: null,
              controller: plantDescriptionController,
              callback: (value) => print(
                "==> plant description: $value",
              ),
            ),
            const SizedBox(
              height: 46.0,
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
                      action: () => print("==> Cancel delete article"),
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Expanded(
                    child: CarbonRoundedButton(
                      label: "Kirim",
                      backgroundColor: ColorPalettes.primary,
                      borderColor: ColorPalettes.primary,
                      action: () => print("==> Kirim delete article"),
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

  @override
  void dispose() {
    plantTypeController.dispose();
    plantDescriptionController.dispose();
    super.dispose();
  }
}
