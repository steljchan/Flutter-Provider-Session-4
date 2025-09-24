import 'package:flutter/material.dart';
import '../models/counter_item.dart';

/// Widget Stateful untuk menampilkan 1 Counter
class CounterCard extends StatefulWidget {
  final CounterItem counter;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onEdit;

  const CounterCard({
    super.key,
    required this.counter,
    required this.onIncrement,
    required this.onDecrement,
    required this.onEdit,
  });

  @override
  State<CounterCard> createState() => _CounterCardState();
}

class _CounterCardState extends State<CounterCard> {
  /// Helper untuk membuat warna pastel
  Color makePastel(Color color) {
    return Color.alphaBlend(color.withValues(alpha: 0.5), Colors.white);
  }

  /// Daftar warna pilihan (pastel style)
  final List<Color> presetColors = [
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.brown,
  ];

  /// Dialog edit warna
  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih Warna"),
          content: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: presetColors.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.counter.color = color; // update warna counter
                  });
                  Navigator.pop(context); // tutup dialog
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: makePastel(color),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: (widget.counter.color == color)
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // ganti warna jadi pastel
      color: makePastel(widget.counter.color),
      child: ListTile(
        title: Text(
          widget.counter.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) =>
              ScaleTransition(scale: anim, child: child),
          child: Text(
            "${widget.counter.value}",
            key: ValueKey<int>(widget.counter.value),
            style: const TextStyle(fontSize: 24),
          ),
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: widget.onDecrement,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: widget.onIncrement,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _pickColor, // ganti ke color picker
            ),
          ],
        ),
      ),
    );
  }
}
