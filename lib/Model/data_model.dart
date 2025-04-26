import 'package:decimal/decimal.dart';

class DataModel {
  final DateTime timestamp;
  final Decimal value;

  DataModel({
    required this.timestamp,
    required this.value,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      timestamp: DateTime.parse(json['timestamp']),
      value: Decimal.parse(json['value'].toString()),
    );
  }
}
