import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_category.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/list_category.dart';
import 'package:medpia_mobile/app/models/category_model.dart';

class CategoryView extends StatefulWidget {
  CategoryModel? categoryModel;
  CategoryView({super.key, this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            CustomAppBar(appBarTitle: "All Categories"),
            SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ListCategory(
                      categoryModel: categories.elementAt(index));
                },
                itemCount: categories.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
