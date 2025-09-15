import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tracking_order_state.dart';

class TrackingOrderCubit extends Cubit<TrackingOrderState> {
  TrackingOrderCubit() : super(TrackingOrderInitial());
}
