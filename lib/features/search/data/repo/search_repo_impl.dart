import 'package:food_delivery/features/search/data/models/recent_keywords_model.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/domain/repo/search_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SearchRepo)
class SearchRepoImpl extends SearchRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> saveKeyword(String keyword) async {
    try {
      await supabase.from('recent_keywords').insert({'keyword': keyword});
    } catch (e) {
      throw Exception("Failed to save keyword: $e");
    }
  }

  @override
  Future<List<RecentKeywordsEntity>> getKeywords() async {
    try {
      final response = await supabase
          .from('recent_keywords')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => RecentKeywordsModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch keywords: $e");
    }
  }
}
