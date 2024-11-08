import 'package:intl/intl.dart';

class FormatRupiah {
  static String format(int number) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
        .format(number);
  }
}
