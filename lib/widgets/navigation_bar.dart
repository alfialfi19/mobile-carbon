import 'package:flutter/material.dart';

import '../commons/commons.dart';

class MyNavigationBar extends StatefulWidget {
  final Color itemColor;
  final List<NavigationBarItem> children;
  final Function(int)? onChange;
  final int currentIndex;

  const MyNavigationBar({
    required this.children,
    this.itemColor = ColorPalettes.primary,
    this.onChange,
    this.currentIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kBottomNavigationBarHeight,
        color: ColorPalettes.white,
        child: Row(
          children: widget.children.map((item) {
            final label = item.label;
            final itemColor = widget.itemColor;
            final index = widget.children.indexOf(item);
            final iconUrl = widget.currentIndex == index
                ? item.onSelectedIconUrl
                : item.iconUrl;
            final color =
                widget.currentIndex == index ? itemColor : ColorPalettes.line;
            final indicatorColor =
                widget.currentIndex == index ? itemColor : ColorPalettes.white;
            final backgroundColor = widget.currentIndex == index
                ? ColorPalettes.backgroundNavbar
                : ColorPalettes.white;
            final badgeLabel = item.badgeLabel;
            final labelWeight = widget.currentIndex == index
                ? FontWeight.w600
                : FontWeight.w400;

            final tabItem = IconLabelTab(
              onTap: () => _changeIndex(index),
              label: label,
              badgeLabel: badgeLabel,
              iconUrl: iconUrl,
              color: color,
              indicatorColor: indicatorColor,
              backgroundColor: backgroundColor,
              labelWeight: labelWeight,
            );

            return Expanded(
              child: tabItem,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class IconLabelTab extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final FontWeight labelWeight;
  final String? badgeLabel;
  final String iconUrl;
  final Color? color;
  final Color? indicatorColor;
  final Color? backgroundColor;

  const IconLabelTab({
    required this.onTap,
    required this.label,
    required this.iconUrl,
    this.labelWeight = FontWeight.w400,
    this.badgeLabel,
    this.color,
    this.indicatorColor,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(
                12.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconUrl,
                  height: 28,
                  width: 28,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Container(
                  height: 4.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                  ),
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ],
            ),
          ),
          if (badgeLabel != null)
            Positioned.fill(
              top: -3,
              right: -24,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalettes.red400,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 6.0,
                  ),
                  child: Text(
                    badgeLabel ?? "-",
                    style: Theme.of(context)
                        .textTheme
                        .overline
                        ?.copyWith(fontSize: 10.0, color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NavigationBarItem {
  final String iconUrl;
  final String onSelectedIconUrl;
  final String label;
  final String? badgeLabel;

  NavigationBarItem({
    required this.iconUrl,
    required this.onSelectedIconUrl,
    required this.label,
    this.badgeLabel,
  });
}
