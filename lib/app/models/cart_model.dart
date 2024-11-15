import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/utils/format_rupiah.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/user_model.dart';

class CartModel {
  List<CartItemModel>? items = [];
  String? userId;
  double? subtotal;
  double? grandtotal;
  int? tax;
  String? paymentMethod;
  String? note;
  String? transactionDate;
  String? transactionCode;
  String? transactionType;
  UserModel? user;

  CartModel(
      {this.items,
      this.userId,
      this.subtotal,
      this.grandtotal,
      this.tax,
      this.paymentMethod,
      this.note,
      this.transactionDate,
      this.transactionCode,
      this.transactionType,
      this.user}); //karena dikasih kurawal maka ini disebut named parameter
  // Bisa diambil dengan tidak berurutan namun harus menyebutkan nama parameternya

  factory CartModel.transactionFromJson(Map<String, dynamic> json) {
    // print(json);
    // print('SUBTOTAL : ${json['subTotal']}');
    return CartModel(
        items: json['items'] is List
            ? List<CartItemModel>.from(
                json['items'].map((x) => CartItemModel.fromJson(x)))
            : [],
        subtotal: json['subTotal'] != null ? json['subTotal'].toDouble() : 0.0,
        grandtotal:
            json['grandTotal'] != null ? json['grandTotal'].toDouble() : 0.0,
        tax: json['tax'] ?? 0,
        paymentMethod: json['paymentMethod'] ?? '',
        note: json['note'] ?? '',
        transactionDate: json['transactionDate'] ?? '',
        userId: json['userId'],
        transactionCode: json['transactionCode'] ?? '',
        transactionType: json['transactionType'] ?? 'Generic',
        user: json['user'] != null ? UserModel.fromJson(json['user']) : null);
  }

  Map<String, dynamic> toJson({String transactionType = 'Generic'}) {
    return {
      'items': items!.map((item) => item.toJson()).toList(),
      'userId': GetStorage().read('userId'),
      'tax': tax,
      'subTotal': subtotal,
      'grandTotal': grandtotal,
      'transactionType': transactionType,
      'categoryType': 'Out', // VS In Stock (untuk enum di be )
      'transactionDate':
          DateTime.now().toUtc().add(Duration(hours: 7)).toIso8601String(),
      'paymentMethod': paymentMethod,
      'note': note,
    };
  }

  String get formattedDate {
    return DateFormat('MM/dd/yyyy hh:mm a')
        .format(DateTime.parse(transactionDate!));
  }

  String get createdPayment =>
      '${paymentMethod!} | Cashier by ${user!.username!}';

  String get subtotalFormatted => FormatRupiah.format(subtotal!.toInt());

  String get taxFormatted => FormatRupiah.format(tax!.toInt());

  String get grandtotalFormatted => FormatRupiah.format(grandtotal!.toInt());

  String get productLabel {
    if (items!.isNotEmpty) {
      final product = items![0].product;
      return '(${product?.productCode ?? ''}) ${product?.name ?? ''}';
    }
    return '';
  }

  // String get productImage => items![0].product!.productImageUrl!;
  String get productImage {
    if (items!.isNotEmpty) {
      final product = items![0].product;
      return '${product?.productImageUrl}';
    }
    return '';
  }


  String get productQty {
    if (items != null && items!.isNotEmpty) {
      // final itemPrice = items![0].productPrice;
      final itemQty = items![0].quantity;
      return '${items![0].productPrice}   x$itemQty';
    }
    return '';
  }

  // String get itemNote => items![0].note!;
  String get itemNote {
    if (items!.isNotEmpty) {
      return items![0].note!;
    }
    return '';
  }
}
