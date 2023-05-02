import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/VOs/home_drawer_vo.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_drawer.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/mount_getted_places.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/need_permission_card.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class HomePage extends StatefulWidget {
  static const route = '/home/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeBloc>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController tabController;

  @override
  void initState() {
    WidgetsBinding.instance.waitUntilFirstFrameRasterized.then((_) async {
      await controller.requestAccessLocationPermission();
    });
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        controller.onTabIndexChange(tabController.index);
      });
    });
    SafeLogUtil.instance.route(Modular.to.path);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabController.length,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: StreamBuilder<SafeStream<HomeDrawerVO>>(
          initialData: controller.lastDrawerEvent,
          stream: controller.userDrawerDataController.stream,
          builder: (context, snapshot) {
            HomeDrawerVO? userData = snapshot.data?.data;
            userData ??= controller.lastDrawerEvent.data;
            return HomeDrawer(
              name: userData?.userName,
              image: userData?.userImage == null ||
                      userData?.userImage.isEmpty == true
                  ? PlaceHolderAssets.profileAvatar
                  : userData!.userImage,
            );
          },
        ),
        appBar: const SafeAppBar().home(
          tabController: tabController,
          onOpenDrawer: () {
            _scaffoldKey.currentState!.openEndDrawer();
            controller.getHomeDrawerInfo();
          },
          onBottomTap: (tab) async {
            await controller.onTabIndexChange(
              tab,
              isForceReload: true,
            );
          },
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            MountGettedPlaces(
              stream: controller.locationsNearUserController.stream,
              list: controller.listLocationsNeartUser,
              showErrorDialog: true,
              onEmpty: SafeEmptyCard.homeNearLocations(),
              onError: NeedPermissionCard(
                text: S.current.textErrorLocationPermission,
                buttonText: S.current.textOpenPermissions,
                onTapButton: () async {
                  await controller.forcedRequestLocationPermission().then(
                    (granted) async {
                      if (granted) {
                        await controller.getLocationsNearUser();
                      }
                    },
                  );
                },
              ),
            ),
            MountGettedPlaces(
              stream: controller.bestRatedPlacesController.stream,
              list: controller.listBestRatedPlaces,
            ),
          ],
        ),
      ),
    );
  }
}
