import 'package:flutter/material.dart';
import 'package:sport_app_user/core/constants/dummy_data.dart';
import 'package:sport_app_user/core/widget/buttons/custom_tab_button.dart';
import 'package:sport_app_user/features/news/presentation/widgets/news_container.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  int selectedTab = 0;
  final today = DateTime.now();

  List<NewsModel> filteredNews = dummyNewsList.where((news) =>
  news.dateTime.year == DateTime.now().year &&
      news.dateTime.month == DateTime.now().month &&
      news.dateTime.day == DateTime.now().day).toList();

  @override
  Widget build(BuildContext context) {

    // filter

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomTabButton(
              title: 'Today',
              isSelected: selectedTab == 0,
              onTap: () {
                setState(() {
                  selectedTab = 0;
                      filteredNews=dummyNewsList.where((news) =>
                  news.dateTime.year == today.year &&
                      news.dateTime.month == today.month &&
                      news.dateTime.day == today.day).toList()
                     ;
                });
              },
            ),
            CustomTabButton(
              title: 'All',
              isSelected: selectedTab == 1,
              onTap: () {
                setState(() {
                  selectedTab = 1;
                  filteredNews=dummyNewsList;
                });
              },
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: filteredNews.isEmpty
              ? const Center(
            child: Text(
              'No news for today.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
              : ListView.builder(
            itemCount: filteredNews.length,
            itemBuilder: (context, index) {
              final newsItem = filteredNews[index];
              return NewsContainer(
                imageTitle: newsItem.imageTitle,
                description: newsItem.description,
                image: newsItem.image,
                dateTime: newsItem.dateTime,
              );
            },
          ),
        )
      ],
    );
  }

}
