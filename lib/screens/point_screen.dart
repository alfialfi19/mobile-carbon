import 'package:flutter/material.dart';

import '../commons/commons.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({Key? key}) : super(key: key);

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorPalettes.greenGradient1,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorPalettes.ecoGradient1,
                  ColorPalettes.ecoGradient2,
                ],
              ),
            ),
          ),
          elevation: 0.0,
          toolbarHeight: 40.0,
          backgroundColor: ColorPalettes.greenGradient1,
          leading: Container(),
          leadingWidth: 0.0,
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            labelColor: ColorPalettes.white,
            unselectedLabelColor: ColorPalettes.white.withOpacity(0.5),
            labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
            tabs: const [
              Tab(
                text: 'Emisi Karbon',
              ),
              Tab(text: 'Eco-Activity'),
              Tab(
                text: 'Jumlah Artikel',
              ),
            ],
            indicatorColor: Colors.transparent,
          ),
        ),
        body: TabBarView(
          children: [
            _buildTab1Widget(context),
            _buildTab2Widget(context),
            _buildTab3Widget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTab1Widget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ColorPalettes.ecoGradient1,
            ColorPalettes.ecoGradient2,
          ],
        ),
      ),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 50.0,
                  left: 50.0,
                ),
                child: InkWell(
                  onTap: () => print("==> Apa itu lencana"),
                  child: Container(
                    height: 24.0,
                    width: 24.0,
                    decoration: BoxDecoration(
                      color: ColorPalettes.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: const Icon(
                      Icons.question_mark_rounded,
                      size: 14.0,
                      color: ColorPalettes.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    height: 46.0,
                    width: 94.0,
                    decoration: const BoxDecoration(
                      color: ColorPalettes.orange2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          16.0,
                        ),
                        topRight: Radius.circular(
                          16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 17.0,
                ),
                Expanded(
                  child: Container(
                    height: 80.0,
                    width: 94.0,
                    decoration: const BoxDecoration(
                      color: ColorPalettes.orange2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          16.0,
                        ),
                        topRight: Radius.circular(
                          16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 17.0,
                ),
                Expanded(
                  child: Container(
                    height: 40.0,
                    width: 94.0,
                    decoration: const BoxDecoration(
                      color: ColorPalettes.orange2,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          16.0,
                        ),
                        topRight: Radius.circular(
                          16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 43.0,
            ),
            decoration: const BoxDecoration(
              color: ColorPalettes.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  24.0,
                ),
                topRight: Radius.circular(
                  24.0,
                ),
              ),
            ),
            child: Text("This is tab 1"),
          ),
          Text("Test test 1"),
          Text("Lorem ipsum til damet 1"),
        ],
      ),
    );
  }

  Widget _buildTab2Widget(BuildContext context) {
    return ListView(
      children: [
        Text("This is tab 2"),
        Text("Test test 2"),
        Text("Lorem ipsum til damet 2"),
      ],
    );
  }

  Widget _buildTab3Widget(BuildContext context) {
    return ListView(
      children: [
        Text("This is tab 3"),
        Text("Test test 3"),
        Text("Lorem ipsum til damet 3"),
      ],
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
