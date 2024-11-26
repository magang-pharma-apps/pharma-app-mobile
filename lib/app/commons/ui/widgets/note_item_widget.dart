import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NoteItemWidget extends StatefulWidget {
  final Function(String) onChanged;
  const NoteItemWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<NoteItemWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget> {
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
              prefixIcon: Icon(
                HugeIcons.strokeRoundedNoteAdd,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.teal.withOpacity(0.25),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              isDense: true,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.teal.shade400, // Warna garis bawah saat fokus
                  // Ketebalan garis bawah saat fokus
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Warna garis bawah saat tidak fokus
                ),
              ),
              labelStyle: TextStyle(fontSize: 9),
              filled: false,
              fillColor: Colors.grey.shade100,
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
              label: Text("Write a note"),
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
                  HugeIcons.strokeRoundedNoteAdd,
                  color: Colors.teal,
                  size: 18,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.teal.withOpacity(0.25),
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                Text("Note",
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
