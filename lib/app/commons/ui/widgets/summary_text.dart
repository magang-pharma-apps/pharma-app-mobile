import 'package:flutter/material.dart';

class SummaryText extends StatelessWidget {
  final int? maxLines;
  EdgeInsets? padding;
  String? leftText;
  String? rightText;
  TextStyle? leftStyle;
  TextStyle? rightStyle;

  SummaryText({
    super.key,
    this.maxLines,
    this.padding,
    this.leftText,
    this.rightText,
    this.leftStyle,
    this.rightStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              overflow: TextOverflow.ellipsis,
              maxLines: maxLines ?? 1,
              leftText ?? "",
              style: leftStyle ?? Theme.of(context).textTheme.labelMedium),
          Text(
              overflow: TextOverflow.ellipsis,
              rightText ?? "",
              style: rightStyle ?? Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
