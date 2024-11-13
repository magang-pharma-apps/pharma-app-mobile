import 'package:flutter/material.dart';

class CategoryEditView extends StatelessWidget {
  const CategoryEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Edit Category',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
        child: Center(
          child: Text('Edit category page'),
        ),
      ),
    );
  }
}
