import 'package:food_delivery/features/search/domain/repo/search_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveKeywordUsecase {
  final SearchRepo searchRepo;

  SaveKeywordUsecase({required this.searchRepo});

  Future<void> call(String keyword) => searchRepo.saveKeyword(keyword);
}
