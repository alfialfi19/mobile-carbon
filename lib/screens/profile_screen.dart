import 'package:flutter/material.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profil Pengguna",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 18.0,
                color: ColorPalettes.dark,
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: ColorPalettes.backgroundLight,
        elevation: 0.0,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: PullToRefresh(
          controller: _scrollController,
          onRefresh: () => _refresh(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(
                      bottom: 40.0,
                    ),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              Images.dummyProfileBig,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Container(
                            height: 36.0,
                            width: 36.0,
                            decoration: BoxDecoration(
                              color: ColorPalettes.primary,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: ColorPalettes.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Informasi Pribadi",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.editProfile,
                        ),
                        child: Text(
                          "Ubah",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: const Divider(
                      color: ColorPalettes.line,
                    ),
                  ),
                  PersonalInformationItem(
                    label: "Nama",
                    value: "Keyra Allisya Keenan",
                  ),
                  PersonalInformationItem(
                    label: "Email",
                    value: "keyraa@gmail.com",
                  ),
                  PersonalInformationItem(
                    label: "Nomor Telepon",
                    value: "08756142843",
                  ),
                  PersonalInformationItem(
                    label: "Alamat",
                    value: "Jalan Pusaka No. 07, Kabupaten Malang",
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: CarbonRoundedButton(
                      label: "Keluar",
                      labelColor: ColorPalettes.white,
                      backgroundColor: ColorPalettes.redConfirmation,
                      borderColor: ColorPalettes.redConfirmation,
                      action: () => _showConfirmation(context),
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

  Future<void> _showConfirmation(BuildContext context) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => SignOutConfirmation(
        label: "Apakah Anda yakin untuk keluar?",
        caption:
            "Setelah Anda keluar dari aplikasi, Anda diharapkan untuk memasukkan "
            "email password untuk masuk kembali.",
        negativeCallback: () => Navigator.pop(context),
        positiveLabel: "Keluar",
        positiveCallback: () => Navigator.pushReplacementNamed(
          context,
          Routes.onBoarding1,
        ),
      ),
    );

    if (data != null) {
      // do something
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
