import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CategoryWidget extends StatefulWidget {
  CategoryModel? categoryModel;
  CategoryWidget({super.key, this.categoryModel});

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
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 0.5)),
      child: ListTile(
        onTap: () {},
        shape: Border.all(color: Colors.grey.shade300, width: 1),
        leading: Image.network(
          widget.categoryModel!.categoryImageUrl!,
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
