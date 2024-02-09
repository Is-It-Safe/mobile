import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_emotion_graphic/safe_emotion_graphic.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_impression_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_review_card.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/impression_status_enum.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';

class LocationPage extends StatefulWidget {
  static String get route => "/location-page";

  final LocationEntity location;
  const LocationPage({Key? key, required this.location}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends SafeState<LocationPage, LocationBloC> {
  @override
  void initState() {
    super.initState();
    bloc.getLocationById(widget.location.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.navigateToReviewPage(),
        backgroundColor: SafeColors.buttonColors.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: SafeAppBar(
        title: widget.location.name,
        onTap: () => Modular.to.pop(),
      ),
      body: SafeBuilder<LocationEntity?>(
        stream: bloc.location,
        builder: (location) {
          if (location == null) return const SafeLoading();

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (location.imagePath != null &&
                    (location.imagePath!.isNotEmpty))
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          location.imagePath ?? StringConstants.empty,
                          height: size.height * .2,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ),
                      SizedBox(height: size.height * .032),
                    ],
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      overflow: TextOverflow.clip,
                      style: TextStyles.headline3().copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location.address.split(',').join(', '),
                      overflow: TextOverflow.clip,
                      style: TextStyles.caption().copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .047),
                SafeEmotionGrapic(
                  averageGrade: location.averageGrade ?? 0,
                  avaliationCount: location.reviews!.length,
                  grade: location.reviews,
                  reviewChart: location.reviewChart,
                ),
                SizedBox(height: size.height * .023),
                if (location.averageImpressionStatus?.isNotEmpty ?? true)
                  SafeImpressionCard(
                    type: ImpressionStatusEnumUtil.fromString(
                      location.averageImpressionStatus ?? StringConstants.empty,
                    ),
                  ),
                SizedBox(height: size.height * .035),
                Divider(
                  color: SafeColors.generalColors.secondary,
                  thickness: 1,
                ),
                SizedBox(height: size.height * .027),
                Text(
                  S.current.textWhatPeopleAreTalkingAboutThisPlace,
                  style: TextStyles.subtitle2().copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: size.height * .023),
                if (location.reviews?.isEmpty ?? true) SafeEmptyCard.location(),
                if (location.reviews?.isNotEmpty ?? false)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: location.reviews?.length ?? 0,
                    itemBuilder: (_, index) {
                      return SafeReviewCard(
                        review: ReviewEntity.toEntity(
                          location.reviews![index],
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
