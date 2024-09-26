import 'package:flutter/material.dart';
import 'package:lingoganda_news/constants/app_colors.dart';
import 'package:lingoganda_news/models/news.dart';
import 'package:lingoganda_news/providers/news_provider.dart';
import 'package:lingoganda_news/utils/api_utils/api_response_state.dart';
import 'package:lingoganda_news/views/home/widget/news_card.dart';
import 'package:lingoganda_news/widgets/common_app_bar.dart';
import 'package:lingoganda_news/widgets/common_app_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsViewModel()..fetchArticles(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          await NewsViewModel().storeUserDetails(
            email: "123",
            username: "123",
          );
        }),
        appBar: const CommonAppBar(
          titleWidget: Text(
            "MyNews",
            style: TextStyle(
                color: AppColors.whiteColor, fontWeight: FontWeight.bold),
          ),
          trailingWidget: Icon(
            Icons.location_searching,
            color: Colors.white,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await NewsViewModel().fetchArticles();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Top Headlines",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Consumer<NewsViewModel>(
                    builder: (context, newsViewData, child) {
                  final ApiResponseState<List<Articles>> articlesState =
                      newsViewData.articles;

                  if (articlesState.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (articlesState.status == Status.completed) {
                    final List<Articles> articles = articlesState.data!;
                    return articles.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: articles.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: NewsCard(
                                      title: articles[index].source?.name ?? "",
                                      description:
                                          articles[index].description ?? "",
                                      imageUrl:
                                          articles[index].urlToImage ?? "",
                                      time: articles[index]
                                          .publishedAt
                                          .toString(),
                                    ),
                                  );
                                }))
                        : const Center(
                            child: Text("No News Found"),
                          );
                  } else if (articlesState.status == Status.error) {
                    return Column(
                      children: [
                        CommonAppButton(
                            buttonName: "Retry",
                            buttonAction: () {
                              NewsViewModel().fetchArticles();
                            }),
                        Center(child: Text('Error: ${articlesState.message}')),
                      ],
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
