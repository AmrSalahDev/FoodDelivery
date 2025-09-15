import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  TextEditingController? controller;

  void onSearch({
    required String value,
    required TextEditingController controller,
  }) {
    this.controller = controller;
    emit(OnSearchState(value: value));
  }

  void setText(String text) {
    controller?.text = text;
    emit(OnSearchState(value: text));
  }

  String getText() => controller?.text ?? "";

  void clear() {
    controller?.clear();
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}
