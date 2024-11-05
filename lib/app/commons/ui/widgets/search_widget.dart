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
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          prefixIconConstraints: BoxConstraints(minWidth: 40),
          suffixIconConstraints: BoxConstraints(minWidth: 40),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.transparent)),
          border: InputBorder.none,
          fillColor: Colors.grey.shade200,
          hintText: 'Search Medicine',
          hintStyle: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),
          prefixIcon: Icon(
            HugeIcons.strokeRoundedSearch01,
            color: Colors.grey,
            size: 20.0,
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            hoverColor: Colors.transparent,
            icon: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.teal.shade300,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                )),
          )),
    );
  }
}
