class KLine {
  String code;
  double open;
  double high;
  double low;
  double close;
  int volume;
  DateTime startTime;

  KLine({
    required this.code,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.startTime,
  });
}
