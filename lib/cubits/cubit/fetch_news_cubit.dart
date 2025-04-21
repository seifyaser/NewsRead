import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:project/models/newsarticle.dart';
import 'package:project/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fetch_news_state.dart';

class FetchNewsCubitCubit extends Cubit<FetchNewsCubitState> {
  FetchNewsCubitCubit() : super(FetchNewsCubitInitial());
  final ApiService apiService = ApiService();
  List<NewsArticle> articles = [];
  List<NewsArticle> categorynews = [];

  Future<void> fetchNews() async {
    try {
      emit(FetchNewsCubitLoading());
      print("⌛ جاري تحميل الأخبار...");

      // 1. استرجاع الدولة المختارة
      final prefs = await SharedPreferences.getInstance();
      String country = prefs.getString('country_code') ?? 'us';

      // 2. استخدام الدولة في رابط الـ API
      String url =
          'https://newsdata.io/api/1/latest?country=$country&apikey=pub_79156c50e012123c1e5065f22425020d7f96d';

      var response = await Dio().get(url);
      print("✅ تم استلام الاستجابة: ${response.statusCode}");

      if (response.data['status'] == 'success') {
        articles =
            (response.data['results'] as List)
                .where(
                  (element) =>
                      element['image_url'] != null &&
                      element['description'] != null,
                )
                .map(
                  (element) => NewsArticle(
                    title: element['title'] ?? '',
                    link: element['link'] ?? '',
                    description: element['description'] ?? '',
                    imageUrl: element['image_url'] ?? '',
                    pubDate: DateTime.parse(element['pubDate'] ?? ''),
                    sourceIcon: element['source_icon'] ?? '',
                    sourceName: element['source_name'] ?? '',
                    category: (element['category'] as List).join(', '),
                  ),
                )
                .toList();

        print("✅ عدد الأخبار المحملة: ${articles.length} مقال");
        emit(FetchNewsCubitSuccess(articles: articles));
      } else {
        emit(FetchNewsCubitError("❌ فشل تحميل الأخبار!"));
      }
    } catch (e) {
      print("❌ حدث خطأ أثناء جلب الأخبار: $e");
      emit(FetchNewsCubitError("❌ حدث خطأ أثناء جلب الأخبار: $e"));
    }
  }

  void CategoryNewsService(String category) async {
    emit(FetchNewsCubitLoading());

    try {
      // جلب الدولة المختارة من SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String country = prefs.getString('country_code') ?? 'us';

      // إنشاء رابط الطلب مع الدولة المختارة
      String url =
          'https://newsdata.io/api/1/latest?country=$country&category=$category&apikey=pub_79156c50e012123c1e5065f22425020d7f96d';

      Response response = await apiService.getData(url);

      if (response.data['status'] == 'success') {
        categorynews =
            (response.data['results'] as List)
                .where(
                  (element) =>
                      element['image_url'] != null &&
                      element['description'] != null,
                )
                .map(
                  (element) => NewsArticle(
                    title: element['title'] ?? '',
                    link: element['link'] ?? '',
                    description: element['description'] ?? '',
                    imageUrl: element['image_url'] ?? '',
                    pubDate: DateTime.parse(element['pubDate'] ?? ''),
                    sourceIcon: element['source_icon'] ?? '',
                    sourceName: element['source_name'] ?? '',
                    category: (element['category'] as List).join(', '),
                  ),
                )
                .toList();

        print("✅ الأخبار حسب التصنيف: ${categorynews.length} مقال");
        emit(FetchNewsCubitSuccess(CategoriesNews: categorynews));
      } else {
        emit(FetchNewsCubitError("❌ فشل تحميل الأخبار!"));
      }
    } catch (e) {
      print("❌ حدث خطأ أثناء جلب الأخبار: $e");
      emit(FetchNewsCubitError("❌ حدث خطأ أثناء جلب الأخبار: $e"));
    }
  }
}
