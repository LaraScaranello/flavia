import 'dart:math';
import 'package:flutter/material.dart';
import '../models/star.dart';

class StarFieldPainter extends CustomPainter {
  final List<Star> stars;
  final double t;
  final Random rnd;
  StarFieldPainter(this.stars, this.t, this.rnd);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final grad = RadialGradient(
      colors: [const Color(0xFF0B1020), const Color(0xFF071021)],
      radius: 0.8,
    );
    canvas.drawRect(rect, Paint()..shader = grad.createShader(rect));

    for (var i = 0; i < stars.length; i++) {
      final s = stars[i];

      // Posição flutuante
      final x = s.pos.dx * size.width + 6 * sin(t * 2 * pi * (0.2 + i % 3));
      final y = s.pos.dy * size.height + 4 * cos(t * 2 * pi * (0.1 + i % 4));

      // Opacidade piscante
      final opacity = (0.5 + 0.5 * sin((t * 2 * pi * (1 + i % 7)) + i)).clamp(0.2, 1.0);

      final paint = Paint()
        // ignore: deprecated_member_use
        ..color = Colors.white.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      // Rotação suave da estrela
      final rotation = t * 2 * pi * 0.5 * (i % 5);

      // Cria a estrela centrada em 0,0
      final starPath = createStar(Offset.zero, s.size, 5);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);
      canvas.drawPath(starPath, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Path createStar(Offset center, double radius, int points) {
  final path = Path();
  final angle = pi / points;
  for (int i = 0; i < 2 * points; i++) {
    final r = i.isEven ? radius : radius / 2;
    final x = center.dx + r * cos(i * angle - pi / 2);
    final y = center.dy + r * sin(i * angle - pi / 2);
    if (i == 0) {
      path.moveTo(x, y);
    } else {
      path.lineTo(x, y);
    }
  }
  path.close();
  return path;
}
