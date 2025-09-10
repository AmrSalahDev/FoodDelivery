class Validators {
  Validators._();

  static String? cardNumberValidator(String? value, String errorMsg) {
    // Validate less that 13 digits +3 white spaces
    return (value?.isEmpty ?? true) || (value?.length ?? 16) < 16
        ? errorMsg
        : null;
  }

  static String? expiryDateValidator(String? value, String errorMsg) {
    if (value?.isEmpty ?? true) {
      return errorMsg;
    }

    final DateTime now = DateTime.now();
    final List<String> date = value!.split(RegExp(r'/'));

    // Must have exactly 2 parts: MM and YY or YYYY
    if (date.length != 2) return errorMsg;

    final int month = int.tryParse(date.first) ?? 0;
    String yearPart = date.last;

    // Convert YY → YYYY (assuming 2000s)
    if (yearPart.length == 2) {
      yearPart = '20$yearPart';
    }

    final int year = int.tryParse(yearPart) ?? 0;

    // Invalid month/year
    if (month < 1 || month > 12 || year < 1000) {
      return errorMsg;
    }

    // Get last day of the month
    final int lastDayOfMonth = month < 12
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;

    final DateTime cardDate = DateTime(
      year,
      month,
      lastDayOfMonth,
      23,
      59,
      59,
      999,
    );

    // If expired
    if (cardDate.isBefore(now)) {
      return errorMsg;
    }

    return null;
  }

  static String? cvvValidator(String? value, String errorMsg) {
    return (value?.isEmpty ?? true) || ((value?.length ?? 3) < 3)
        ? errorMsg
        : null;
  }
}
