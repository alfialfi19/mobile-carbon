import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/routes.dart';

import '../widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) {
        final repository = RepositoryProvider.of<AuthRepository>(context);

        return AuthBloc(repository);
      },
      child: const SignInContent(),
    );
  }
}

class SignInContent extends StatefulWidget {
  const SignInContent({Key? key}) : super(key: key);

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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
                      "Masuk",
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
                      "Silahkan masukkan Email dan Kata Sandi untuk Masuk",
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
                      height: 12.0,
                    ),
                    Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.forgetPassword,
                        ),
                        child: Text(
                          "Lupa Kata Sandi?",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.primary,
                                fontWeight: FontWeight.w600,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 43.0,
                    ),
                    RoundedButton(
                      margin: 0.0,
                      label: 'Masuk',
                      action: () => _onClickSignIn(context),
                    ),
                    const SizedBox(
                      height: 43.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 1.0,
                            color: ColorPalettes.line,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Atau",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: ColorPalettes.grayZill,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 1.0,
                            color: ColorPalettes.line,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 43.0,
                    ),
                    RoundedButton(
                      margin: 0.0,
                      backgroundColor: ColorPalettes.white,
                      labelColor: ColorPalettes.black,
                      borderColor: ColorPalettes.line,
                      label: 'Masuk dengan akun Google',
                      action: () {
                        signInWithGoogle();
                      },
                    ),
                    const SizedBox(
                      height: 103.0,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        Routes.register,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: 'Belum punya akun? ',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.grayZill,
                                      fontWeight: FontWeight.w400,
                                    ),
                            children: [
                              TextSpan(
                                text: 'Daftar Sekarang',
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

  Future<void> signInWithGoogle() async {
    print("===> enter method");
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    print("===> googleSignInAccount: $googleSignInAccount");
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    print("===> googleSignInAuthentication: $googleSignInAuthentication");

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    print("===> credential: $credential");
    var authResult = await _firebaseAuth.signInWithCredential(credential);

    print("===> auth result: $authResult");
    print("===> auth users: ${authResult.user}");
  }

  void _onClickSignIn(BuildContext context) {
    if (emailController.text.isBlank || passwordController.text.isBlank) {
      ToastUtil.error(context, "Pastikan email dan password tidak kosong");
    } else {
      BlocProvider.of<AuthBloc>(context).add(
        SignIn(
          emailController.text,
          passwordController.text,
        ),
      );
    }
  }

  void _onAuthListener(BuildContext context, AuthState state) {
    if (state is SignInFailed) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
          context, state.errorResponse.errors ?? "Terjadi kesalahan");
    } else if (state is SignInSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      Navigator.pushReplacementNamed(
        context,
        Routes.main,
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
    passwordController.dispose();
    super.dispose();
  }
}
