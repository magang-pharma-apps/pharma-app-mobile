import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NoteOrderWidget extends StatefulWidget {
  final Function(String) onChanged;
  const NoteOrderWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<NoteOrderWidget> createState() => _NoteOrderWidgetState();
}

class _NoteOrderWidgetState extends State<NoteOrderWidget> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return _isClicked
        ? TextFormField(
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              isDense: true,
              suffixIcon: IconButton(
                icon: Icon(
                  HugeIcons.strokeRoundedCancelCircle,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _isClicked = false;
                  });
                },
              ),
              hintText: "Add a note here",
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey.shade600),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
            onTapOutside: (value) {},
          )
        : ElevatedButton(
            iconAlignment: IconAlignment.start,
            style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                iconColor: Colors.teal,
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                side: BorderSide(color: Colors.teal, width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                  20,
                ))),
            onPressed: () {
              setState(() {
                _isClicked = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  HugeIcons.strokeRoundedPencilEdit01,
                  color: Colors.teal,
                  size: 15,
                ),
                Text(
                  " Check Note",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.teal, fontWeight: FontWeight.bold),
                )
              ],
            ));
  }
}
