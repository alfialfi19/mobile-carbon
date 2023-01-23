import 'package:flutter/material.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/routes.dart';
import 'package:mobile_carbon/widgets/rounded_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    height: 12.0,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                      onTap: () {},
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
                    action: () => Navigator.pushNamed(
                      context,
                      Routes.main,
                    ),
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
                    action: () {},
                  ),
                  const SizedBox(
                    height: 103.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: 'Belum punya akun? ',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.grayZill,
                              fontWeight: FontWeight.w400,
                            ),
                        children: [
                          TextSpan(
                            text: 'Daftar Sekarang',
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
