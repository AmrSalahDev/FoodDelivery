import 'package:equatable/equatable.dart';

class RecentKeywordsEntity extends Equatable {
  final int id;
  final String keyword;

  const RecentKeywordsEntity({required this.id, required this.keyword});

  @override
  List<Object?> get props => [id, keyword];
}
