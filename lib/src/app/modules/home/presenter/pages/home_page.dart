import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/VOs/home_drawer_vo.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_drawer.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/mount_getted_places.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';

class HomePage extends StatefulWidget {
  static const route = '/home/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends SafeState<HomePage, HomeBloc>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    verifyLocationPermission();
    super.initState();
    initTabController();
  }

  void verifyLocationPermission() async {
    WidgetsBinding.instance.waitUntilFirstFrameRasterized.then((_) async {
      await bloc.verifyLocationPermission();
    });
  }

  void initTabController() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
      animationDuration: Duration.zero,
    );

    tabController.addListener(() async {
      await bloc.onTabIndexChange(tabController.index);
      setState(() {});
    });
  }

  void openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
    bloc.getHomeDrawerInfo();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabController.length,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: SafeBuilder<HomeDrawerVO>(
          stream: bloc.userDrawerData,
          builder: (userDrawerData) => HomeDrawer(
            name: userDrawerData.userName,
            image: userDrawerData.userImage,
          ),
        ),
        appBar: const SafeAppBar().home(
          tabController: tabController,
          onOpenDrawer: () => openEndDrawer(),
        ),
        body: SafeBuilder2<List<LocationEntity>, List<LocationEntity>>(
            stream1: bloc.locationsNearUser,
            stream2: bloc.bestRatedPlaces,
            builder: (listLocationsNearUser, listBestRatedPlaces) {
              return TabBarView(
                controller: tabController,
                children: [
                  MountGettedPlaces(
                    list: listLocationsNearUser,
                    onEmpty: SafeEmptyCard.homeNearLocations(),
                  ),
                  MountGettedPlaces(
                    list: listBestRatedPlaces,
                    onEmpty: SafeEmptyCard.homeBestRated(),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
