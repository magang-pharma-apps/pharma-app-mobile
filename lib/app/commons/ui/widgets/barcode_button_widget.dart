import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BarcodeButtonWidget extends StatelessWidget {
  const BarcodeButtonWidget({
    super.key,
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
          onPressed: () {},
          icon: Icon(
            HugeIcons.strokeRoundedBarCode01,
            color: Colors.white,
          )),
    );
  }
}
