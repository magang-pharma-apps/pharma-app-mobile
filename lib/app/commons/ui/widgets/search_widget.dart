import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(minWidth: 60),
        suffixIconConstraints: BoxConstraints(minWidth: 60),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent)),
        border: InputBorder.none,
        fillColor: Colors.grey.shade200,
        hintText: 'Search Medicine',
        prefixIcon: Icon(
          HugeIcons.strokeRoundedSearch01,
          color: Colors.grey,
          size: 30.0,
        ),
        suffixIcon: IconButton(
            onPressed: () {},
            hoverColor: Colors.transparent,
            icon: Icon(
              Icons.filter_alt,
              color: Colors.teal,
              size: 35,
            )),
      ),
    );
  }
}
