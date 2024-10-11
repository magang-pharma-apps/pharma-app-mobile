import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/models/category_model.dart';

class CardCategory extends StatefulWidget {
  CategoryModel? categoryModel;
  CardCategory({super.key, this.categoryModel});

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () {},
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: _isHovered ? Colors.blue.shade200 : Colors.blue.shade100,
                borderRadius: BorderRadius.circular(30)),
            child: Image.asset(widget.categoryModel!.image!),
          ),
          SizedBox(height: 10),
          Text(widget.categoryModel!.name!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? Colors.teal.shade700 : Colors.black))
        ],
      ),
    );
  }
}
