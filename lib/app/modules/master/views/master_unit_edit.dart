import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterUnitEdit extends StatelessWidget {
  const MasterUnitEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Master Unit',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: Center(
        child: Text('Master Unit Edit'),
      ),
    );
  }
}