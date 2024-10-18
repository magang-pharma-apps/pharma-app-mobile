import 'package:flutter/material.dart';

class CustomLineWidget extends StatelessWidget {
  const CustomLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 0.5,
      height: 20,
    );
  }
}
