import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());
}
