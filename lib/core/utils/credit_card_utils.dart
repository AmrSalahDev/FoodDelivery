class CreditCardUtils {
  CreditCardUtils._();

  static String maskCardNumber(String number) {
    if (number.length <= 4) return number;
    final last4 = number.substring(number.length - 4);
    return '*' * (number.length - 4) + last4;
  }
}
