import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../repositories/repositories.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
      child: const ProfileContent(),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
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
          onRefresh: _refresh,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is DetailAccountError) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          alignment: Alignment.center,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Oops, terjadi kesalahan. Silahkan coba lagi nanti.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              CarbonRoundedButton(
                                label: 'Coba lagi',
                                action: _refresh,
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is DetailAccountLoaded) {
                        var data = state.accountDetail;

                        return Column(
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
                                  SizedBox(
                                    height: 100.0,
                                    width: 100.0,
                                    child: data.file != null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              data.file!,
                                            ),
                                          )
                                        : const CircleAvatar(
                                            backgroundImage: AssetImage(
                                              Images.dummyProfileBig,
                                            ),
                                          ),
                                  ),
                                  // Positioned(
                                  //   bottom: 0.0,
                                  //   right: 0.0,
                                  //   child: Container(
                                  //     height: 36.0,
                                  //     width: 36.0,
                                  //     decoration: BoxDecoration(
                                  //       color: ColorPalettes.primary,
                                  //       borderRadius:
                                  //           BorderRadius.circular(100.0),
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: const Icon(
                                  //       Icons.camera_alt_rounded,
                                  //       color: ColorPalettes.white,
                                  //       size: 20.0,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Informasi Pribadi",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color: ColorPalettes.dark,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.editProfile,
                                    arguments: AccountArgument(
                                      name: data.fullName,
                                      email: data.email,
                                      phone: data.phone,
                                      address: data.address,
                                    ),
                                  ),
                                  child: Text(
                                    "Ubah",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
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
                              value: data.fullName,
                            ),
                            PersonalInformationItem(
                              label: "Email",
                              value: data.email,
                            ),
                            PersonalInformationItem(
                              label: "Nomor Telepon",
                              value: data.phone,
                            ),
                            PersonalInformationItem(
                              label: "Alamat",
                              value: data.address,
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
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorPalettes.primary,
                        ),
                      );
                    },
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
        // positiveCallback: () => Navigator.pushReplacementNamed(
        //   context,
        //   Routes.onBoarding1,
        // ),
        positiveCallback: () {
          PrefHelper().removeUserSession();

          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.signIn,
            (route) => false,
          );
        },
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
    BlocProvider.of<AuthBloc>(context).add(
      LoadDetailAccount(),
    );
  }
}
