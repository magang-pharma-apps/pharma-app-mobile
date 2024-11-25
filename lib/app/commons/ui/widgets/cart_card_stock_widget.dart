import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartCardStockWidget extends StatelessWidget {
  final double? width;
  final double? height;
  String? title;
  String? subTitle;
  Decoration? decoration;
  ChartCardStockWidget({
    super.key,
    this.width,
    this.height,
    this.decoration,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width * 0.4,
      height: height ?? 90,
      padding: EdgeInsets.all(10),
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              begin: Alignment(-0.5800667696220931, -0.7644511783637873),
              end: Alignment(1, 1),
              colors: [Color(4288361927), Color(4282990768)],
              stops: null,
            ),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "100",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          Text(
            subTitle ?? "In Stock",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
