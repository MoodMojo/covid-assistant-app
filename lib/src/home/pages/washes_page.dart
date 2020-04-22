import 'package:flutter/material.dart';

import 'package:covid_assistant_app/pages/newsListPage.dart';
import 'package:covid_assistant_app/viewmodels/newsArticleListViewModel.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: "Latest News",
        debugShowCheckedModeBanner: false,
        home:
        ChangeNotifierProvider(
            builder: (_) => NewsArticleListViewModel(),
            child: NewsListPage()
        )
    );

  }

}