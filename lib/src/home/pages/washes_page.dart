import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:covid_assistant_app/pages/newsListPage.dart';
import 'package:covid_assistant_app/viewmodels/newsArticleListViewModel.dart';
import 'package:provider/provider.dart';

class CupsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: "Latest News",
        home:
        ChangeNotifierProvider(
            builder: (_) => NewsArticleListViewModel(),
            child: NewsListPage()
        )
    );

  }

}