import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl =
      "https://newsdata.io/api/1/latest?apikey=pub_8e9c2009c12d4480b359800c2a83fc62&q=bangladesh%20all%20news";

  Future<List<Results>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = NewsModel.fromJson(jsonResponse);
        return data.results ?? [];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

class NewsModel {
  String? status;
  int? totalResults;
  List<Results>? results;
  String? nextPage;

  NewsModel({this.status, this.totalResults, this.results, this.nextPage});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    nextPage = json['nextPage'];
  }
}

class Results {
  String? articleId;
  String? title;
  String? link;
  List<String>? keywords;
  List<String>? creator;
  String? description;
  String? content;
  String? pubDate;
  String? pubDateTZ;
  String? imageUrl;
  String? videoUrl;
  String? sourceId;
  String? sourceName;
  int? sourcePriority;
  String? sourceUrl;
  String? sourceIcon;
  String? language;
  List<String>? country;
  List<String>? category;
  String? sentiment;
  String? sentimentStats;
  String? aiTag;
  String? aiRegion;
  String? aiOrg;
  String? aiSummary;
  String? aiContent;
  bool? duplicate;

  Results({
    this.articleId,
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.description,
    this.content,
    this.pubDate,
    this.pubDateTZ,
    this.imageUrl,
    this.videoUrl,
    this.sourceId,
    this.sourceName,
    this.sourcePriority,
    this.sourceUrl,
    this.sourceIcon,
    this.language,
    this.country,
    this.category,
    this.sentiment,
    this.sentimentStats,
    this.aiTag,
    this.aiRegion,
    this.aiOrg,
    this.aiSummary,
    this.aiContent,
    this.duplicate,
  });

  Results.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    link = json['link'];
    keywords =
        (json['keywords'] != null) ? List<String>.from(json['keywords']) : [];
    creator =
        (json['creator'] != null) ? List<String>.from(json['creator']) : [];
    description = json['description'];
    content = json['content'];
    pubDate = json['pubDate'];
    pubDateTZ = json['pubDateTZ'];
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    sourceId = json['source_id'];
    sourceName = json['source_name'];
    sourcePriority = json['source_priority'];
    sourceUrl = json['source_url'];
    sourceIcon = json['source_icon'];
    language = json['language'];
    country =
        (json['country'] != null) ? List<String>.from(json['country']) : [];
    category =
        (json['category'] != null) ? List<String>.from(json['category']) : [];
    sentiment = json['sentiment'];
    sentimentStats = json['sentiment_stats'];
    aiTag = json['ai_tag'];
    aiRegion = json['ai_region'];
    aiOrg = json['ai_org'];
    aiSummary = json['ai_summary'];
    aiContent = json['ai_content'];
    duplicate = json['duplicate'];
  }
}
