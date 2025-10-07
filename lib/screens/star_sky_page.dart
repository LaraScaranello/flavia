import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/star.dart';
import '../widgets/star_field_painter.dart';
import '../utils/sample_moments.dart';
import 'mini_game_page.dart';
import 'dialogs/daily_card_dialog.dart';
import 'dialogs/secret_dialog.dart';

class StarSkyPage extends StatefulWidget {
  const StarSkyPage({super.key});

  @override
  State<StarSkyPage> createState() => _StarSkyPageState();
}

class _StarSkyPageState extends State<StarSkyPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final rnd = Random();
  List<Star> stars = [];
  List<Star> starsMovement = [];
  Set<int> foundSpecial = {};
  Timer? _twinkleTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    _generateStars();
    _generateStarsMovement();
    _twinkleTimer = Timer.periodic(Duration(milliseconds: 400 + rnd.nextInt(400)), (_) => setState(() {}));
  }

  void _generateStars() {
    stars = List.generate(23, (i) {
      final pos = Offset(rnd.nextDouble(), rnd.nextDouble() * 0.8 + 0.1);
      final size = 2.5 + rnd.nextDouble() * 3.0;
      bool special = (i == 21 || i == 22 || i == 23);

      String title;
      String content;
      
      if (special) {
        title = 'Estrela secreta ${i + 1}';
        content = 'teste'; 
      
      } else {
        title = 'Momento especial ${i + 1}';
        content = sampleMoments[i % sampleMoments.length];
      }

      return Star(
        pos,
        size,
        title,
        content,
        special: special,
      );
    });
  }

  void _generateStarsMovement() {
    starsMovement = List.generate(200, (i) {
      final pos = Offset(rnd.nextDouble(), rnd.nextDouble() * 0.8 + 0.1);
      final size = 1.5 + rnd.nextDouble() * 3.0;
      final special = (i == 3 || i == 12 || i == 25 || i == 50) || i == 75;
      return Star(
        pos,
        size,
        '',
        '',
        special: special,
      );
    });
  }

  void _onStarTap(int index) async {
    final s = stars[index];
    if (s.special) {
      setState(() => foundSpecial.add(index));
      if (foundSpecial.length >= 3) {
        await showDialog(context: context, builder: (_) => SecretDialog());
        return;
      }
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F1724),
        title: Text(s.title, style: const TextStyle(color: Colors.amberAccent)),
        content: SingleChildScrollView(
          child: Text(s.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5,), textAlign: TextAlign.start)
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _twinkleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => CustomPaint(
                size: MediaQuery.of(context).size,
                painter: StarFieldPainter(starsMovement, _controller.value, rnd),
              ),
            ),
            _buildHeader(),
            _buildStarsLayer(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Positioned(
    left: 20,
    right: 20,
    top: 18,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Center(child: Text('Nosso céu de memórias', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
          SizedBox(height: 4),
          Text('Toque nas estrelas para abrir memórias',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
        ]),
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => const AboutDialog(
              children: [Text('Cada estrela esconde uma memória. Encontre as 5 especiais para sentir a magia')],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildStarsLayer() => LayoutBuilder(
    builder: (context, constraints) {
      return Stack(
        children: List.generate(stars.length, (i) {
          final s = stars[i];
          final left = s.pos.dx * constraints.maxWidth;
          final top = s.pos.dy * constraints.maxHeight;
          final visible = 0.7 + 0.3 * sin(_controller.value * 2 * pi * (1 + i % 5));
          final color =
              s.special && foundSpecial.contains(i) ? Colors.greenAccent : Colors.white;

          return Positioned(
            left: left - s.size * 2,
            top: top - s.size * 2,
            child: GestureDetector(
              onTap: () => _onStarTap(i),
              child: Opacity(
                opacity: visible,
                // ignore: deprecated_member_use
                child: Icon(Icons.star, size: s.size * 6, color: color.withOpacity(0.9)),
              ),
            ),
          );
        }),
      );
    },
  );

  Widget _buildFooter() => Positioned(
    left: 20,
    right: 20,
    bottom: 18,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.videogame_asset),
          label: const Text('Joguinho'),
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => MiniGamePage())),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.message),
          label: const Text('Carta do dia'),
          onPressed: () =>
              showDialog(context: context, builder: (_) => DailyCardDialog()),
        ),
      ],
    ),
  );
}