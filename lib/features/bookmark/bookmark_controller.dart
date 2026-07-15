import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/features/bookmark/data/bookmark_repository.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class BookmarkController extends ChangeNotifier with SafeNotify {
  final BookmarkRepository _repository = BookmarkRepository();

  RequestStatusEnum bookmarksStatus = RequestStatusEnum.loading;
  List<BookmarkModel> bookmarks = [];
  String? errorMessage;

  // Search state
  String searchQuery = '';

  BookmarkController() {
    loadBookmarks();
  }

  void loadBookmarks() {
    try {
      bookmarksStatus = RequestStatusEnum.loading;
      safeNotify();

      if (searchQuery.isEmpty) {
        bookmarks = _repository.getBookmarks();
      } else {
        return;
      }

      bookmarksStatus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      bookmarksStatus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }


  Future<bool> toggleBookmark(NewsArticleModel article) async {
    try {
      final wasAdded = await _repository.toggleBookmark(article);

      loadBookmarks();

      return wasAdded;
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
      return false;
    }
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    try {
      await _repository.addBookmark(article);
      loadBookmarks();
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
    }
  }

  Future<void> removeBookmark(String articleUrl) async {
    try {
      await _repository.removeBookmark(articleUrl);
      loadBookmarks();
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
    }
  }

  bool isArticleBookmarked(String? articleUrl) {
    return _repository.isBookmarked(articleUrl);
  }

  int get bookmarkCount => _repository.getBookmarkCount();

  Future<void> clearAllBookmarks() async {
    try {
      await _repository.clearAllBookmarks();
      loadBookmarks();
    } catch (e) {
      errorMessage = e.toString();
      safeNotify();
    }
  }



  NewsArticleModel getArticleFromBookmark(BookmarkModel bookmark) {
    return _repository.bookmarkToArticle(bookmark);
  }

  Future<void> refresh() async {
    loadBookmarks();
  }

  List<NewsArticleModel> get bookmarksAsArticles {
    return bookmarks.map((bookmark) => _repository.bookmarkToArticle(bookmark)).toList();
  }
}