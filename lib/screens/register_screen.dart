import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';

import '../blocs/blocs.dart';
import '../repositories/repositories.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) {
        final repository = RepositoryProvider.of<AuthRepository>(context);

        return AuthBloc(repository);
      },
      child: const RegisterContent(),
    );
  }
}

class RegisterContent extends StatefulWidget {
  const RegisterContent({Key? key}) : super(key: key);

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: _onAuthListener,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(
              40.0,
              92.0,
              40.0,
              0.0,
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daftar",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: ColorPalettes.black,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Silahkan masukkan Nama, Email dan Kata Sandi untuk "
                      "Daftar Akun",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorPalettes.grayZill,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Nama',
                        prefixIcon: const Icon(Icons.person_add_alt_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalettes.grayTextField,
                          ),
                        ),
                        focusColor: ColorPalettes.primary,
                        filled: true,
                        fillColor: ColorPalettes.grayTextField,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Alamat Email',
                        prefixIcon: const Icon(Icons.mail_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalettes.grayTextField,
                          ),
                        ),
                        focusColor: ColorPalettes.primary,
                        filled: true,
                        fillColor: ColorPalettes.grayTextField,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Kata Sandi',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalettes.grayTextField,
                          ),
                        ),
                        focusColor: ColorPalettes.primary,
                        filled: true,
                        fillColor: ColorPalettes.grayTextField,
                      ),
                    ),
                    const SizedBox(
                      height: 43.0,
                    ),
                    RoundedButton(
                      margin: 0.0,
                      label: 'Daftar',
                      action: () => _onClickRegister(context),
                    ),
                    const SizedBox(
                      height: 43.0,
                    ),
                    const SizedBox(
                      height: 103.0,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        Routes.signIn,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: 'Sudah punya akun? ',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.grayZill,
                                      fontWeight: FontWeight.w400,
                                    ),
                            children: [
                              TextSpan(
                                text: 'Masuk Sekarang',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      color: ColorPalettes.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onClickRegister(BuildContext context) {
    if (nameController.text.isBlank ||
        emailController.text.isBlank ||
        passwordController.text.isBlank) {
      ToastUtil.error(context, "Pastikan field tidak kosong");
    } else {
      BlocProvider.of<AuthBloc>(context).add(
        Register(
          nameController.text,
          emailController.text,
          passwordController.text,
        ),
      );
    }
  }

  void _onAuthListener(BuildContext context, AuthState state) {
    if (state is RegisterSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.info(
        context,
        state.registerResponse,
      );

      Navigator.pushReplacementNamed(
        context,
        Routes.signIn,
      );
    } else if (state is RegisterFailed) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ?? "Terjadi kesalahan",
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
