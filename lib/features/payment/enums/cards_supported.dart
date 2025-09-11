import 'package:food_delivery/core/gen/assets.gen.dart';

enum CardsSupported {
  masterCard("mastercard"),
  visaCard("visa"),
  payPal("paypal");

  final String key;
  const CardsSupported(this.key);
}

extension CardsSupportedX on CardsSupported {
  String get icon {
    switch (this) {
      case CardsSupported.masterCard:
        return Assets.icons.icMastercard.path;
      case CardsSupported.visaCard:
        return Assets.icons.icVisa.path;
      case CardsSupported.payPal:
        return Assets.icons.icPaypal.path;
    }
  }

  String get displayName {
    switch (this) {
      case CardsSupported.masterCard:
        return "MasterCard";
      case CardsSupported.visaCard:
        return "Visa";
      case CardsSupported.payPal:
        return "PayPal";
    }
  }
}
