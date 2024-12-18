
import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CategoryWidget extends StatefulWidget {
  String? productCount;
  CategoryModel? categoryModel;
  VoidCallback? onTap;
  CategoryWidget({super.key, this.categoryModel, this.productCount, this.onTap});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  CategoryRepository categoryRepository = CategoryRepository();

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          widget.onTap!();
          
        },
        shape: Border.all(color: Colors.grey.shade300, width: 1),
        leading: Image.network(
          widget.categoryModel!.categoryImageUrl!,
          width: 70,
        ),
        title: Row(
          children: [
            Text(widget.categoryModel!.name!),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.productCount!,
              style: TextStyle(color: Colors.grey.shade500),
            )
          ],
        ),
        trailing: Icon(Icons.navigate_next),
      ),
    );
  }
}
