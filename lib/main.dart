import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid_assistant_app/src/global_blocs/app_bloc.dart';
import 'package:covid_assistant_app/src/global_blocs/auth/auth.dart';
import 'package:covid_assistant_app/src/global_blocs/theme_changer.dart';
import 'package:covid_assistant_app/src/root_page.dart';

void main() => runApp(covidassistantApp());

final lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  accentColor: Colors.pink,
  primaryIconTheme: IconThemeData(color: Colors.black),
);

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  accentColor: Colors.pink,
  primaryIconTheme: IconThemeData(color: Colors.white),
);

class covidassistantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(
          builder: (_) => Auth(),
        ),
        Provider<AppBloc>(
          builder: (_) => AppBloc(),
          dispose: (_, appBloc) => appBloc.dispose(),
        ),
        ChangeNotifierProvider<ThemeChanger>(
          builder: (_) => ThemeChanger(),
        ),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID Assistant',
      theme: themeChanger.theme,
      home: RootPage(),
    );
  }
}
