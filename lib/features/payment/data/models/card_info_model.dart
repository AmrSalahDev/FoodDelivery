class CardInfoModel {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cardType;
  final String cvv;
  final String cardLogo;

  CardInfoModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    required this.cardLogo,
  });
}
