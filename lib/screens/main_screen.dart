import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/commons/commons.dart';

import '../blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

const screenHome = 0;
const screenEcoUpdate = 1;
const screenPoint = 2;
const screenProfile = 3;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (context) {
            return MainBloc();
          },
        ),
      ],
      child: const MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    _pages = <Widget>[
      const HomeScreen(),
      const EcoUpdateScreen(),
      const PointScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: MyNavigationBar(
            currentIndex: state.currentIndex,
            onChange: _onChangePage,
            children: [
              NavigationBarItem(
                label: "Home",
                iconUrl: CarbonIcons.homeInactive,
                onSelectedIconUrl: CarbonIcons.homeActive,
              ),
              NavigationBarItem(
                label: "Eco Update",
                iconUrl: CarbonIcons.ecoUpdateInactive,
                onSelectedIconUrl: CarbonIcons.ecoUpdateActive,
              ),
              NavigationBarItem(
                label: "Point",
                iconUrl: CarbonIcons.pointInactive,
                onSelectedIconUrl: CarbonIcons.pointActive,
              ),
              NavigationBarItem(
                label: "Profile",
                iconUrl: CarbonIcons.profileInactive,
                onSelectedIconUrl: CarbonIcons.profileActive,
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: _pages[state.currentIndex],
          ),
        );
      },
    );
  }

  void _onChangePage(int index) {
    BlocProvider.of<MainBloc>(context).add(MainScreenChange(
      index: index,
    ));
  }
}
