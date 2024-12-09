import 'package:flutter/material.dart';

enum StandartStock { empty, low, available }

extension StandartStockExtension on StandartStock {
  Color get color {
    switch (this) {
      case StandartStock.empty:
        return Colors.red.shade800;
      case StandartStock.low:
        return Colors.orange;
      case StandartStock.available:
        return Colors.blue.shade800;
      default:
        return Colors.blue.shade800;
    }
  }

  int get value {
    switch (this) {
      case StandartStock.empty:
        return 0;
      case StandartStock.low:
        return 15;
      case StandartStock.available:
        return 16;
      default:
        return 0;
    }
  }

  StandartStock getValue(int value) {
    if (value == 0) {
      return StandartStock.empty;
    } else if (value <= 15) {
      return StandartStock.low;
    } else {
      return StandartStock.available;
    }
  }
}
