import 'package:flutter/material.dart';
import '../models/counter_model.dart';

class GlobalState extends ChangeNotifier {
  final List<CounterModel> _counters = [];

  List<CounterModel> get counters => _counters;

  void addCounter() {
    final List<Color> softColors = [
      Colors.teal.shade200,
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.purple.shade200,
      Colors.orange.shade200,
      Colors.pink.shade200,
      Colors.indigo.shade200,
      Colors.cyan.shade200,
      Colors.amber.shade200,
    ];

    final color = softColors[_counters.length % softColors.length];

    _counters.add(
      CounterModel(label: "Counter ${_counters.length + 1}", color: color),
    );
    notifyListeners();
  }

  void removeCounter(int index) {
    _counters.removeAt(index);
    notifyListeners();
  }

  void increment(int index) {
    _counters[index].value++;
    notifyListeners();
  }

  void decrement(int index) {
    if (_counters[index].value > 0) {
      _counters[index].value--;
      notifyListeners();
    }
  }

  void changeLabel(int index, String newLabel) {
    _counters[index].label = newLabel;
    notifyListeners();
  }

  void changeColor(int index, Color newColor) {
    _counters[index].color = newColor;
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _counters.removeAt(oldIndex);
    _counters.insert(newIndex, item);
    notifyListeners();
  }
}
