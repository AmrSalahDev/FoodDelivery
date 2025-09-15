import 'package:food_delivery/features/search/data/models/recent_keywords_model.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/domain/repo/search_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: SearchRepo)
class SearchRepoImpl extends SearchRepo {
  final supabase = Supabase.instance.client;

  @override
  /// Saves a keyword to the database.
  ///
  /// If the [keyword] is empty or its length is less than 3, the function
  /// will return without saving the keyword.
  ///
  /// Throws an [Exception] if there is an error saving the keyword.
  Future<void> saveKeyword(String keyword) async {
    try {
      // Check if the keyword is empty or its length is less than 3
      if (keyword.isEmpty || keyword.length < 3) {
        return;
      }

      // Insert the keyword into the database
      await supabase.from('recent_keywords').insert({
        'keyword': keyword,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Throw an exception if there is an error saving the keyword
      throw Exception("Failed to save keyword: $e");
    }
  }

  @override
  /// Fetches a list of recent keywords from the database.
  ///
  /// If [query] is not null or empty, the function will search for
  /// keywords that contain [query].
  ///
  /// If [limit] is not null, the function will limit the number of
  /// keywords returned to [limit].
  ///
  /// Returns a list of [RecentKeywordsEntity].
  ///
  /// Throws an [Exception] if there is an error fetching the keywords.
  Future<List<RecentKeywordsEntity>> getKeywords({
    /// The query to search for in the keywords.
    /// If null or empty, the function will return all keywords.
    String? query,

    /// The limit of the number of keywords to return.
    /// If null, the function will return all keywords.
    int? limit,
  }) async {
    try {
      // Trim the query to remove any leading or trailing whitespace
      final trimmed = query?.trim() ?? '';

      // Build the query
      dynamic builder = supabase.from('recent_keywords').select();

      // If the query is not empty, search for keywords that contain the query
      if (trimmed.isNotEmpty) {
        builder = builder.ilike('keyword', '%$trimmed%');
      }

      // Order the keywords by created_at in descending order
      builder = builder.order('created_at', ascending: false);

      // If a limit is provided, limit the number of keywords returned
      if (limit != null) {
        builder = builder.limit(limit);
      }

      // Execute the query
      final response = await builder;

      // Map the response to a list of RecentKeywordsEntity
      return (response as List)
          .map((json) => RecentKeywordsModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      // Throw an exception if there is an error fetching the keywords
      throw Exception("Failed to fetch keywords: $e");
    }
  }
}
