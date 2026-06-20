class NewsArticleModel {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlImage;
  final String? publishedAt;
  final String? content;

  NewsArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlImage,
    required this.publishedAt,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlImage': urlImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory NewsArticleModel.fromJson(Map<String, dynamic> map) {
    return NewsArticleModel(
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlImage: map['urlImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }
}
