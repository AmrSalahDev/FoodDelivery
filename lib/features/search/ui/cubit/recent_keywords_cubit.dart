import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/domain/usecases/get_keywords_usecase.dart';
import 'package:food_delivery/features/search/domain/usecases/save_keyword_usecase.dart';
import 'package:injectable/injectable.dart';

part 'recent_keywords_state.dart';

@injectable
class RecentKeywordsCubit extends Cubit<RecentKeywordsState> {
  final SaveKeywordUsecase saveKeywordUsecase;
  final GetKeywordsUsecase getKeywordsUsecase;

  RecentKeywordsCubit({
    required this.saveKeywordUsecase,
    required this.getKeywordsUsecase,
  }) : super(RecentKeywordsInitial());

  Future<void> saveKeyword(String keyword) async {
    emit(RecentKeywordSaving());
    try {
      await saveKeywordUsecase(keyword);
      final keywords = await getKeywordsUsecase();
      emit(RecentKeywordsLoaded(keywords: keywords));
    } catch (e) {
      emit(RecentKeywordSavingFailure(message: e.toString()));
    }
  }

  Future<void> fetchKeywords() async {
    emit(RecentKeywordsLoading());
    try {
      final keywords = await getKeywordsUsecase();

      emit(RecentKeywordsLoaded(keywords: keywords));
    } catch (e) {
      emit(RecentKeywordsFailure(message: e.toString()));
    }
  }
}
