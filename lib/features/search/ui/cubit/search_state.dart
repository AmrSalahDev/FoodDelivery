part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class OnSearchState extends SearchState {
  final String value;
  const OnSearchState({required this.value});

  @override
  List<Object> get props => [value];
}
