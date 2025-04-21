part of 'fetch_news_cubit.dart';

@immutable
sealed class FetchNewsCubitState {}

final class FetchNewsCubitInitial extends FetchNewsCubitState {}
final class FetchNewsCubitLoading extends FetchNewsCubitState {}
final class FetchNewsCubitSuccess extends FetchNewsCubitState {
   final List<NewsArticle>? articles;
final List<NewsArticle>? CategoriesNews;
  FetchNewsCubitSuccess({this.CategoriesNews,this.articles,});
}
final class FetchNewsCubitError extends FetchNewsCubitState {
  final String message;

  FetchNewsCubitError(this.message);
}
