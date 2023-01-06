import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'package:is_it_safe_app/src/app/modules/location/review/presenter/bloc/review_bloc.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_impression_carroussel.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_slider_emoji.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';

class ReviewPage extends StatefulWidget {
  static const route = '/review/';
  final LocationEntity location;

  const ReviewPage({
    Key? key,
    required this.location,
  }) : super(key: key);
  @override
  ReviewPageState createState() => ReviewPageState();
}

class ReviewPageState extends ModularState<ReviewPage, ReviewBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: widget.location.name,
      ),
      body: StreamBuilder<SafeEvent<ReviewEntity>>(
          stream: controller.reviewController.stream,
          initialData: SafeEvent.initial(),
          builder: (context, snapshot) {
            // if (snapshot.data?.status == Status.done) {
            //   showDialog(
            //     context: context,
            //     builder: (context) => SafeDialog(
            //       title: S.current.textPublishedReview,
            //       message: snapshot.data?.data?.message,
            //       onTap: () => Modular.to.pop(),
            //     ).show(),
            //   );
            return SafeLayout(
              context: context,
              snapshot: snapshot,
              onCompleted: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 40,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.current.textReviewCompleted.toUpperCase(),
                        style: TextStyles.headline1(
                          color: SafeColors.statusColors.success,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SvgPicture.asset(AssetConstants.general.reviewCompleted),
                      const SizedBox(height: 30),
                      Text(
                        snapshot.data?.data?.review ?? StringConstants.empty,
                        style: TextStyles.bodyText1(),
                      ),
                      const SizedBox(height: 120),
                      SafeButton(
                        title: S.current.textContinue,
                        onTap: () => Modular.to.pop(),
                      ),
                    ],
                  ),
                ),
              ),
              onInitial: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ReviewImageWidget(
                        image: widget.location.imagePath ??
                            AssetConstants.mock.locationImage,
                      ),
                      const SizedBox(height: 20),
                      ReviewEmotionsWidget(
                        grade: controller.gradeController.stream,
                        onGradeChanged: (value) =>
                            controller.onGradeChanged(value),
                      ),
                      const SizedBox(height: 30),
                      ReviewImpressionStatusWidget(
                        carrousselStream:
                            controller.impressionStatusController.stream,
                        pageController: _pageController,
                        images: controller.impressionStatusImages,
                        texts: controller.impressionStatusTexts,
                        getImpressions: (index) =>
                            controller.getImpressions(index),
                        onImpressionChanged: (cardId) =>
                            controller.onImpressionChanged(
                          cardId,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ReviewTextFieldWidget(
                        textController: controller.textReviewController,
                        formKey: _formKey,
                        onChanged: (value) => controller.onReviewChanged(value),
                      ),
                      const SizedBox(height: 30),
                      StreamBuilder<bool>(
                        stream: controller.isButtonEnabledController.stream,
                        builder: (context, snapshot) => SafeButton(
                          title: S.current.textSend,
                          state: (snapshot.data ?? false)
                              ? ButtonState.rest
                              : ButtonState.disabled,
                          onTap: snapshot.data == true
                              ? () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await controller.sendReview(
                                        id: widget.location.id);
                                  }
                                }
                              : () => _formKey.currentState?.validate(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ReviewTextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final void Function(String value)? onChanged;
  final GlobalKey<FormState> formKey;

  const ReviewTextFieldWidget({
    Key? key,
    required this.textController,
    required this.formKey,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.textCanYouGiveMoreDetails,
          style: TextStyles.bodyText1(
            color: SafeColors.generalColors.secondary,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: textController,
              expands: true,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: S.current.textWriteHere,
                hintStyle: TextStyles.label(),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? false) {
                  return S.current.textErrorEmptyField;
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewImpressionStatusWidget extends StatefulWidget {
  final Stream<int> carrousselStream;
  final PageController pageController;
  final List<String> images;
  final List<String> texts;

  final void Function(int value) onImpressionChanged;
  final List<String> Function(int index) getImpressions;
  const ReviewImpressionStatusWidget({
    Key? key,
    required this.carrousselStream,
    required this.onImpressionChanged,
    required this.images,
    required this.pageController,
    required this.texts,
    required this.getImpressions,
  }) : super(key: key);

  @override
  State<ReviewImpressionStatusWidget> createState() =>
      _ReviewImpressionStatusWidgetState();
}

class _ReviewImpressionStatusWidgetState
    extends State<ReviewImpressionStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.textChooseAClassification,
          textAlign: TextAlign.center,
          style: TextStyles.bodyText1(
            color: SafeColors.generalColors.secondary,
          ),
        ),
        const SizedBox(height: 20),
        StreamBuilder<int>(
          stream: widget.carrousselStream,
          builder: (context, snapshot) => SafeImpressionCarroussel(
            pageController: widget.pageController,
            currentPage: snapshot.data ?? 0,
            onImpressionChanged: (value) => widget.onImpressionChanged(value),
            data: List.generate(
              widget.images.length,
              (index) => ImpressionItem(
                id: index,
                title: widget.texts[index],
                image: widget.images[index],
                impressions: widget.getImpressions(snapshot.data ?? 0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            S.current.textChooseAClassificationForThisPlace,
            style: TextStyles.helper(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class ReviewEmotionsWidget extends StatefulWidget {
  final Stream<double> grade;
  final void Function(double value) onGradeChanged;
  const ReviewEmotionsWidget({
    Key? key,
    required this.grade,
    required this.onGradeChanged,
  }) : super(key: key);

  @override
  State<ReviewEmotionsWidget> createState() => _ReviewEmotionsWidgetState();
}

class _ReviewEmotionsWidgetState extends State<ReviewEmotionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.current.textHowDoYouFeelAboutThisPlace,
          style: TextStyles.bodyText1(
            color: SafeColors.generalColors.secondary,
          ),
        ),
        const SizedBox(height: 20),
        StreamBuilder<double>(
          stream: widget.grade,
          builder: (context, snapshot) => SafeEmotionSlider(
            value: snapshot.data ?? 0,
            onChanged: (value) => widget.onGradeChanged(value),
          ),
        )
      ],
    );
  }
}

class ReviewImageWidget extends StatelessWidget {
  final String image;
  const ReviewImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: (image.contains('http'))
                    ? Image.network(image).image
                    : Image.asset(image).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
