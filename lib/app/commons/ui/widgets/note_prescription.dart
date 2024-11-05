import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NotePrescription extends StatefulWidget {
  final Function(String) onChanged;
  const NotePrescription({
    super.key,
    required this.onChanged,
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
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) => widget.onChanged(value),
            maxLines: 1,
            maxLength: 15,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(8),
              labelStyle: TextStyle(fontSize: 9),
              filled: false,
              fillColor: Colors.white,
              disabledBorder: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              suffixIcon: IconButton(
                icon: Icon(
                  HugeIcons.strokeRoundedCancelCircle,
                  color: Colors.red,
                  size: 15,
                ),
                onPressed: () {
                  setState(() {
                    _isClicked = false;
                  });
                },
              ),
              label: Text("Recipe"),
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
