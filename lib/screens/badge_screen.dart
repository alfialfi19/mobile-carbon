import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Lencana",
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
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        color: ColorPalettes.backgroundLight,
        child: ListView(
          children: [
            Text(
              "Apa itu lencana?",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              "Lencana adalah penamaan untuk level dari akun seseorang yang "
              "akan diambil dari total poin yang telah mereka miliki. "
              "Semakin tinggi tingkatan yang mereka peroleh, maka semakin "
              "tinggi juga level lencana yang akan dimiliki oleh pengguna.",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "Bagaimana cara menaikkan level lencana?",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              "1. Menanam banyak tanaman",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.justify,
            ),
            Text(
              "2. Mengurangi penggunaan kendaraan bermotor",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.justify,
            ),
            Text(
              "3. Penghematan listrik",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.justify,
            ),
            Text(
              "4. Memilih makanan dan minuman produk lokal",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "Level Lencana",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              height: 120.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                children: const [
                  BadgeLevelItemGradient(),
                  BadgeLevelItemFlat(
                    badgeLabel: "Eco-elite",
                  ),
                  BadgeLevelItemFlat(
                    badgeLabel: "Eco-legend",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
