import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/market_provider.dart';
import 'pages/market_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MarketProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MarketPage(),
    );
  }
}
