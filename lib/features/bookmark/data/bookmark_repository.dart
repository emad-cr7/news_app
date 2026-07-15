import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class BookmarkRepository {
  BookmarkRepository._internal();

  static final BookmarkRepository _instance = BookmarkRepository._internal();

  factory BookmarkRepository() => _instance;

  Box<BookmarkModel>? _bookmarkBox;

  Box<BookmarkModel> get bookmarkBox {
    if (_bookmarkBox == null) {
      throw Exception("BookmarkRepository not initialized");
    }
    return _bookmarkBox!;
  }

  Future<void> init() async {
    Hive.registerAdapter(BookmarkModelAdapter());
    _bookmarkBox = await Hive.openBox<BookmarkModel>(Constants.bookmarkBox);
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    final bookmark = BookmarkModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url ?? '',
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      bookmarkedAt: DateTime.now(),
    );

    await bookmarkBox.put(article.url, bookmark);
  }

  Future<void> removeBookmark(String articleUrl) async {
    await bookmarkBox.delete(articleUrl);
  }

  List<BookmarkModel> getBookmarks() => bookmarkBox.values.toList();

  bool isBookmarked(String? articleUrl) {
    if (articleUrl == null || articleUrl.isEmpty) return false;
    return bookmarkBox.containsKey(articleUrl);
  }

  BookmarkModel? getBookmark(String articleUrl) {
    return bookmarkBox.get(articleUrl);
  }


  Future<bool> toggleBookmark(NewsArticleModel article) async {
    if (isBookmarked(article.url)) {
      await removeBookmark(article.url!);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }

  int getBookmarkCount() {
    return bookmarkBox.length;
  }

  Future<void> clearAllBookmarks() async {
    await bookmarkBox.clear();
  }



  NewsArticleModel bookmarkToArticle(BookmarkModel bookmark) {
    return NewsArticleModel(
      author: bookmark.author,
      title: bookmark.title,
      description: bookmark.description,
      url: bookmark.url,
      urlToImage: bookmark.urlToImage,
      publishedAt: bookmark.publishedAt,
      content: bookmark.content,
    );
  }
}
