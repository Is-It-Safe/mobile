import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/location_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_emotion_graphic/safe_emotion_graphic.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_impression_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_review_card.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';

class LocationPage extends StatefulWidget {
  static String get route => "/location-page";

  final LocationEntity location;
  const LocationPage({Key? key, required this.location}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends ModularState<LocationPage, LocationBloC> {
  @override
  void initState() {
    controller.getLocationById(widget.location.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Modular.to.pushNamed(
            LocationModule.route + ReviewPage.route,
            arguments: widget.location,
          );
        },
        backgroundColor: SafeColors.buttonColors.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: SafeAppBar(
        title: widget.location.name,
        onTap: () {
          Modular.to.pop();
        },
      ),
      body: StreamBuilder<SafeEvent<LocationEntity>>(
          stream: controller.locationByIDController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final loc = controller.locationById;
              return SafeLayout(
                snapshot: snapshot,
                onCompleted: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(loc.imagePath ?? StringConstants.empty),
                      Text(loc.name),
                      Text(loc.address),
                      SafeEmotionGrapic(
                        grade: loc.averageGrade ?? 0,
                        avaliationCount: loc.reviews!.length,
                      ),
                      const SafeImpressionCard(
                        type: SafeImpressionEnum.success,
                      ),
                      Divider(
                        color: SafeColors.generalColors.secondary,
                      ),
                      Text(S.current.textWhatPeopleAreTalkingAboutThisPlace),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: loc.reviews!.length,
                        itemBuilder: (_, index) {
                          return SafeReviewCard(
                            review: ReviewEntity.toEntity(loc.reviews![index]),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SafeLoading();
          }),
    );
  }
}
