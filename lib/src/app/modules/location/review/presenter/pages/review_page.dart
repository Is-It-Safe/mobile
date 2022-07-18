import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/review_module/review_bloc.dart';
import 'package:is_it_safe_app/core/components/app_bar.dart';
import 'package:is_it_safe_app/core/components/primary_button.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/model/LocationByID.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'components/slider_emoji.dart';
import 'components/slider_text.dart';

class ReviewWidget extends StatefulWidget {
  final int args;
  const ReviewWidget({
    Key? key,
    required this.args,
  }) : super(key: key);
  @override
  ReviewWidgetState createState() => ReviewWidgetState();
}

class ReviewWidgetState extends ModularState<ReviewWidget, ReviewBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    controller.getOnlyLocation(widget.args);
    _pageController = PageController(viewportFraction: 1);
    Log.route(Modular.to.path);
  }

  _onError(AsyncSnapshot snapshot) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ManagerDialogs.showErrorDialog(
        context,
        snapshot.data.message,
      );
    });
  }

  double _valueGrade = 2.5;
  int activePage = 0;
  static const _kDuration = Duration(milliseconds: 200);
  static const _kCurve = Curves.ease;
  List<String> impressionStatusImages = [
    'images/app/review_module/review_impression_safe.png',
    'images/app/review_module/review_impression_caution.png',
    'images/app/review_module/review_impression_insecure.png',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    return StreamBuilder<BaseResponse<List<LocationByID>>>(
      stream: controller.reviewController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data?.status) {
            case Status.LOADING:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case Status.ERROR:
              _onError(snapshot);
              return Text(
                S.of(context).textErrorDropdown,
              );
            default:
              return Scaffold(
                key: _scaffoldKey,
                appBar: appBar(
                  context: context,
                  hasLeading: true,
                  title: '${snapshot.data!.data![0].name}',
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size * 0.08),
                        child: Stack(
                          children: [
                            Container(
                              height: size * 0.25,
                              width: size,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size * 0.02),
                                image: DecorationImage(
                                  image: Image.asset(
                                          ('images/app/review_module/placeholder/review_placeholder.png'))
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: size * 0.25,
                              width: size,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size * 0.02),
                                image: DecorationImage(
                                  image: (snapshot.data?.data?[0].imgUrl ==
                                          null)
                                      ? Image.asset(
                                              ('images/app/review_module/placeholder/review_placeholder.png'))
                                          .image
                                      : NetworkImage(
                                          '${snapshot.data!.data![0].imgUrl}',
                                        ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: size * 0.1),
                        child: Text(
                          S.of(context).textHowDidYouFeelThere,
                          style: TextStyles.bodyText2(
                            color: const Color(0xFF190A33),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size * 0.03),
                        child: SliderEmoji(
                          actualValue: _valueGrade,
                          startValue: 0,
                          endValue: 5,
                          lineWidth: size,
                          image01: 'review_emoji_angry.png',
                          image02: 'review_emoji_upset.png',
                          image03: 'review_emoji_regular.png',
                          image04: 'review_emoji_satisfied.png',
                          image05: 'review_emoji_amazing.png',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size * 0.03, right: size * 0.03),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: const Color(0xFF7C68F0),
                            inactiveTrackColor: const Color(0xFF7C68F0),
                            trackShape: const RectangularSliderTrackShape(),
                            trackHeight: 2.0,
                            thumbColor: const Color(0xFF7B61FF),
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 12.0),
                            overlayColor: const Color(0xFF7B61FF).withAlpha(32),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 28.0),
                            valueIndicatorShape:
                                const PaddleSliderValueIndicatorShape(),
                          ),
                          child: Slider(
                            min: 0,
                            max: 5,
                            value: _valueGrade,
                            onChanged: (value) {
                              setState(() {
                                _valueGrade = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size * 0.03),
                        child: SliderText(
                          actualValue: _valueGrade,
                          startValue: 0,
                          endValue: 5,
                          lineWidth: size,
                          text01: 'Irritado',
                          text02: 'Chateado',
                          text03: 'Regular',
                          text04: 'Satisfeito',
                          text05: 'Incrível',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size * 0.1, bottom: size * 0.05),
                        child: Text(
                          S.of(context).textChooseRatingForTheLocation,
                          style: TextStyles.bodyText2(
                            color: const Color(0xFF190A33),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size,
                        height: size * 0.55,
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: impressionStatusImages.length,
                              pageSnapping: true,
                              controller: _pageController,
                              onPageChanged: (page) {
                                setState(
                                  () {
                                    controller.setImpressionStatusResult(page);
                                    activePage = page;
                                  },
                                );
                              },
                              itemBuilder: (context, pagePosition) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      impressionStatusImages[pagePosition]),
                                );
                              },
                            ),
                            SizedBox(
                              height: size * 0.55,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (activePage > 0)
                                    Material(
                                      child: InkWell(
                                        child: SizedBox(
                                          width: size * 0.15,
                                          height: size * 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Image.asset(
                                                  ('images/app/review_module/review_arrow_left.png')),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _pageController.previousPage(
                                                duration: _kDuration,
                                                curve: _kCurve);
                                          });
                                        },
                                      ),
                                    )
                                  else
                                    SizedBox(
                                      width: size * 0.15,
                                      height: size * 0.2,
                                    ),
                                  if (activePage < 2)
                                    Material(
                                      child: InkWell(
                                        child: SizedBox(
                                          width: size * 0.15,
                                          height: size * 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Image.asset(
                                                  ('images/app/review_module/review_arrow_right.png')),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _pageController.nextPage(
                                                duration: _kDuration,
                                                curve: _kCurve);
                                          });
                                        },
                                      ),
                                    )
                                  else
                                    SizedBox(
                                      width: size * 0.15,
                                      height: size * 0.2,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size * 0.03,
                            bottom: size * 0.05,
                            left: size * 0.1,
                            right: size * 0.1),
                        child: Text(
                          S
                              .of(context)
                              .textChooseRatingAccordingListedQualities,
                          textAlign: TextAlign.center,
                          style: TextStyles.caption(
                            color: const Color(0xFF190A33),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size * 0.1, bottom: size * 0.05),
                        child: Text(
                          S.of(context).textCanYouGiveUsMoreDetails,
                          style: TextStyles.bodyText2(
                            color: const Color(0xFF190A33),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size * 0.1),
                        child: SizedBox(
                          height: size * 0.4,
                          child: TextField(
                            controller: controller.textReviewController,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: S.of(context).textWriteHere,
                              labelStyle: TextStyles.bodyText2(
                                color: const Color(0xFF535353),
                              ),
                            ),
                            maxLines: null,
                            expands: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(size * 0.05),
                        child: StreamBuilder<String>(
                          stream: controller.impressionStatusController.stream,
                          builder: (context, snapshot) {
                            return snapshot.hasData == false
                                ? PrimaryButton(
                                    text: S.of(context).textSubmit,
                                    textColor: Colors.white,
                                    onTap: () {
                                      controller.postOnlyReview(
                                          id: widget.args,
                                          grade: _valueGrade,
                                          impressionStatus: 'SAFE',
                                          review: controller
                                              .textReviewController.text);
                                    },
                                  )
                                : PrimaryButton(
                                    text: S.of(context).textSubmit,
                                    textColor: Colors.white,
                                    onTap: () {
                                      controller.postOnlyReview(
                                          id: widget.args,
                                          grade: _valueGrade,
                                          impressionStatus:
                                              controller.impressionStatusResult,
                                          review: controller
                                              .textReviewController.text);
                                    },
                                  );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
