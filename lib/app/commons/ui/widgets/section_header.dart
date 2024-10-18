import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/modules/category/views/category_view.dart';

class SectionHeader extends StatefulWidget {
  String? sectionName;
  IconData? sectionIcon;
  final VoidCallback? viewAllPressed;
  SectionHeader({super.key, this.sectionName, this.sectionIcon, this.viewAllPressed});

  @override
  State<SectionHeader> createState() => _SectionHeaderState();
}

class _SectionHeaderState extends State<SectionHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          widget.sectionIcon!,
          color: Colors.grey.shade700,
        ),
        SizedBox(width: 10),
        Text(
          widget.sectionName!,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey.shade700),
        ),
        Spacer(),
        TextButton(
          
            onPressed: widget.viewAllPressed,
            child: Text("View All")),
      ],
    );
  }
}
