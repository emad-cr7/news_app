class ApiConfig {
  static const baseUrl = "newsapi.org";
  static const baseUrlAuth = "dummyjson.com";
  static const String apiKey = "6b6a60f37b8144b195ec3aab5ae6f414";

  /// Endpoints
  static const String topHeadlines = "top-headlines";
  static const String everything = "everything";


  /// Auth Endpoints
  static const String login = "auth/login";
  static const String refresh = "auth/refresh";
  static const String currentUser = "auth/me";
}
