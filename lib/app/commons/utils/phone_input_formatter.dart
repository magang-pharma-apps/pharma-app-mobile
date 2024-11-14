import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Removes any extra spaces or dashes, keeping only the first '+' if it exists.
    String filteredText = newValue.text.replaceAll(RegExp(r'[^+\d]'), '');
    if (filteredText.startsWith('+')) {
      filteredText = '+' + filteredText.substring(1).replaceAll('+', '');
    }
    return TextEditingValue(
      text: filteredText,
      selection: newValue.selection,
    );
  }
}