import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/modules/category/controllers/category_controller.dart';
import 'package:medpia_mobile/app/modules/product/views/product_view.dart';

class CardCategory extends StatefulWidget {
  CategoryModel? categoryModel;
  CardCategory({super.key, this.categoryModel});

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  bool _isHovered = false;
  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () {
        if (controller.getProductsByCategory(widget.categoryModel!.id) == 0) {
          return;
        }
        Get.to(ProductView(categoryId: widget.categoryModel!.id.toString(),));
      },
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: 90,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:
                      _isHovered ? Colors.blue.shade200 : Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.network(
                widget.categoryModel!.categoryImageUrl!,
              ),
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
