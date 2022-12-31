import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_drawer.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_location_card.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/mount_getted_places.dart';
import 'package:is_it_safe_app/src/app/modules/location/location_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class HomePage extends StatefulWidget {
  static const route = '/home/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final controller = Modular.get<HomeBloc>();

  @override
  void initState() {
    controller.getCurrentLocation().then((_) {
      controller.getLocationsNearUser();
    }).whenComplete(() {
      controller.userLocationController.stream.handleError(
        (x) => SafeSnackBar(
          message: S.current.textErrorGetLocation,
          type: SnackBarType.error,
        ),
      );
    });
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: const HomeDrawer(),
        appBar: const SafeAppBar().home(
          onOpenDrawer: () => _scaffoldKey.currentState!.openEndDrawer(),
          onBottomTap: (tab) async {
            //TODO manter comentado mediante implementação da feature
            if (tab == 0) {
              await controller.getCurrentLocation().whenComplete(() {
                controller.userLocationController.stream.handleError(
                  (x) => SafeSnackBar(
                    message: S.current.textErrorGetLocation,
                    type: SnackBarType.error,
                  ),
                );
              });
              await controller.getLocationsNearUser();
            }
            if (tab == 1) controller.getBestRatedPlaces();
          },
        ),
        body: TabBarView(
          children: [
            MountGettePlaces(
              stream: controller.locationsNearUserController.stream,
              list: controller.listLocationsNeartUser,
              onEmpty: SafeEmptyCard.home(),
            ),
            MountGettePlaces(
              stream: controller.bestRatedPlacesController.stream,
              list: controller.listBestRatedPlaces,
            ),
          ],
        ),
      ),
    );
  }
}
