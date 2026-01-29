
class StockModel {
  final String code;
  double lastPrice;
  double preClose;

  StockModel({
    required this.code,
    this.lastPrice = 0,
    this.preClose = 0,
  });

  double get changePercent =>
      preClose == 0 ? 0 : (lastPrice - preClose) / preClose * 100;
}
