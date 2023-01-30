import 'package:flutter/material.dart';

import 'routes.dart';
import 'screens/screens.dart';

Widget? getPageByName(
  String? name, {
  bool nonNullable = false,
}) {
  switch (name) {
    case Routes.addArticle:
      return const AddArticleScreen();
    case Routes.detailArticle:
      return const DetailArticleScreen();
    case Routes.detailCarbonEmission:
      return const DetailCarbonEmissionScreen();
    case Routes.detailComment:
      return const DetailCommentScreen();
    case Routes.detailEcoActivity:
      return const DetailEcoActivityScreen();
    case Routes.detailTotalArticle:
      return const DetailTotalArticleScreen();
    case Routes.ecoUpdate:
      return const EcoUpdateScreen();
    case Routes.home:
      return const HomeScreen();
    case Routes.main:
      return const MainScreen();
    case Routes.myArticle:
      return const MyArticleScreen();
    case Routes.notFound:
      return const NotFoundScreen();
    case Routes.onBoarding1:
      return const OnBoarding1Screen();
    case Routes.onBoarding2:
      return const OnBoarding2Screen();
    case Routes.onBoarding3:
      return const OnBoarding3Screen();
    case Routes.onBoarding4:
      return const OnBoarding4Screen();
    case Routes.point:
      return const PointScreen();
    case Routes.profile:
      return const ProfileScreen();
    case Routes.signIn:
      return const SignInScreen();
    case Routes.splash:
      return const SplashScreen();
  }

  if (nonNullable) {
    return const NotFoundScreen();
  }
  return null;
}
