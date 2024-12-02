import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomCardLabelWidget extends StatelessWidget {
  Color? backgroundColor;
  String? textLabel;
  Color? textLabelColor;
  Color? bgLabelColor;
  IconData? iconTrailing;
  String? trailingText;

  CustomCardLabelWidget({
    super.key,
    this.textLabel,
    this.textLabelColor,
    this.bgLabelColor,
    this.iconTrailing,
    this.trailingText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFF43766C),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: bgLabelColor ?? const Color(0xffE8ECD7),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(textLabel!,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: textLabelColor ?? const Color(0xFF47663B))),
          ),
          Row(
            children: [
              Icon(
                iconTrailing ?? HugeIcons.strokeRoundedCalendar02,
                size: 15,
                color: Colors.white,
              ),
              Text(trailingText ?? ' 12 Dec 2021',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
