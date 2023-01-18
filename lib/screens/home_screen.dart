import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                const SizedBox(
                  height: 56.0,
                  width: 56.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      Images.dummyProfile,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Halo, ",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorPalettes.black,
                              fontWeight: FontWeight.w400,
                            ),
                        children: [
                          TextSpan(
                            text: "Keyra",
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorPalettes.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: ColorPalettes.primary.withOpacity(0.2),
                      ),
                      child: Text(
                        "Eco-Newbie",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.primary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_rounded,
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 13,
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: ColorPalettes.primary,
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: ColorPalettes.background,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Stack(
              children: [
                Container(
                  height: 430,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    image: DecorationImage(
                      image: const AssetImage(
                        Images.dummyHome,
                      ),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        ColorPalettes.blackZill.withOpacity(0.9),
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 20.0,
                  right: 20.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apa itu Daur Karbon?",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 18.0,
                              color: ColorPalettes.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "Daur karbon merupakan siklus pertukaran yang berlangsung"
                        " terus menerus antara komponen abiotik dengan komponen"
                        " biotik yang sudah ada di bumi sejak jutaan tahun.",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   bottom: 0.0,
            //   child: Text(
            //     "Apa itu Daur Karbon?",
            //     style: Theme.of(context).textTheme.bodyText2?.copyWith(
            //       fontSize: 18.0,
            //       color: ColorPalettes.white,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
