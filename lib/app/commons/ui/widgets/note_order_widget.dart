import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NoteOrderWidget extends StatefulWidget {
  final Function(String) onChanged;
  const NoteOrderWidget({
    super.key, required this.onChanged,
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
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
            ),
            onTapOutside: (value) {},
          )
        : ElevatedButton(
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
            onPressed: () {
              setState(() {
                _isClicked = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  HugeIcons.strokeRoundedPencilEdit01,
                  color: Colors.teal,
                ),
                Text(
                  " Check Note",
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ));
  }
}
