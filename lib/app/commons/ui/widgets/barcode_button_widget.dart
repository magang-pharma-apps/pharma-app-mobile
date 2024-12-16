import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BarcodeButtonWidget extends StatelessWidget {
  VoidCallback? onPressed;
  BarcodeButtonWidget({
    super.key, this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
          onPressed: () {
            onPressed!();

          },
          icon: Icon(
            HugeIcons.strokeRoundedBarCode02,
            size: 30,
            color: Colors.white,
          )),
    );
  }
}
