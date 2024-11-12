import 'package:flutter/material.dart';

class MasterCustomerEdit extends StatelessWidget {
  const MasterCustomerEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
            Text('Edit Patient', style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
        child: Center(
          child: Text('Edit patient page'),
        ),
      ),
    );();
  }
}