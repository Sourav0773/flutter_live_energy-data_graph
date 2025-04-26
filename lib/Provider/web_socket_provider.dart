import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../Model/data_model.dart';
import '../Websocket_service/websocket_service.dart';

class WebSocketProvider with ChangeNotifier {
  final List<DataModel> _history = [];
  final List<double> _yValues = [];
  Timer? _historyTimer;
  DataModel? _latestData;
  double _xValue = 0;
  final double windowSize = 10;

  List<DataModel> get history => _history;
  DataModel? get latestData => _latestData;

  List<Map<String, double>> get spots => List.generate(_yValues.length, (index) {
        double x = _xValue - _yValues.length + index + 1;
        return {'x': x, 'y': _yValues[index]};
      });

  double get xMin => _xValue > windowSize ? _xValue - windowSize : 0;
  double get xMax => _xValue;

  WebSocketProvider() {
    _startListening();
    _startHistoryTimer();
  }

  void _startListening() {
    webSocket.stream.listen((data) {
      try {
        final decoded = jsonDecode(data.toString());
        final parsed = DataModel.fromJson(decoded);
        final y = double.tryParse(parsed.value.toString());

        if (y != null) {
          _xValue++;
          _yValues.add(y);
          if (_yValues.length > windowSize) {
            _yValues.removeAt(0);
          }

          _latestData = parsed;
          notifyListeners();
        }
      } catch (_) {}
    });
  }

  void _startHistoryTimer() {
    _historyTimer = Timer.periodic(Duration(seconds: 20), (_) {
      if (_latestData != null) {
        _history.add(_latestData!);
        if (_history.length > 100) _history.removeAt(0);
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _historyTimer?.cancel();
    super.dispose();
  }
}
