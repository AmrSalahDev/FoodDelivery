part of 'my_orders_cubit.dart';

sealed class MyOrdersState extends Equatable {
  const MyOrdersState();

  @override
  List<Object> get props => [];
}

final class MyOrdersInitial extends MyOrdersState {}
