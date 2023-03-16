import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../repositories/repositories.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) {
        final repository = RepositoryProvider.of<AuthRepository>(context);

        return AuthBloc(repository);
      },
      child: const ForgetPasswordContent(),
    );
  }
}

class ForgetPasswordContent extends StatefulWidget {
  const ForgetPasswordContent({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordContent> createState() => _ForgetPasswordContentState();
}

class _ForgetPasswordContentState extends State<ForgetPasswordContent> {
  final emailController = TextEditingController();

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
                      "Lupa Kata Sandi",
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
                      "Masukkan email terdaftar untuk mereset kata sandi",
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
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                      height: 43.0,
                    ),
                    RoundedButton(
                      margin: 0.0,
                      label: 'Kirimkan',
                      action: () => _onClickForgetPassword(context),
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

  void _onClickForgetPassword(BuildContext context) {
    if (emailController.text.isBlank) {
      ToastUtil.error(context, "Pastikan email tidak kosong");
    } else {
      BlocProvider.of<AuthBloc>(context).add(
        ForgetPassword(
          emailController.text,
        ),
      );
    }
  }

  void _onAuthListener(BuildContext context, AuthState state) {
    if (state is ForgetPasswordSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.info(
        context,
        state.forgetPasswordResponse,
      );

      Navigator.pushReplacementNamed(
        context,
        Routes.signIn,
      );
    } else if (state is ForgetPasswordFailed) {
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
    emailController.dispose();
    super.dispose();
  }
}
