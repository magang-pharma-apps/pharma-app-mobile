import 'package:flutter/material.dart';

enum LastOpnameStatus {
  notStarted,
  done,
}

extension StatusOpnameExtension on LastOpnameStatus {
  BoxDecoration get boxDecoration {
    switch (this) {
      case LastOpnameStatus.notStarted:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.shade100,
        );
      case LastOpnameStatus.done:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.shade100,
        );
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case LastOpnameStatus.notStarted:
        return TextStyle(
          color: Colors.red.shade700,
          fontSize: 10,
        );
      case LastOpnameStatus.done:
        return TextStyle(
          color: Colors.green.shade700,
          fontSize: 10,
        );
    }
  }

  String get text {
    switch (this) {
      case LastOpnameStatus.notStarted:
        return 'Belum Opname';
      case LastOpnameStatus.done:
        return 'Sudah Opname';
    }
  }
}
