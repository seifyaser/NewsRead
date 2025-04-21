class NewsArticle {
  final String title;
  final String link;
  final String description;
  final DateTime? pubDate;
  final String imageUrl;
  final String sourceName;
  final String sourceIcon;
 final String category;

  NewsArticle( {
required this.category,
    required this.title,
    required this.link,

    required this.description,

    required this.pubDate,

    required this.imageUrl,

    required this.sourceName,

    required this.sourceIcon,

  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(

      title: json['title'],
      link: json['link'],

      description: json['description'],

      pubDate: json['pubDate'] != null
          ? DateTime.parse(json['pubDate']) 
          : null,

      imageUrl: json['image_url'],
 
      sourceName: json['source_name'],
      sourceIcon: json['source_icon'],
       category: json['category'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
       'category': category,
      'description': description,
      'pubDate': pubDate,

      'image_url': imageUrl,

      'source_name': sourceName,

      'source_icon': sourceIcon,

    };
  }
}
