import 'package:flutter/material.dart';

class CounterModel {
  String label;
  int value;
  Color color;

  CounterModel({required this.label, this.value = 0, required this.color});
}
