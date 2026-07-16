import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/request_status_enum.dart';
import '../../../core/repos/news_repository.dart';
import '../../home/models/news_article_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.newsRepository) : super(SearchState());

  TextEditingController searchController = TextEditingController();

  final BaseNewsRepository newsRepository;

  getEverything() async {
    try {
      final getEverything = await newsRepository.getEverything(
        query: searchController.text,
      );
      emit(
        state.copyWith(
          newsEverythingList: getEverything,
          everythingStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          everythingStatus: RequestStatusEnum.error,
        ),
      );
    }
  }
}
