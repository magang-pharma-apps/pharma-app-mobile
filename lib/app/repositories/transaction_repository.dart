import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/providers/transaction_provider.dart';

class TransactionRepository {
  final transactionProvider = TransactionProvider();

  Future<bool> createTransaction(Map<String, dynamic> body) async {
    try {
      final response = await transactionProvider.createTransaction(body);
      print(response.body);
      print(response.statusCode);
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
}
