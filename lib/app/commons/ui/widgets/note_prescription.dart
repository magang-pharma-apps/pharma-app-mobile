import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NotePrescription extends StatefulWidget {
  const NotePrescription({
    super.key,
  });

  @override
  State<NotePrescription> createState() => _NotePrescriptionState();
}

class _NotePrescriptionState extends State<NotePrescription> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return _isClicked
        ? TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 10),
              constraints: BoxConstraints(minHeight: 10),
              filled: false,
              fillColor: Colors.white,
              disabledBorder: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              suffixIcon: IconButton(
                icon: Icon(
                  HugeIcons.strokeRoundedCancelCircle,
                  color: Colors.red,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isClicked = false;
                  });
                },
              ),
              label: Text("Recipe"),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
            onTapOutside: (value) {},
          )
        : InkWell(
            onTap: () {
              setState(() {
                _isClicked = true;
              });
            },
            child: Row(
              children: [
                Icon(
                  HugeIcons.strokeRoundedMedicalFile,
                  color: Colors.teal,
                  size: 20,
                ),
                Text("Recipe",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.teal))
              ],
            ),
          );
  }
}
