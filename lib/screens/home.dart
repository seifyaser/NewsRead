import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/components/customappbar.dart';
import 'package:project/components/newscard.dart';
import 'package:project/components/noInternetWidget.dart';
import 'package:project/cubits/cubit/fetch_news_cubit.dart';
import 'package:project/models/newsarticle.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: RefreshIndicator(
        onRefresh:
            () => BlocProvider.of<FetchNewsCubitCubit>(context).fetchNews(),
        child: ListView(
          children: [
            BlocBuilder<FetchNewsCubitCubit, FetchNewsCubitState>(
              builder: (context, state) {
                if (state is FetchNewsCubitLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else if (state is FetchNewsCubitError) {
                  if (state.message.toLowerCase().contains(
                        'failed host lookup',
                      ) ||
                      state.message.toLowerCase().contains('socketexception') ||
                      state.message.toLowerCase().contains(
                        'connection error',
                      )) {
                    return noInternetWidget();
                  }
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is FetchNewsCubitSuccess) {
                  List<NewsArticle>? articles = state.articles;

                  if (articles == null || articles.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return NewsCard(article: articles[index]);
                    },
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
