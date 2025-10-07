import 'dart:math';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class DailyCardDialog extends StatelessWidget {
  final List<String> cards = [
    'Você é meu ponto de paz.',
    'Gosto do seu riso bobo.',
    'Obrigado por ficar.',
    'Hoje eu pensarei em você.'
  ];

  @override
  Widget build(BuildContext context) {
    final card = cards[Random().nextInt(cards.length)];
    return AlertDialog(
      backgroundColor: const Color(0xFF0F1724),
      content: Text(card, style: const TextStyle(color: Colors.white70, fontSize: 16)),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
    );
  }
}
