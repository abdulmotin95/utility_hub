import 'package:flutter/material.dart';
import '../api_service/news_api_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Results> articles = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  final Color backgroundColor = const Color(0xFFF7F8FA);

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {
    setState(() => isLoading = true);
    articles = await apiService.fetchNews();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Latest News"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : articles.isEmpty
              ? const Center(child: Text("No news found"))
              : RefreshIndicator(
                onRefresh: loadNews,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    var article = articles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: backgroundColor,
                      elevation: 2,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article.imageUrl != null &&
                                article.imageUrl!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article.imageUrl!,
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                ),
                              ),
                            const SizedBox(height: 10),
                            Text(
                              article.title ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              article.description ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (article.sourceName != null)
                              Text(
                                "Source: ${article.sourceName}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black45,
                                ),
                              ),
                            const SizedBox(height: 5),
                            if (article.pubDate != null)
                              Text(
                                "Published: ${article.pubDate}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black38,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
