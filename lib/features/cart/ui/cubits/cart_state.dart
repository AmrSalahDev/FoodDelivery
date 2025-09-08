part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class AddressEditMode extends CartState {
  const AddressEditMode();
}

final class AddressDoneMode extends CartState {
  const AddressDoneMode();
}
