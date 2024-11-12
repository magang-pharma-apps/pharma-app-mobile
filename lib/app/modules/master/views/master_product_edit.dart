import 'package:flutter/material.dart';

class MasterProductEdit extends StatelessWidget {
  const MasterProductEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
            Text('Edit Product', style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
        child: Center(
          child: Text('Edit product page'),
        ),
      ),
    );
  }
}
