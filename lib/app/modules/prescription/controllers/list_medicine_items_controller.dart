import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/prescription/controllers/redemption_controller.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class ListMedicineItemsController extends GetxController {
  final productRepository = ProductRepository();
  final redemptionController = Get.find<RedemptionController>();
  RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    final response = await productRepository.getProducts();
    products.value = response;
  }

  void addMedicine(CartItemModel medicineItem) {
    final items = redemptionController.prescription.value.cart!.items;
    final index = items!.indexWhere(
        (element) => element.product!.id == medicineItem.product!.id);
    if (index >= 0) {
      items[index].quantity = items[index].quantity! + 1;
    } else {
      items.add(medicineItem);
    }
    redemptionController.calculateSubtotal();
    redemptionController.calculateGrandtotal();
    redemptionController.calculateTax();
  }
}
