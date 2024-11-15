import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/modules/auth/views/auth_view.dart';

class CustomConfirmModal extends StatelessWidget {
  String? customTitle;
  String? buttonText;
  String? imageAssetName;
  VoidCallback? onPressed;
  CustomConfirmModal(
      {super.key,
      this.customTitle,
      this.buttonText,
      this.imageAssetName,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                customTitle!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
            Image(image: AssetImage(imageAssetName!), height: 150),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.sizeOf(context).width * 0.8, 30),
                    visualDensity: VisualDensity.compact),
                onPressed: () {
                  onPressed!();
                },
                child: Text(buttonText!))
          ],
        ),
      ),
    );
  }
}
