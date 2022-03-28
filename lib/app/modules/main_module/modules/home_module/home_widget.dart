import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/home_module/components/cards/local_card.dart';
import 'package:is_it_safe_app/core/components/empty_card.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/model/location/location_info.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/helper/native_loading.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
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
    controller.getClosePlacesLocations();
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
                  style: TextStyles.headline3(),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: kColorTextLight,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (tab) {
              if (tab == 0) controller.getClosePlacesLocations();
              if (tab == 1) controller.getBestRatedLocations();
            },
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textClosePlaces,
                  style: TextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textBestRates,
                  style: TextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Lugares Próximos
            //TODO AJUSTAR APARECER EMPTY STATE QUANDO A REQUISICÃO VIER NULL
            StreamBuilder<BaseResponse<List<Location>>>(
              stream: controller.closePlacesController.stream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      const NativeLoading(animating: true);
                      break;
                    case Status.ERROR:
                      _onError(snapshot);
                      return EmptyCard(
                        imagePath: 'images/icons/empty_places.svg',
                        text: S.of(context).textErrorHome,
                      );
                    default:
                      if (snapshot.data!.data != null) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Container(
                            color: kColorWhiteBackground,
                            child: ListView.separated(
                              itemCount: snapshot.data!.data!.length,
                              separatorBuilder: ((context, index) =>
                                  const SizedBox(height: 15)),
                              itemBuilder: ((context, index) {
                                return LocalCard(
                                  onTap: () {},
                                  locationInfo: snapshot.data!.data![index],
                                );
                              }),
                            ),
                          ),
                        );
                      }
                      return EmptyCard(
                        imagePath: 'images/icons/empty_places.svg',
                        text: S.of(context).textErrorHome,
                      );
                  }
                }
                return const NativeLoading(animating: true);
              },
            ),
            //Melhores Avaliados
            StreamBuilder<BaseResponse<List<Location>>>(
              stream: controller.bestRatedPlacesController.stream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      const NativeLoading(animating: true);
                      break;
                    case Status.ERROR:
                      _onError(snapshot);
                      return EmptyCard(
                        imagePath: 'images/icons/empty_places.svg',
                        text: S.of(context).textErrorHome,
                      );

                    default:
                      if (snapshot.data!.data != null) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Container(
                            color: kColorWhiteBackground,
                            child: ListView.separated(
                              itemCount: snapshot.data!.data!.length,
                              separatorBuilder: ((context, index) =>
                                  const SizedBox(height: 15)),
                              itemBuilder: ((context, index) {
                                return LocalCard(
                                  onTap: () {},
                                  locationInfo: snapshot.data!.data![index],
                                );
                              }),
                            ),
                          ),
                        );
                      }
                      return EmptyCard(
                        imagePath: 'images/icons/empty_places.svg',
                        text: S.of(context).textErrorHome,
                      );
                  }
                }
                return const NativeLoading(animating: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
