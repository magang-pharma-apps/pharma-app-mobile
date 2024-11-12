import 'package:get/get.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
import 'package:medpia_mobile/app/repositories/transaction_repository.dart';

class ReportController extends GetxController {
  final transactionRepository = TransactionRepository();
  RxList<CartModel> transactionList = <CartModel>[].obs;

  @override
  void onInit() {
    getTransactions();
    super.onInit();
  }

  void getTransactions() async {
    try {
      isLoading.value = true;
      final response = await transactionRepository.getTransactions();
      transactionList.value = response;
    } catch (e) {
      
      print(e);
    }
    finally {
      isLoading.value = false;
    }
  }

  RxBool isLoading = false.obs;
  
}
