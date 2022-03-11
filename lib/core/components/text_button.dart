import 'package:flutter/material.dart';

class TextButtonCustom extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const TextButtonCustom({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 18, 30, 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            //TODO: Ajustar TextTheme
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
          ),
        ),
      ),
    );
  }
}
