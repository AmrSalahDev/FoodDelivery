import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/search/domain/entities/recent_keywords_entity.dart';
import 'package:food_delivery/features/search/domain/usecases/delete_keyword_usecase.dart';
import 'package:food_delivery/features/search/domain/usecases/get_keywords_usecase.dart';
import 'package:food_delivery/features/search/domain/usecases/save_keyword_usecase.dart';
import 'package:injectable/injectable.dart';

part 'recent_keywords_state.dart';

@injectable
class RecentKeywordsCubit extends Cubit<RecentKeywordsState> {
  final SaveKeywordUsecase saveKeywordUsecase;
  final GetKeywordsUsecase getKeywordsUsecase;
  final DeleteKeywordUseCase deleteKeywordUseCase;

  Timer? _debounce;

  RecentKeywordsCubit({
    required this.saveKeywordUsecase,
    required this.getKeywordsUsecase,
    required this.deleteKeywordUseCase,
  }) : super(RecentKeywordsInitial());

  Future<void> saveKeyword(String keyword) async {
    if (isClosed) return;
    emit(RecentKeywordSaving());
    try {
      await saveKeywordUsecase(keyword);
      await fetchKeywords();
    } catch (e) {
      emit(RecentKeywordSavingFailure(message: e.toString()));
    }
  }

  Future<void> fetchKeywords({String? query}) async {
    if (isClosed) return;
    emit(RecentKeywordsLoading());
    try {
      final keywords = await getKeywordsUsecase(query: query);
      emit(RecentKeywordsLoaded(keywords: keywords));
    } catch (e) {
      emit(RecentKeywordsFailure(message: e.toString()));
    }
  }

  void filterKeywords(String query) {
    if (isClosed) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      fetchKeywords(query: query);
    });
  }

  Future<void> deleteKeyword(String keyword) async {
    if (isClosed) return;
    emit(RecentKeywordDeleting());
    try {
      await deleteKeywordUseCase(keyword);
      await fetchKeywords();
    } catch (e) {
      emit(RecentKeywordDeletingFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
