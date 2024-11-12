import 'dart:convert';

import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';
import 'package:medpia_mobile/app/providers/transaction_provider.dart';

class TransactionRepository {
  final transactionProvider = TransactionProvider();

  Future<bool> createTransaction(Map<String, dynamic> body) async {
    try {
      final response = await transactionProvider.createTransaction(body);
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // TODO
      print('Failed to created transaction $e');
      return false;
    }
  }

  Future<List<CartModel>> getTransactions() async {
    final response = await transactionProvider.getTransactions();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return data
          .map<CartModel>((json) => CartModel.transactionFromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load transactions ${response.statusCode}');
    }
  }
}
