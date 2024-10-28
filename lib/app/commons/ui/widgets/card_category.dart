import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CardCategory extends StatefulWidget {
  CategoryModel? categoryModel;
  CardCategory({super.key, this.categoryModel});

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  CategoryRepository categoryRepository = CategoryRepository();
  bool _isHovered = false;

  void getCategory() async {
    final response = await categoryRepository.getCategories();
    setState(() {
      categories = response;
    });
  }

  @override
  initState() {
    super.initState();
    getCategory();
  }

  List<CategoryModel> categories = [];

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
            child: Image.network(
              widget.categoryModel!.categoryImageUrl!,
            ),
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
