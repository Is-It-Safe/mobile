import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/location_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Modular.to.pushNamed(
            LocationModule.route + ReviewPage.route,
            arguments: widget.location,
          );
        },
        backgroundColor: SafeColors.buttonColors.secondary,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: size.width * .11,
        ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      loc.imagePath ?? StringConstants.empty,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: size.height * .032),
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * .08454,
                        right: size.width * .273,
                      ),
                      child: Column(
                        children: [
                          Text(
                            loc.name,
                            overflow: TextOverflow.clip,
                            style: TextStyles.headline3().copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            loc.address,
                            overflow: TextOverflow.clip,
                            style: TextStyles.caption().copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * .047),
                    SafeEmotionGrapic(
                      grade: loc.averageGrade ?? 0,
                      avaliationCount: loc.reviews!.length,
                    ),
                    SizedBox(height: size.height * .023),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * .08212),
                      child: const SafeImpressionCard(
                        type: SafeImpressionEnum.success,
                      ),
                    ),
                    SizedBox(height: size.height * .035),
                    Divider(
                      color: SafeColors.generalColors.secondary,
                      thickness: 1,
                      indent: size.width * .0845,
                      endIndent: size.width * .0845,
                    ),
                    SizedBox(height: size.height * .037),
                    Container(
                      margin: EdgeInsets.only(left: size.width * .084),
                      child: Text(
                        S.current.textWhatPeopleAreTalkingAboutThisPlace,
                        style: TextStyles.subtitle2().copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * .023),
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * .07,
                        right: size.width * .0845,
                        bottom: size.height * .058,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: loc.reviews!.length,
                        itemBuilder: (_, index) {
                          return SafeReviewCard(
                            review: ReviewEntity.toEntity(loc.reviews![index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SafeLoading();
        },
      ),
    );
  }
}
