import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/models/category_model.dart';

class ListCategory extends StatefulWidget {
  CategoryModel? categoryModel;
  ListCategory({super.key, this.categoryModel});

  @override
  State<ListCategory> createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  CategoryRepository categoryRepository = CategoryRepository();

  void getCategory() {
    final response = categoryRepository.getCategory();
    setState(() {
      categories = response.map((data) {
        return CategoryModel.fromJson(data);
      }).toList();
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
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 0.5)),
      child: ListTile(
        onTap: () {},
        shape: Border.all(color: Colors.grey.shade300, width: 1),
        leading: Image.asset(
          widget.categoryModel!.image!,
          width: 100,
        ),
        title: Row(
          children: [
            Text(widget.categoryModel!.name!),
            SizedBox(
              width: 10,
            ),
            Text(
              "(10)",
              style: TextStyle(color: Colors.grey.shade500),
            )
          ],
        ),
        trailing: Icon(Icons.navigate_next),
      ),
    );
  }
}
