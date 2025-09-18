part of 'drop_down_cubit.dart';

abstract class DropDownState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DropDownInitial extends DropDownState {}

class DropDownSelected extends DropDownState {
  final String value;
  DropDownSelected(this.value);

  @override
  List<Object?> get props => [value];
}
