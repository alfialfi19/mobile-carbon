import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../../commons/commons.dart';

class OnBoardingSection extends StatelessWidget {
  final String imageHeader;
  final String label;
  final String caption;
  final int countStep;
  final String actionLabel;
  final VoidCallback actionCallback;

  const OnBoardingSection({
    Key? key,
    required this.imageHeader,
    required this.label,
    required this.caption,
    required this.countStep,
    required this.actionLabel,
    required this.actionCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            right: 0.0,
            left: 0.0,
            child: Image.asset(
              Images.onboardHeader,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 210.0,
            right: 25.0,
            left: 25.0,
            child: Image.asset(
              imageHeader,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 470.0,
            right: 0.0,
            left: 0.0,
            child: Container(
              margin: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  if (countStep != 4) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        label,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Mari mulai dengan ',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: ColorPalettes.dark,
                                    fontWeight: FontWeight.w600,
                                  ),
                          children: [
                            TextSpan(
                              text: 'Daur ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: ColorPalettes.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            TextSpan(
                              text: 'Karbon',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: ColorPalettes.dark,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      caption,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w300,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OnBoardingIndicator(
                        isActive: countStep == 1,
                      ),
                      OnBoardingIndicator(
                        isActive: countStep == 2,
                      ),
                      OnBoardingIndicator(
                        isActive: countStep == 3,
                      ),
                      OnBoardingIndicator(
                        isActive: countStep == 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  RoundedButton(
                    label: countStep == 4 ? "Mulai" : "Selanjutnya",
                    action: () => actionCallback.call(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
