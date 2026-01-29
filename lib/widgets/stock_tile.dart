import 'package:flutter/material.dart';

class StockTile extends StatelessWidget {
  final String code;
  final double price;
  final double lastPrice;

  StockTile({required this.code, required this.price, required this.lastPrice});

  @override
  Widget build(BuildContext context) {
    Color priceColor = price > lastPrice
        ? Colors.red
        : price < lastPrice
        ? Colors.green
        : Colors.black;

    return ListTile(
      title: Text(code),
      trailing: Text(
        price.toStringAsFixed(2),
        style: TextStyle(color: priceColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
