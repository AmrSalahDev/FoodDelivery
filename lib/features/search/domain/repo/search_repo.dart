import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';

abstract class SearchRepo {
  Future<void> saveKeyword(String keyword);
  Future<List<RecentKeywordsEntity>> getKeywords({String? query, int? limit});
  Future<void> deleteKeyword(String keyword);
}
