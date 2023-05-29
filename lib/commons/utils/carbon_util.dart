import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';

class CarbonUtil {
  static String getEmisiIcon(String category) {
    if (category == 'Makanan') {
      return CarbonIcons.food2;
    } else if (category == 'Alat Elektronik') {
      return CarbonIcons.tv;
    } else if (category == 'Listrik Ramah Lingkungan') {
      return CarbonIcons.electric;
    } else if (category == 'Sampah') {
      return CarbonIcons.trash;
    } else if (category == 'Transportasi') {
      return CarbonIcons.car3;
    } else {
      return CarbonIcons.cloth2;
    }
  }

  static Color getEmisiBackgroundColor(String category) {
    if (category == 'Makanan') {
      return ColorPalettes.orange.withOpacity(0.1);
    } else if (category == 'Alat Elektronik') {
      return ColorPalettes.blue.withOpacity(0.15);
    } else if (category == 'Listrik Ramah Lingkungan') {
      return ColorPalettes.orange.withOpacity(0.1);
    } else if (category == 'Sampah') {
      return ColorPalettes.green.withOpacity(0.15);
    } else if (category == 'Transportasi') {
      return ColorPalettes.blue.withOpacity(0.15);
    } else if (category == 'Pakaian') {
      return ColorPalettes.blue.withOpacity(0.15);
    } else {
      return ColorPalettes.orange.withOpacity(0.1);
    }
  }

  static String getCategoryIcon(String? category) {
    if (category == 'Transportasi') {
      return CarbonIcons.car;
    } else if (category == 'Makanan') {
      return CarbonIcons.food2;
    } else if (category == 'Alat Elektronik') {
      return CarbonIcons.tv2;
    } else if (category == 'Listrik Ramah Lingkungan') {
      return CarbonIcons.electric;
    } else if (category == 'Pembelian Pakaian') {
      return CarbonIcons.cloth;
    } else if (category == 'Sampah') {
      return CarbonIcons.trash2;
    } else {
      return CarbonIcons.trash2;
    }
  }
}
