import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class SafeModal extends StatelessWidget {
  final List<ModalTile> tiles;
  final double? height;
  const SafeModal({
    Key? key,
    required this.tiles,
    this.height,
  }) : super(key: key);

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: SafeColors.generalColors.background,
      constraints: BoxConstraints.tightForFinite(
        height: height ?? MediaQuery.of(context).size.height * 0.25,
      ),
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15.0),
      itemCount: tiles.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => tiles[index],
    );
  }
}

class ModalTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;

  const ModalTile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      iconColor: SafeColors.buttonColors.primary,
      title: Text(
        text,
        style: TextStyles.bodyText1(),
      ),
      autofocus: true,
      onTap: onTap,
    );
  }
}
