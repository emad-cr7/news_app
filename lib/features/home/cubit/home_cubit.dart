import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import '../../../core/enums/request_status_enum.dart';
import '../../../core/repos/news_repository.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newsRepository) : super(HomeInitial()) {
    getTopHeadLine();
    getEverything();
  }

  final BaseNewsRepository newsRepository;

  getTopHeadLine({String? category}) async {
    try {
      emit(state.copyWith(newsTopHeadLineStatus: RequestStatusEnum.loading));

      final articles = await newsRepository.getTopHeadLine(
        selectedCategory: state.selectedCategory,
      );
      emit(state.copyWith(newsTopHeadLineList: articles ,
      newsTopHeadLineStatus: RequestStatusEnum.loaded ,
        errorMessage: null ,
      ));


    } catch (e) {
      emit(state.copyWith(
        newsTopHeadLineStatus: RequestStatusEnum.error ,
        errorMessage: e.toString(),
      ));
    }
  }

  getEverything() async {
    try {
      final articles = await newsRepository.getEverything();
      emit(state.copyWith(
        newsEverythingList: articles,
        everythingStatus: RequestStatusEnum.loaded,
        errorMessage: null,
      ));

    } catch (e) {
      emit(state.copyWith(
        everythingStatus: RequestStatusEnum.error,
        errorMessage: e.toString(),
      ));
    }
  }
  void updateSelectedCategory(String category) {

    emit(state.copyWith(selectedCategory: category ,));
    getTopHeadLine(category: state.selectedCategory);
  }
}
