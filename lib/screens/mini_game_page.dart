import 'dart:async';
import 'package:flutter/material.dart';

class MiniGamePage extends StatefulWidget {
  const MiniGamePage({super.key});

  @override
  State<MiniGamePage> createState() => _MiniGamePageState();
}

class _MiniGamePageState extends State<MiniGamePage> {
  int score = 0;
  int timeLeft = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) _timer?.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minijogo: Capture as Estrelas')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Toque nas estrelas que aparecem!', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text('Tempo: $timeLeft', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(8, (i) {
                final show = (i % 2 == 0) ? timeLeft % 2 == 0 : timeLeft % 3 == 0;
                return GestureDetector(
                  onTap: show && timeLeft > 0
                      ? () => setState(() => score++)
                      : null,
                  child: Icon(Icons.star, size: 40, color: show ? Colors.amber : Colors.white24),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text('Score: $score', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Voltar')),
          ],
        ),
      ),
    );
  }
}
