import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ButtonNote extends StatelessWidget {
  const ButtonNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        iconAlignment: IconAlignment.start,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(150, 30),
            iconColor: Colors.teal,
            backgroundColor: Colors.white,
            foregroundColor: Colors.teal,
            side: BorderSide(color: Colors.teal, width: 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              10,
            ))),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  HugeIcons.strokeRoundedPencilEdit01,
                  color: Colors.teal,
                )),
            Text(
              " Check Note",
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ));
  }
}
