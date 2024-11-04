import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';

class RedemptionController extends GetxController {
  Rx<PrescriptionModel> prescription = PrescriptionModel().obs;

  @override
  void onInit() {
    super.onInit();
    prescription.value = Get.arguments;
    prescription.value.medicines = <CartItemModel>[].obs;
  }
}
