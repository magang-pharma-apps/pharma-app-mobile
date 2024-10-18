import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomAppBar extends StatelessWidget {
  String? appBarTitle;
  IconButton? appBarTrailing;
  CustomAppBar({super.key, this.appBarTitle, this.appBarTrailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01, color: Colors.black),
        ),
        title: Text(
          appBarTitle!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        trailing: appBarTrailing);
  }
}
