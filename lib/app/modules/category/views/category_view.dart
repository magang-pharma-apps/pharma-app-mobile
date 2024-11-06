import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_category.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/category_widget.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/category_provider.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class CategoryView extends StatefulWidget {
  CategoryModel? categoryModel;
  CategoryView({super.key, this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  CategoryRepository categoryRepository = CategoryRepository();
  final CategoryProvider categoryProvider = CategoryProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('All Categories',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            FutureBuilder<List<CategoryModel>>(
                future: fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
                        // print(category);
                        return CategoryWidget(categoryModel: category);
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return const Center(child: Text('No data found!'));
                  }
                })
          ],
        ),
      ),
    );
  }

  Future<List<CategoryModel>> fetchCategory() async {
    try {
      return categoryRepository.getCategories();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load category $e');
    }
  }
}
