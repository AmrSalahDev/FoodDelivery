part of 'recent_keywords_cubit.dart';

sealed class RecentKeywordsState extends Equatable {
  const RecentKeywordsState();

  @override
  List<Object> get props => [];
}

final class RecentKeywordsInitial extends RecentKeywordsState {}

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

final class RecentKeywordSaving extends RecentKeywordsState {}

final class RecentKeywordSaved extends RecentKeywordsState {}

final class RecentKeywordSavingFailure extends RecentKeywordsState {
  final String message;
  const RecentKeywordSavingFailure({required this.message});
}

final class RecentKeywordDeleted extends RecentKeywordsState {}

final class RecentKeywordDeleting extends RecentKeywordsState {}
