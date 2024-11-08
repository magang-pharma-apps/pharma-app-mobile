import 'package:flutter/material.dart';

class SummaryText extends StatelessWidget {
  String? leftText;
  String? rightText;
  TextStyle? leftStyle;
  TextStyle? rightStyle;

  SummaryText({
    super.key,
    this.leftText,
    this.rightText,
    this.leftStyle,
    this.rightStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftText ?? "",
              style: leftStyle ?? Theme.of(context).textTheme.labelMedium),
          Text(rightText ?? "",
              style: rightStyle ?? Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}