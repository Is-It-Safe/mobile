import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

class SafeEmotionSlider extends StatefulWidget {
  final double value;
  final void Function(double value) onChanged;
  final double min;
  final double max;

  const SafeEmotionSlider({
    Key? key,
    required this.value,
    this.min = 0,
    this.max = 4,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SafeEmotionSlider> createState() => _SafeEmotionSliderState();
}

class _SafeEmotionSliderState extends State<SafeEmotionSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconRowBuilder(value: widget.value),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: SafeColors.componentsColors.iconColors.navBar,
            inactiveTrackColor: SafeColors.componentsColors.iconColors.navBar,
            thumbColor: SafeColors.componentsColors.iconColors.navBar,
            overlayColor:
            SafeColors.componentsColors.iconColors.navBar.withOpacity(0.2),
            trackHeight: 2.0,
            trackShape: const RectangularSliderTrackShape(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
          ),
          child: Slider(
            value: widget.value,
            min: widget.min,
            max: widget.max,
            onChanged: widget.onChanged,
          ),
        ),
        TextRowBuilder(value: widget.value),
      ],
    );
  }
}

class TextRowBuilder extends StatelessWidget {
  final double value;
  const TextRowBuilder({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextItem(
          isVisible: value <= 1,
          text: S.current.textAngry,
        ),
        TextItem(
          isVisible: value > 1 && value <= 2,
          text: S.current.textUpset,
        ),
        TextItem(
          isVisible: value > 2 && value <= 3,
          text: S.current.textRegular,
        ),
        TextItem(
          isVisible: value > 3,
          text: S.current.textSatisfied,
        ),
      ],
    );
  }
}

class IconRowBuilder extends StatelessWidget {
  final double value;
  const IconRowBuilder({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconItem(
          icon: AssetConstants.emoticon.angry,
          isVisible: value <= 1,
        ),
        IconItem(
          icon: AssetConstants.emoticon.sad,
          isVisible: value > 1 && value <= 2,
        ),
        IconItem(
          icon: AssetConstants.emoticon.neutral,
          isVisible: value > 2 && value <= 3,
        ),
        IconItem(
          icon: AssetConstants.emoticon.happy,
          isVisible: value > 3,
        ),
      ],
    );
  }
}

class TextItem extends StatelessWidget {
  final bool isVisible;
  final String text;
  const TextItem({
    Key? key,
    required this.isVisible,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Text(
        text,
        style: TextStyles.bodyText2(color: SafeColors.generalColors.secondary),
      ),
    );
  }
}

class IconItem extends StatelessWidget {
  final String icon;
  final double size;
  final bool isVisible;
  const IconItem({
    Key? key,
    required this.icon,
    required this.isVisible,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: SvgPicture.asset(
        icon,
        height: size,
        width: size,
      ),
    );
  }
}
