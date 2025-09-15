import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());
}
