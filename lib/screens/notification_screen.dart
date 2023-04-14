import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';
import '../routes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository =
                RepositoryProvider.of<NotificationRepository>(context);

            return NotificationBloc(repository)
              ..add(
                LoadNotification(
                  status: "Aktif",
                ),
              );
          },
        ),
      ],
      child: const NotificationContent(),
    );
  }
}

class NotificationContent extends StatefulWidget {
  const NotificationContent({Key? key}) : super(key: key);

  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
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
                  onTap: (index) =>
                      BlocProvider.of<NotificationBloc>(context).add(
                    LoadNotification(
                      status: index == 0 ? "Aktif" : "Tidak Aktif",
                    ),
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
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 10.0,
          ),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              NotificationTabContent(
                status: 'Aktif',
              ),
              NotificationTabContent(
                status: 'Tidak Aktif',
              ),
              // _buildTab1Widget(context),
              // _buildTab2Widget(context),
              // _buildTab2Widget(context),
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

class NotificationTabContent extends StatefulWidget {
  final String status;

  const NotificationTabContent({
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationTabContent> createState() => _NotificationTabContentState();
}

class _NotificationTabContentState extends State<NotificationTabContent>
    with AutomaticKeepAliveClientMixin {
  final _scrollControllerContent = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: _actionBlocListener,
      builder: (context, state) {
        if (state is ListNotificationError) {
          return const CarbonErrorState();
        }

        if (state is ListNotificationEmpty) {
          return const CarbonEmptyState();
        }

        if (state is ListNotificationLoaded) {
          var data = state.notificationList;

          return ListView.separated(
            physics: const ClampingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return NotificationItem(
                onTap: () => BlocProvider.of<NotificationBloc>(context).add(
                  LoadDetailNotification(
                    id: data[index].id,
                  ),
                ),
                imageUrl: data[index].title != null &&
                        data[index].title!.contains("berhasil")
                    ? CarbonIcons.success
                    : CarbonIcons.failed,
                notificationLabel: data[index].title,
                notificationCaption: data[index].desc,
                timeStamp:
                    DateUtil.sanitizeDateTime(data[index].createdAt ?? "-"),
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

        return const CarbonLoadingState();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollControllerContent.dispose();
    super.dispose();
  }

  void _actionBlocListener(
    BuildContext context,
    NotificationState state,
  ) {
    if (state is DetailNotificationLoaded) {
      // close progress dialog
      Navigator.of(context).pop();

      if (state.notificationDetail.type != null &&
          state.notificationDetail.type == "Article") {
        Navigator.pushReplacementNamed(
          context,
          Routes.detailArticle,
          arguments: DataArgument(
            id: state.notificationDetail.idArticle ?? "0",
          ),
        );
      } else if (state.notificationDetail.type != null &&
          state.notificationDetail.type == "Activity") {
        Navigator.pushReplacementNamed(
          context,
          Routes.detailEcoUpdate,
          arguments: DataArgument(
            id: state.notificationDetail.idArticle ?? "0",
          ),
        );
      }
    } else if (state is DetailNotificationError) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ??
            "Terjadi kesalahan, silahkan coba lagi nanti.",
      );
    } else if (state is DetailNotificationLoading) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(),
      );
    }
  }
}
