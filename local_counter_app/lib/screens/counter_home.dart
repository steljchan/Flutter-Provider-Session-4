import 'dart:math';
import 'package:flutter/material.dart';
import '../models/counter_item.dart';
import '../widgets/counter_card.dart';

/// Halaman utama yang mengelola list Counter (StatefulWidget)
class CounterHomePage extends StatefulWidget {
  const CounterHomePage({super.key});

  @override
  State<CounterHomePage> createState() => _CounterHomePageState();
}

class _CounterHomePageState extends State<CounterHomePage> {
  final List<CounterItem> counters = [
    CounterItem(label: "Counter 1", value: 0, color: Colors.blue),
    CounterItem(label: "Counter 2", value: 0, color: Colors.green),
  ];

  void _addCounter() {
    final randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    setState(() {
      counters.add(
        CounterItem(
          label: "Counter ${counters.length + 1}",
          color: randomColor,
        ),
      );
    });
  }

  void _editCounter(CounterItem item) {
    final controller = TextEditingController(text: item.label);
    Color selectedColor = item.color;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Counter"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Label"),
            ),
            const SizedBox(height: 10),
            Wrap(
              children: Colors.primaries
                  .map(
                    (c) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = c;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedColor == c
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                item.label = controller.text;
                item.color = selectedColor;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Advanced Counter App")),
      body: ReorderableListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (int index = 0; index < counters.length; index++)
            CounterCard(
              key: ValueKey(counters[index]),
              counter: counters[index],
              onDecrement: () {
                setState(() {
                  if (counters[index].value > 0) counters[index].value--;
                });
              },
              onIncrement: () {
                setState(() {
                  counters[index].value++;
                });
              },
              onEdit: () => _editCounter(counters[index]),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = counters.removeAt(oldIndex);
            counters.insert(newIndex, item);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
