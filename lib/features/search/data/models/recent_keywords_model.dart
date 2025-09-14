import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';

class RecentKeywordsModel {
  final int id;
  final String keyword;

  RecentKeywordsModel({required this.id, required this.keyword});

  factory RecentKeywordsModel.fromJson(Map<String, dynamic> json) =>
      RecentKeywordsModel(
        id: json['id'] as int,
        keyword: json['keyword'] as String,
      );

  RecentKeywordsEntity toEntity() =>
      RecentKeywordsEntity(id: id, keyword: keyword);
}
