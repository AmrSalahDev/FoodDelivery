import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/domain/repo/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetKeywordsUsecase {
  final SearchRepo searchRepo;
  GetKeywordsUsecase(this.searchRepo);

  Future<List<RecentKeywordsEntity>> call({String? query, int? limit}) =>
      searchRepo.getKeywords(query: query, limit: limit);
}
