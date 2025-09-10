import 'package:flutter/services.dart';

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll('/', '');
    String newText = '';

    if (digitsOnly.length >= 2) {
      newText = digitsOnly.substring(0, 2);
      if (digitsOnly.length > 2) {
        newText += '/${digitsOnly.substring(2, digitsOnly.length.clamp(2, 6))}';
      }
    } else {
      newText = digitsOnly;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
