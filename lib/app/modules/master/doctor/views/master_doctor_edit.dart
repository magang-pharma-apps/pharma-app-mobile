import 'package:flutter/material.dart';

class MasterDoctorEdit extends StatelessWidget {
  const MasterDoctorEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
            Text('Edit Doctor', style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
        child: Center(
          child: Text('Edit doctor page'),
        ),
      ),
    );
  }
}
