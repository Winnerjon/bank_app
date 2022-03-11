import 'package:bank_app/pages/add_card_page.dart';
import 'package:bank_app/pages/card_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final RouteObserver<PageRoute> routeObserver =  RouteObserver<PageRoute>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardListPage(),
      routes: {
        CardListPage.id: (context) => CardListPage(),
        AddCardList.id: (context) => AddCardList(),
      },
      navigatorObservers: [
        routeObserver,
      ],
    );
  }
}
