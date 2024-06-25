
import 'package:flutter/material.dart';
import 'package:palm_code_books/common/theme.dart';

class CustomFilledButton extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final Color? color;
  final bool? isDisable;

  final VoidCallback? onPressed;

  const CustomFilledButton(
      {super.key,
      this.color,
      required this.title,
      this.width = double.infinity,
      this.height = 50,
      this.onPressed,
      this.isDisable});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: color ?? secondaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: onPressed,
        child: Text(
          title!,
          style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final double? fontSize;

  final VoidCallback? onPressed;
  const CustomTextButton(
      {super.key,
      required this.title,
      this.width,
      this.height = 24,
      this.onPressed,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: onPressed,
        child: Text(
          title!,
          style: secondaryTextStyle.copyWith(fontSize: fontSize ?? 16),
        ),
      ),
    );
  }
}