import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/home_module/components/cards/local_card_final.dart';
import 'package:is_it_safe_app/core/components/empty_card.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'components/drawer/custom_drawer.dart';
import 'home_bloc.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);
  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends ModularState<HomeWidget, HomeBloc> {
  @override
  void initState() {
    super.initState();
    Log.route(Modular.to.path);
    controller.getLocations();
  }

  _onError(AsyncSnapshot snapshot) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ManagerDialogs.showErrorDialog(
        context,
        snapshot.data.message,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: const CustomDrawer(
          name: 'Usuário Com Um Longo Nome',
          profileImagePath: 'images/app/profile_pictures/profile_pic_1.png',
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kColorTextLight),
          backgroundColor: kColorWhiteBackground,
          title: Row(
            children: [
              Image.asset(
                'images/app_icon.png',
                width: 35,
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  S.of(context).textIsItSafe,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: kColorTextLight),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: kColorTextLight,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textClosePlaces,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textBestRates,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<BaseResponse<List<LocationInfo>>>(
              stream: controller.locationInfoController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      //TODO: Retornando para o widget pois o loading não estava sendo exibido através
                      //do ManagerDialogs
                      //ManagerDialogs.showLoadingDialog(context);
                      //break;
                      return const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                      );
                    case Status.ERROR:
                      _onError(snapshot);
                      break;
                    default:
                      return Container(
                        color: kColorWhiteBackground,
                        child: ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: ((context, index) {
                            final locationInfo = snapshot.data!.data![index];
                            return LocalCard(locationInfo: locationInfo);
                          }),
                        ),
                      );
                  }
                }
                return EmptyCard(
                  imagePath: 'images/icons/empty_places.svg',
                  text: S.of(context).textEmptyCard,
                );
              },
            ),
            //Melhores Avaliados
            Column(
              children: [
                EmptyCard(
                  imagePath: 'images/icons/empty_places.svg',
                  text: S.of(context).textEmptyCard,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
