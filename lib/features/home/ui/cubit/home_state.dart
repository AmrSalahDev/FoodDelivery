part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {}

final class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

final class UserGreeting extends HomeState {
  final String greeting;
  UserGreeting({required this.greeting});

  @override
  List<Object?> get props => [greeting];
}
