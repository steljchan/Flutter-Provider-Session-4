import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/global_state.dart';
import 'widgets/counter_item.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalState(),
      child: const GlobalCounterApp(),
    ),
  );
}

class GlobalCounterApp extends StatelessWidget {
  const GlobalCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Counter App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: const GlobalCounterPage(),
    );
  }
}

class GlobalCounterPage extends StatelessWidget {
  const GlobalCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("✨ Global Counter App"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Custom background painter
          CustomPaint(painter: BackgroundPainter(), child: Container()),
          state.counters.isEmpty
              ? const Center(
                  child: Text(
                    "No counters yet. Tap + to add!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )
              : ReorderableListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: state.counters.length,
                  onReorder: state.reorder,
                  itemBuilder: (context, index) {
                    return CounterItem(
                      key: ValueKey(state.counters[index]),
                      index: index,
                    );
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => state.addCounter(),
        label: const Text("Add Counter"),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

/// Custom background painter (gelombang dekoratif)
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.teal.withValues(alpha: 0.10);
    final path = Path()
      ..lineTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height,
        size.width,
        size.height * 0.7,
      )
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
