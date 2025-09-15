part of 'tracking_order_cubit.dart';

sealed class TrackingOrderState extends Equatable {
  const TrackingOrderState();

  @override
  List<Object> get props => [];
}

final class TrackingOrderInitial extends TrackingOrderState {}
