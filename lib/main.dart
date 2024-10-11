import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/main_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  GetStorage().writeIfNull('isLogin', false);
  runApp(MainApp());
}

