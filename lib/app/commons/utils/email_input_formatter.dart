import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class EmailTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Enforce the email format by allowing only one '@' symbol.
    final emailParts = newValue.text.split('@');
    if (emailParts.length > 2) {
      // If more than one '@' is detected, revert to the old value.
      return oldValue;
    }
    return newValue;
  }
}
