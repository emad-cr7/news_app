part of 'search_cubit.dart';

class SearchState extends Equatable {
  List<NewsArticleModel> newsEverythingList;
  RequestStatusEnum everythingStatus;
  String? errorMessage;

  SearchState({
    this.newsEverythingList = const [],
    this.everythingStatus = RequestStatusEnum.loading,
    this.errorMessage,
  });

  SearchState copyWith({
    List<NewsArticleModel>? newsEverythingList,
    RequestStatusEnum? everythingStatus,
    String? errorMessage,
  }) {
    return SearchState(
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
      everythingStatus: everythingStatus ?? this.everythingStatus,
      errorMessage: errorMessage ,
    );
  }

  @override
  List<Object?> get props => [
        newsEverythingList,
        everythingStatus,
        errorMessage,
      ];

}
