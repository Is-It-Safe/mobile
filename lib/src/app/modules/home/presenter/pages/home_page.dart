import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_drawer.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_location_card.dart';
import 'package:is_it_safe_app/src/app/modules/location/location_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class HomePage extends StatefulWidget {
  static const route = '/home/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
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
            onBottomTap: (tab) {
              //TODO manter comentado mediante implementação da feature
              // if (tab == 0) controller.getClosePlacesLocations();
              if (tab == 1) controller.getBestRatedLocations();
            },
            onLogoIconTap: () {
              controller.getCurrentLocation();
              SafeDialogs.dialog(
                title: 'Teste de localização',
                message: controller.currentLocation.value?.subLocality ?? '',
                onTap: () => Navigator.pop(context),
              );
              print(controller.currentLocation.value?.street ?? '');
            }),
        body: TabBarView(
          children: [
            SafeEmptyCard.home(),
            _mountTab(
              stream: controller.bestRatedPlacesController.stream,
              list: controller.listBestRatedLocations,
            ),
          ],
        ),
      ),
    );
  }

  Widget _mountTab({
    required Stream<SafeEvent<List<LocationEntity>>> stream,
    required List<LocationEntity> list,
  }) {
    return StreamBuilder<SafeEvent<List<LocationEntity>>>(
      stream: controller.bestRatedPlacesController.stream,
      builder: (context, snapshot) {
        return SafeLayout(
          snapshot: snapshot,
          context: context,
          onEmpty: SafeEmptyCard.home(),
          onCompleted: _mountSeparatedList(
            length: controller.listBestRatedLocations.length,
            list: controller.listBestRatedLocations,
          ),
        ).build;
      },
    );
  }

  Widget _mountSeparatedList({
    required int length,
    required List<LocationEntity> list,
  }) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      itemCount: length,
      separatorBuilder: (_, i) => const SizedBox(height: 15),
      itemBuilder: (context, index) => HomeLocationCard(
        location: list[index],
        onTap: () => Modular.to.pushNamed(
          LocationModule.route + ReviewPage.route,
          arguments: list[index],
        ),
      ),
    );
  }
}
