import 'package:flutter/services.dart';
import 'package:medpia_mobile/app/commons/utils/format_rupiah.dart';

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any non-digit characters
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.isEmpty) {
      return newValue.copyWith(
          text: '', selection: TextSelection.collapsed(offset: 0));
    }

    try {
      final int number = int.parse(text);
      final formatted = FormatRupiah.format(number);

      // Avoid looping reformatting by checking if the formatted text matches
      if (formatted == newValue.text) {
        return newValue;
      }

      // Set cursor position at the end
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    } catch (e) {
      return oldValue; // Revert to old value if parsing fails
    }
  }
}
