import 'package:flutter/material.dart';

/// Model data untuk counter
class CounterItem {
  String label;
  int value;
  Color color;

  CounterItem({required this.label, this.value = 0, required this.color});
}
