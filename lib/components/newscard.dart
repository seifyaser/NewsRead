import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/models/newsarticle.dart';
import 'package:project/screens/Article_view.dart';
import 'package:project/utils/methods.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleView(blogUrl: article.link ?? ''),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    width: MediaQuery.of(context).size.width * 0.32,
                    height: 130,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => Image.asset(
                          'assets/images/news.jpg',
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.category,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        article.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              article.sourceIcon ??
                                  'https://cdn.pixabay.com/photo/2012/04/11/12/01/display-27766_960_720.png',
                            ),
                          ),
                          const SizedBox(width: 6),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final screenWidth =
                                  MediaQuery.of(context).size.width;

                              double fontSize = screenWidth * 0.025;

                              return Text(
                                '${article.sourceName} • ${formatTimeAgo(article.pubDate)}',
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: const Color.fromARGB(187, 31, 29, 29),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
