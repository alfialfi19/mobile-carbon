import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../repositories/repositories.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final repository = RepositoryProvider.of<AuthRepository>(context);

            return AuthBloc(repository)
              ..add(
                LoadDetailAccount(),
              );
          },
        ),
      ],
      child: const BadgeContent(),
    );
  }
}

class BadgeContent extends StatefulWidget {
  const BadgeContent({Key? key}) : super(key: key);

  @override
  State<BadgeContent> createState() => _BadgeContentState();
}

class _BadgeContentState extends State<BadgeContent> {
  String userBadgeLevel = "";

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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is DetailAccountLoaded) {
            userBadgeLevel = state.accountDetail.level ?? "-";
          }

          return Container(
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
                  "diambil dari total poin yang telah mereka miliki. "
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
                  "Bagaimana sistem untuk menaikkan lencana?",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  "1. Level lencana akan ter-reset setiap awal bulan",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "2. Level pengguna akan naik ketika poin pengguna memenuhi syarat"
                  " dalam ketentuan kenaikan level (Jumlah semua poin > 50 poin)",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "3. Jika total poin pengguna tidak memenuhi syarat untuk kenaikan"
                  " level, maka level pengguna tidak akan naik ataupun turun",
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "4. Jika pengguna tidak aktif selama satu bulan kedepan (tidak"
                  " terdapat penambahan poin selama sebulan), maka level lencana"
                  " akan turun menjadi Eco-Newbie",
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
                  height: 140.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      if (userBadgeLevel.contains("newbie")) ...[
                        const BadgeLevelItemGradient(
                          badgeLabel: "Eco-Newbie",
                        ),
                      ] else ...[
                        const BadgeLevelItemFlat(
                          badgeLabel: "Eco-Newbie",
                        ),
                      ],
                      const SizedBox(
                        width: 12.0,
                      ),
                      if (userBadgeLevel.contains("elit")) ...[
                        const BadgeLevelItemGradient(
                          badgeLabel: "Eco-Elite",
                        ),
                      ] else ...[
                        const BadgeLevelItemFlat(
                          badgeLabel: "Eco-Elite",
                        ),
                      ],
                      const SizedBox(
                        width: 12.0,
                      ),
                      if (userBadgeLevel.contains("legen")) ...[
                        const BadgeLevelItemGradient(
                          badgeLabel: "Eco-Legend",
                        ),
                      ] else ...[
                        const BadgeLevelItemFlat(
                          badgeLabel: "Eco-Legend",
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
