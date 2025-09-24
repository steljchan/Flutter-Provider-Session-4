import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/global_state.dart';

class CounterItem extends StatelessWidget {
  final int index;

  const CounterItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GlobalState>(context);
    final counter = state.counters[index];

    return Card(
      key: ValueKey(counter),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _showEditDialog(context, state, index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                // Ganti withOpacity -> withValues(alpha: ...)
                counter.color.withValues(alpha: 0.40),
                counter.color.withValues(alpha: 0.60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () => state.decrement(index),
              ),
              Expanded(
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Text(
                      "${counter.label}: ${counter.value}",
                      key: ValueKey(counter.value),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () => state.increment(index),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white70),
                onPressed: () => state.removeCounter(index),
                tooltip: "Delete counter",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, GlobalState state, int index) {
    final controller = TextEditingController(text: state.counters[index].label);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Edit Counter"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Label",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              children: Colors.primaries.map((c) {
                return GestureDetector(
                  onTap: () {
                    // juga ganti preview ke withValues:
                    state.changeColor(index, c.withValues(alpha: 0.6));
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: c.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              state.changeLabel(index, controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
