import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/api_provider.dart';

class TransactionProvider extends ApiProvider {
  TransactionProvider()
      : super(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('accessToken')}'
        });

  Future<http.Response> createTransaction(Map<String, dynamic> body) async {
    return await post('transactions', body);
  }

  Future<http.Response> getTransactions() async {
    final response = await get('transactions');
    return response;
  }

  Future<http.Response> getTransactionById(String id) async {
    final response = await get('transaction/$id');
    return response;
  }
}
