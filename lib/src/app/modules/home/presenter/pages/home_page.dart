import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_drawer.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_location_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';

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
    LogUtil().route(Modular.to.path);
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
        ),
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

  StreamBuilder<SafeResponse<List<LocationEntity>>> _mountTab({
    required Stream<SafeResponse<List<LocationEntity>>> stream,
    required List<LocationEntity> list,
  }) {
    return StreamBuilder<SafeResponse<List<LocationEntity>>>(
      stream: controller.bestRatedPlacesController.stream,
      builder: (context, snapshot) {
        if (snapshot.data != null ||
            controller.listBestRatedLocations.isNotEmpty) {
          switch (snapshot.data?.status) {
            case Status.loading:
              return const SafeLoading();
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialogs.error(
                  message: snapshot.data?.message,
                ),
              );
              break;
            default:
              if (snapshot.data?.data == null) {
                return const SafeLoading();
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                itemCount: controller.listBestRatedLocations.length,
                separatorBuilder: (_, i) => const SizedBox(height: 15),
                itemBuilder: (context, index) => HomeLocationCard(
                  location: controller.listBestRatedLocations[index],
                ),
              );
          }
        }
        return SafeEmptyCard.home();
      },
    );
  }
}
