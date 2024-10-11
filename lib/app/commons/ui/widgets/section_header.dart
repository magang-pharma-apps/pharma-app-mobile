import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  String? sectionName;
  IconData? sectionIcon;
  SectionHeader({super.key, this.sectionName, this.sectionIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          sectionIcon!,
          color: Colors.grey.shade700,
        ),
        SizedBox(width: 10),
        Text(
          sectionName!,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey.shade700),
        ),
        Spacer(),
        TextButton(onPressed: () {}, child: Text("View All")),
      ],
    );
  }
}
