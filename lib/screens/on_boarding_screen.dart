import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../commons/commons.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    PrefHelper().setAlreadyOnBoard(value: true);

    Navigator.pushReplacementNamed(
      context,
      Routes.signIn,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 187.0,
      ),
      child: Image.asset(
        assetName,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      imageFlex: 2,
      titlePadding: EdgeInsets.only(
        top: 30.0,
      ),
      bodyPadding: EdgeInsets.only(
        top: 6.0,
      ),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      onChange: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      globalHeader: Align(
        alignment: Alignment.center,
        child: Image.asset(
          Images.onboardHeader,
          fit: BoxFit.cover,
          width: double.maxFinite,
        ),
      ),
      globalFooter: Container(
        padding: const EdgeInsets.fromLTRB(
          30.0,
          0.0,
          30.0,
          50.0,
        ),
        child: RoundedButton(
          label: currentIndex == 3 ? "Mulai" : "Selanjutnya",
          action: () {
            if (currentIndex < 3) {
              introKey.currentState?.next();
            } else {
              _onIntroEnd.call(context);
            }
          },
        ),
      ),
      pages: [
        PageViewModel(
          titleWidget: Text(
            'Apa itu emisi karbon?',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            "Emisi karbon adalah proses pelepasan senyawa-senyawa "
            "karbon ke atmosfer bumi akibat fenomena dan kejadian yang terjadi dalam kehidupan kita.",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w300,
                ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage(Images.onboard1),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            'Apa penyebab emisi karbon?',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            "Penyebab emisi karbon yang dapat kita amati yaitu"
            " penggunaan bahan bakar fosil (minyak, gas bumi, dan batu bara)"
            " untuk memenuhi kebutuhan manusia.",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w300,
                ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage(Images.onboard2),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            'Apa dampak dari emisi karbon?',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            "Secara umum, dampak yang dapat dirasakan dari emisi karbon"
            " yaitu meningkatnya suhu bumi per tahun dan cuaca esktrem yang"
            " menyebabkan timbulnya berbagai penyakit baru yang berevolusi.",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w300,
                ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage(Images.onboard3),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: RichText(
            text: TextSpan(
              text: 'Mari mulai dengan ',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w600,
                  ),
              children: [
                TextSpan(
                  text: 'Daur ',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: ColorPalettes.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                TextSpan(
                  text: 'Karbon',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: ColorPalettes.dark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          bodyWidget: Text(
            "Aplikasi Daur Karbon akan membantu Anda untuk"
            " memantau jejak emisi karbon yang telah Anda"
            " keluarkan dan juga memberi informasi terkait"
            " dengan lingkungan sekitar Anda.",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w300,
                ),
            textAlign: TextAlign.center,
          ),
          image: _buildImage(Images.onboard4),
          decoration: pageDecoration,
        ),
      ],
      // onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showNextButton: false,
      showDoneButton: false,
      // showBackButton: true,
      // back: const Icon(Icons.arrow_back),
      // skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      // next: const Icon(Icons.arrow_forward),
      // done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      //rtl: true, // Display as right-to-left
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(8.0, 8.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(44.0, 8.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
