import 'package:flutter/material.dart';

class SecretDialog extends StatelessWidget {
  const SecretDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF071021),
      title: const Text('Segredo', style: TextStyle(color: Colors.amberAccent)),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Você encontrou as três estrelas especiais.\n', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text('"Eu te amo mais do que imaginei ser capaz."',
              style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w600)),
        ],
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
    );
  }
}
