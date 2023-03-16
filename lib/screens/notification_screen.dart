import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorPalettes.backgroundLight,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Notifikasi",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontSize: 18.0,
                  color: ColorPalettes.dark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          backgroundColor: ColorPalettes.backgroundLight,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: ColorPalettes.dark,
            ),
          ),
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TabBar(
                  isScrollable: true,
                  labelColor: ColorPalettes.dark,
                  unselectedLabelColor: ColorPalettes.placeholderZill,
                  labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                  tabs: const [
                    Tab(
                      text: 'Terbaru',
                    ),
                    Tab(text: 'Telah Dibaca'),
                  ],
                  indicatorColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 20.0,
          ),
          child: TabBarView(
            children: [
              _buildTab1Widget(context),
              _buildTab2Widget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab1Widget(BuildContext context) {
    List<String> _mockImageUrl = [
      CarbonIcons.success,
      CarbonIcons.success,
      CarbonIcons.success,
      CarbonIcons.failed,
      CarbonIcons.success,
      CarbonIcons.failed,
      CarbonIcons.success,
      CarbonIcons.success,
      CarbonIcons.failed,
      CarbonIcons.failed,
    ];

    List<String> _mockLabel = [
      "Artikel berhasil dipublikasi",
      "Artikel berhasil dipublikasi",
      "Artikel berhasil dipublikasi",
      "Artikel gagal dipublikasi",
      "Artikel berhasil dipublikasi",
      "Artikel gagal dipublikasi",
      "Artikel berhasil dipublikasi",
      "Artikel berhasil dipublikasi",
      "Artikel gagal dipublikasi",
      "Artikel gagal dipublikasi",
    ];

    List<String> _mockCaption = [
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "berhasil dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "berhasil dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "berhasil dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "gagal dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "berhasil dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "gagal dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "berhasil dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "berhasil dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "gagal dipublikasi",
      "Artikel 'Cara Budidaya maggot dengan Media Kompos' telah "
          "berhasil dipublikasi",
    ];

    List<String> _mockTimeStamp = [
      "10 menit yang lalu",
      "30 menit yang lalu",
      "10 jam yang lalu",
      "5 hari yang lalu",
      "7 hari yang lalu",
      "8 hari yang lalu",
      "12 hari yang lalu",
      "15 hari yang lalu",
      "20 hari yang lalu",
      "25 hari yang lalu",
    ];

    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      itemCount: _mockLabel.length,
      itemBuilder: (context, index) {
        return NotificationItem(
          imageUrl: _mockImageUrl[index],
          notificationLabel: _mockLabel[index],
          notificationCaption: _mockCaption[index],
          timeStamp: _mockTimeStamp[index],
        );
      },
      separatorBuilder: (context, index) => Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: const Divider(
          color: ColorPalettes.line,
        ),
      ),
    );
  }

  Widget _buildTab2Widget(BuildContext context) {
    return Container(
      height: double.maxFinite,
      alignment: Alignment.center,
      child: Text(
        "Belum ada notifikasi",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorPalettes.placeholderZill,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
