import 'package:flutter/material.dart';

enum ExpiryStandard { expired, nearExpiry, notExpired }

extension ExpiryStandardExtension on DateTime {
  /// Determine the expiry status based on the difference in days.
  ExpiryStandard get expiryStandard {
    final currentDate = DateTime.now();
    final differenceInDays = difference(currentDate).inDays;

    if (differenceInDays < 0) {
      return ExpiryStandard.expired;
    } else if (differenceInDays <= 30) {
      return ExpiryStandard.nearExpiry;
    } else {
      return ExpiryStandard.notExpired;
    }
  }

  /// Get color based on the expiry status.
  Color get expiryColor {
    switch (expiryStandard) {
      case ExpiryStandard.expired:
        return Colors.red.shade800;
      case ExpiryStandard.nearExpiry:
        return Colors.orange;
      case ExpiryStandard.notExpired:
        return Colors.blue.shade800;
    }
  }

  /// Get a description based on the expiry status.
  String get expiryDescription {
    switch (expiryStandard) {
      case ExpiryStandard.expired:
        return "Expired";
      case ExpiryStandard.nearExpiry:
        return "Near Expiry";
      case ExpiryStandard.notExpired:
        return "Not Expired";
    }
  }
}
