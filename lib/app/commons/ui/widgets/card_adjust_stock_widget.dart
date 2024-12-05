import 'package:flutter/material.dart';

class CardAdjustStockWidget extends StatelessWidget {
  String title;
  String subtitle;
  BoxDecoration? decoration;
  Text? text;

  CardAdjustStockWidget({
    super.key,
    this.decoration,
    this.text,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(1, 1),
          colors: [Color(3446118904), Color(4279655674)],
          stops: null,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
