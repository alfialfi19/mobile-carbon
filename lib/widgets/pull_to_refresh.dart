import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PullToRefresh extends StatelessWidget {
  final Future Function() onRefresh;
  final ScrollController controller;
  final List<Widget> slivers;
  final Color indicatorColor;
  final Color backgroundColor;
  const PullToRefresh({
    required this.onRefresh,
    required this.controller,
    required this.slivers,
    this.indicatorColor = const Color(0xFF3C3C44),
    this.backgroundColor = Colors.transparent,
    Key? key,
  }) : super(key: key);

  Widget get _androidBody => RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: slivers,
        ),
      );

  Widget get _iosBody => CustomScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
            builder: (_, __, ___, ____, _____) {
              return ColoredBox(
                color: backgroundColor,
                child: Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      indicatorColor,
                      BlendMode.srcATop,
                    ),
                    child: const CupertinoActivityIndicator(
                      radius: 12.0,
                    ),
                  ),
                ),
              );
            },
          ),
          ...slivers,
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Platform.isAndroid ? _androidBody : _iosBody,
    );
  }
}
