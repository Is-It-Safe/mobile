import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'package:is_it_safe_app/src/app/modules/review/presenter/bloc/review_bloc.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_impression_carroussel.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_slider_emoji.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/core/enum/impression_status_enum.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
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

class ReviewPageState extends SafeState<ReviewPage, ReviewBloc> {
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
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: SafeAppBar(
        title: widget.location.name,
      ),
      body: SafeBuilder<ReviewEntity?>(
          stream: bloc.review,
          builder: (review) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.location.imagePath != null &&
                        widget.location.imagePath!.isNotEmpty)
                      ReviewImageWidget(
                        image: widget.location.imagePath!,
                      ),
                    const SizedBox(height: 20),
                    ReviewEmotionsWidget(
                      grade: bloc.grade,
                      onGradeChanged: (value) => bloc.onGradeChanged(value),
                    ),
                    const SizedBox(height: 30),
                    ReviewImpressionStatusWidget(
                      carouselStream: bloc.impressionStatus,
                      pageController: _pageController,
                      images: ImpressionStatusEnum.values
                          .map((e) => e.image)
                          .toList(),
                      texts: ImpressionStatusEnum.values
                          .map((e) => e.text)
                          .toList(),
                      getImpressions: (index) => bloc.getImpressions(index),
                      onImpressionChanged: (cardId) =>
                          bloc.onImpressionChanged(cardId),
                    ),
                    const SizedBox(height: 30),
                    ReviewTextFieldWidget(
                      textController: bloc.textReviewController,
                      formKey: _formKey,
                      onChanged: (value) => bloc.onReviewChanged(value),
                    ),
                    const SizedBox(height: 30),
                    SafeBuilder<bool>(
                      stream: bloc.isButtonEnabled,
                      builder: (isButtonEnabled) => SafeButton(
                        title: S.current.textSend,
                        state: isButtonEnabled
                            ? ButtonState.rest
                            : ButtonState.disabled,
                        onTap: isButtonEnabled
                            ? () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  await bloc.sendReview(
                                      id: widget.location.id ?? 0);
                                }
                              }
                            : () => _formKey.currentState?.validate(),
                      ),
                    ),
                  ],
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
  final SafeStream<ImpressionStatusEnum> carouselStream;
  final PageController pageController;
  final List<String> images;
  final List<String> texts;

  final void Function(int value) onImpressionChanged;
  final List<String> Function(int index) getImpressions;
  const ReviewImpressionStatusWidget({
    Key? key,
    required this.carouselStream,
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
        SafeBuilder<ImpressionStatusEnum>(
          stream: widget.carouselStream,
          builder: (carouselStream) => SafeImpressionCarroussel(
            pageController: widget.pageController,
            currentPage: carouselStream.index,
            onImpressionChanged: (value) => widget.onImpressionChanged(value),
            data: List.generate(
              widget.images.length,
              (index) => ImpressionItem(
                id: index,
                title: widget.texts[index],
                image: widget.images[index],
                impressions: widget.getImpressions(carouselStream.index),
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
  final SafeStream<double> grade;
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
        SafeBuilder<double>(
          stream: widget.grade,
          builder: (grade) => SafeEmotionSlider(
            value: grade,
            min: 1,
            onChanged: (value) {
              widget.onGradeChanged(value.roundToDouble());
            },
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
