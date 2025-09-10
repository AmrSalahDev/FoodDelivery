import 'package:flutter/material.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

class CardsModel {
  final String logo;
  final String title;
  final Color color;
  final String desc;
  final String subDesc;

  CardsModel({
    required this.logo,
    required this.title,
    required this.color,
    required this.desc,
    required this.subDesc,
  });

  static final List<CardsModel> cards = [
    CardsModel(
      logo: Assets.icons.icCash.path,
      title: 'Cash',
      color: Color(0xFFFF7622).withAlpha(110),
      desc: 'Pay with cash',
      subDesc: 'You can pay with cash',
    ),
    CardsModel(
      logo: Assets.icons.icVisa.path,
      title: 'Visa',
      color: Color(0xFF005bac).withAlpha(100),
      desc: 'No visa card added',
      subDesc: 'You can add a visa card and save it for later',
    ),
    CardsModel(
      logo: Assets.icons.icMastercard.path,
      title: 'Mastercard',
      color: Color(0xFFFF7622).withAlpha(130),
      desc: 'No mastercard added',
      subDesc: 'You can add a mastercard and save it for later',
    ),
    CardsModel(
      logo: Assets.icons.icPaypal.path,
      title: 'Paypal',
      color: Color(0xFF005bac).withAlpha(100),
      desc: 'No paypal card added',
      subDesc: 'You can add a paypal card and save it for later',
    ),
  ];
}
