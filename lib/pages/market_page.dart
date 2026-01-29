import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/StockModel.dart';
import '../providers/market_provider.dart';


class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MarketProvider>();

    final stocks = provider.stocks.values.toList()
      ..sort((a, b) => a.code.compareTo(b.code)); // 可选排序

    return Scaffold(
      appBar: AppBar(title: const Text("A股模拟行情")),
      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final StockModel stock = stocks[index];
          return ListTile(
            title: Text(stock.code),
            subtitle: Text(
                '昨收: ${stock.preClose.toStringAsFixed(2)}'), // 显示昨收价
            trailing: Text(
              stock.lastPrice.toStringAsFixed(2),
              style: TextStyle(
                color: stock.lastPrice >= stock.preClose
                    ? Colors.red
                    : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          // 订阅多股票
          provider.subscribe(['600000', '600002', '600003']);
        },
      ),
    );
  }
}
