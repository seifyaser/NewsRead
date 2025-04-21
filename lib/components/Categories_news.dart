import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/components/customappbar.dart';
import 'package:project/components/newscard.dart';
import 'package:project/cubits/cubit/fetch_news_cubit.dart';
import 'package:project/models/newsarticle.dart';

class CategoriesNews extends StatelessWidget {
  const CategoriesNews({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNewsCubitCubit()..CategoryNewsService(category),
      child: Scaffold(
        appBar: CustomAppBar(),
        body: BlocBuilder<FetchNewsCubitCubit, FetchNewsCubitState>(
          builder: (context, state) {
            if (state is FetchNewsCubitLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else if (state is FetchNewsCubitError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is FetchNewsCubitSuccess) {
              List<NewsArticle>? categorynews  = state.CategoriesNews;
              if (categorynews == null || categorynews.isEmpty) {
                return const Center(child: Text('No data available'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(article: categorynews[index]);
                },
                itemCount: categorynews.length,
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
