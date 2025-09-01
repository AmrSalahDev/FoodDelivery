import 'package:equatable/equatable.dart';
import 'package:food_delivery/core/gen/assets.gen.dart';

class IngridentsModel extends Equatable {
  final String title;
  final String image;

  const IngridentsModel({required this.title, required this.image});

  @override
  List<Object?> get props => [title, image];

  static final List<IngridentsModel> ingridentsList = [
    IngridentsModel(title: 'Broccoli', image: Assets.icons.icBroccoli.path),
    IngridentsModel(title: 'Chicken', image: Assets.icons.icChicken.path),
    IngridentsModel(title: 'Garlic', image: Assets.icons.icGarlic.path),
    IngridentsModel(title: 'Ginger', image: Assets.icons.icGinger.path),
    IngridentsModel(title: 'Onion', image: Assets.icons.icOnion.path),
    IngridentsModel(title: 'Orange', image: Assets.icons.icOrange.path),
    IngridentsModel(title: 'Pappers', image: Assets.icons.icPappers.path),
    IngridentsModel(title: 'Salt', image: Assets.icons.icSalt.path),
    IngridentsModel(title: 'Walnut', image: Assets.icons.icWalnut.path),
  ];
}
