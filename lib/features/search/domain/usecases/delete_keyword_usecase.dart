import 'package:food_delivery/features/search/domain/repo/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteKeywordUseCase {
  final SearchRepo repo;
  DeleteKeywordUseCase(this.repo);
  Future<void> call(String keyword) => repo.deleteKeyword(keyword);
}
