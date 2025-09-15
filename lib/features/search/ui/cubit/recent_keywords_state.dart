part of 'recent_keywords_cubit.dart';

sealed class RecentKeywordsState extends Equatable {
  const RecentKeywordsState();

  @override
  List<Object> get props => [];
}

final class RecentKeywordsInitial extends RecentKeywordsState {}

// Fetching Keywords states
final class RecentKeywordsLoading extends RecentKeywordsState {}

final class RecentKeywordsLoaded extends RecentKeywordsState {
  final List<RecentKeywordsEntity> keywords;
  const RecentKeywordsLoaded({required this.keywords});

  @override
  List<Object> get props => [keywords];
}

final class RecentKeywordsFailure extends RecentKeywordsState {
  final String message;
  const RecentKeywordsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// Saving Keyword states

final class RecentKeywordSaving extends RecentKeywordsState {}

final class RecentKeywordSaved extends RecentKeywordsState {}

final class RecentKeywordSavingFailure extends RecentKeywordsState {
  final String message;
  const RecentKeywordSavingFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// Deleting Keyword states

final class RecentKeywordDeleted extends RecentKeywordsState {}

final class RecentKeywordDeleting extends RecentKeywordsState {}

final class RecentKeywordDeletingFailure extends RecentKeywordsState {
  final String message;
  const RecentKeywordDeletingFailure({required this.message});

  @override
  List<Object> get props => [message];
}
