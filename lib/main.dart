
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const ink = Color(0xFF292333);
const plum = Color(0xFF70558F);
const muted = Color(0xFF898392);
const paper = Color(0xFFF8F6F2);
const lavender = Color(0xFFEAE3F3);

const wheelColors = [
  Color(0xFF70558F),
  Color(0xFFE9DFD1),
  Color(0xFFA5B49A),
  Color(0xFFF0C9B7),
  Color(0xFFB9ACD1),
  Color(0xFFD7DFD0),
  Color(0xFFC28D83),
  Color(0xFFF0E8DE),
];

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WheelState(),
      child: const SpinTheWheelApp(),
    ),
  );
}

class WheelState extends ChangeNotifier {
  final List<String> options = [
    'Pizza',
    'Burger',
    'Biryani',
    'Noodles',
    'Sushi',
    'Tacos',
  ];

  String? winner;
  bool isSpinning = false;

  bool addOption(String value) {
    final item = value.trim();
    if (item.isEmpty ||
        options.any((e) => e.toLowerCase() == item.toLowerCase())) {
      return false;
    }
    options.add(item);
    notifyListeners();
    return true;
  }

  void removeOption(String item) {
    if (options.length <= 2) return;
    options.remove(item);
    if (winner == item) winner = null;
    notifyListeners();
  }

  Future<String?> spin() async {
    if (isSpinning || options.length < 2) return null;
    isSpinning = true;
    winner = null;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 3600));

    winner = options[math.Random().nextInt(options.length)];
    isSpinning = false;
    notifyListeners();
    return winner;
  }
}

class SpinTheWheelApp extends StatelessWidget {
  const SpinTheWheelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spin the Wheel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(seedColor: plum),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: paper,
          foregroundColor: ink,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFEAE5E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFEAE5E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: plum, width: 1.5),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final input = TextEditingController();
  late final AnimationController rotation;

  @override
  void initState() {
    super.initState();
    rotation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    );
  }

  @override
  void dispose() {
    rotation.dispose();
    input.dispose();
    super.dispose();
  }

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  void addChoice() {
    final value = input.text.trim();
    if (value.isEmpty) {
      message('Type a choice first.');
      return;
    }

    final added = context.read<WheelState>().addOption(value);
    if (added) {
      input.clear();
      FocusScope.of(context).unfocus();
      message('$value added to your wheel');
    } else {
      message('That choice already exists.');
    }
  }

  Future<void> spinWheel() async {
    final state = context.read<WheelState>();
    if (state.isSpinning) return;

    rotation.forward(from: 0);
    final result = await state.spin();

    if (!mounted) return;
    if (result != null) {
      message('The universe picked $result ✨');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WheelState>();
    final width = MediaQuery.of(context).size.width;
    final wide = width >= 760;
    final wheelSize = math.min(wide ? 330.0 : width * 0.76, 330.0);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 76,
        titleSpacing: 24,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: plum,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.casino_rounded,
                color: Colors.white,
                size: 23,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'little decisions',
                  style: TextStyle(
                    color: ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                  ),
                ),
                Text(
                  'SPIN THE WHEEL',
                  style: TextStyle(
                    color: muted,
                    fontSize: 9,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              tooltip: 'Manage choices',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OptionsScreen(),
                ),
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: ink,
              ),
              icon: const Icon(Icons.tune_rounded),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _wheelPanel(state, wheelSize),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 5,
                          child: _choicesPanel(state),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _wheelPanel(state, wheelSize),
                        const SizedBox(height: 22),
                        _choicesPanel(state),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wheelPanel(WheelState state, double size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFEFEAE4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C292333),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: lavender.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'YOUR DAILY DILEMMA',
              style: TextStyle(
                color: plum,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 13),
          const Text(
            'Can’t decide?',
            style: TextStyle(
              color: ink,
              fontSize: 29,
              height: 1.1,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.1,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Leave it to a little luck.',
            style: TextStyle(color: muted, fontSize: 14),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: size,
            height: size + 17,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 13,
                  child: AnimatedBuilder(
                    animation: rotation,
                    builder: (context, child) => Transform.rotate(
                      angle: rotation.value * math.pi * 10,
                      child: child,
                    ),
                    child: Container(
                      width: size,
                      height: size,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEE8F4),
                        shape: BoxShape.circle,
                      ),
                      child: CustomPaint(
                        painter: WheelPainter(state.options),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE8E0EF)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x18292333),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_downward_rounded,
                    color: plum,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: state.isSpinning ? null : spinWheel,
              style: FilledButton.styleFrom(
                backgroundColor: plum,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    state.isSpinning
                        ? Icons.hourglass_top_rounded
                        : Icons.casino_rounded,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    state.isSpinning ? 'SPINNING...' : 'MAKE THE CHOICE',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${state.options.length} choices • one decision',
            style: const TextStyle(color: muted, fontSize: 12),
          ),
          if (state.winner != null) ...[
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDE6),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Text(
                    'THE CHOICE IS...',
                    style: TextStyle(
                      color: muted,
                      fontSize: 10,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    state.winner!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ink,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _choicesPanel(WheelState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFF0ECE7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE8E1D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'On the table',
                  style: TextStyle(
                    color: ink,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Text(
                '${state.options.length}',
                style: const TextStyle(
                  color: plum,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'Add the possibilities. We’ll pick one.',
            style: TextStyle(color: muted, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: input,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => addChoice(),
                  decoration: const InputDecoration(
                    hintText: 'e.g. Sushi',
                    prefixIcon: Icon(Icons.add_rounded),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              SizedBox(
                height: 54,
                width: 54,
                child: FilledButton(
                  onPressed: addChoice,
                  style: FilledButton.styleFrom(
                    backgroundColor: ink,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Icon(Icons.add_rounded),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          for (int i = 0; i < state.options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  dense: true,
                  leading: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: wheelColors[i % wheelColors.length]
                          .withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      _foodIcon(state.options[i]),
                      color: ink,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    state.options[i],
                    style: const TextStyle(
                      color: ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Remove ${state.options[i]}',
                    onPressed: state.options.length <= 2
                        ? null
                        : () => state.removeOption(state.options[i]),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: muted,
                      size: 19,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFDDD5CC)),
          const SizedBox(height: 8),
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SuggestionScreen(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: lavender,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: plum,
                    ),
                  ),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need inspiration?',
                          style: TextStyle(
                            color: ink,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Get a suggestion online',
                          style: TextStyle(color: muted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

IconData _foodIcon(String value) {
  final text = value.toLowerCase();
  if (text.contains('pizza')) return Icons.local_pizza_rounded;
  if (text.contains('burger')) return Icons.lunch_dining_rounded;
  if (text.contains('noodle') || text.contains('pasta')) {
    return Icons.ramen_dining_rounded;
  }
  if (text.contains('sushi')) return Icons.set_meal_rounded;
  if (text.contains('biryani') || text.contains('rice')) {
    return Icons.rice_bowl_rounded;
  }
  if (text.contains('taco')) return Icons.restaurant_rounded;
  return Icons.restaurant_menu_rounded;
}

class WheelPainter extends CustomPainter {
  final List<String> options;

  WheelPainter(this.options);

  @override
  void paint(Canvas canvas, Size size) {
    if (options.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final slice = 2 * math.pi / options.length;

    for (int i = 0; i < options.length; i++) {
      final start = -math.pi / 2 + i * slice;
      canvas.drawArc(
        rect,
        start,
        slice,
        true,
        Paint()..color = wheelColors[i % wheelColors.length],
      );

      canvas.drawLine(
        center,
        Offset(
          center.dx + radius * math.cos(start),
          center.dy + radius * math.sin(start),
        ),
        Paint()
          ..color = Colors.white.withValues(alpha: 0.8)
          ..strokeWidth = 2,
      );

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(start + slice / 2);

      final textPainter = TextPainter(
        text: TextSpan(
          text: options[i],
          style: TextStyle(
            color: i % wheelColors.length == 0 ||
                    i % wheelColors.length == 4 ||
                    i % wheelColors.length == 6
                ? Colors.white
                : ink,
            fontSize: math.min(14.0, 108.0 / options.length + 3),
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: radius * 0.66);

      textPainter.paint(
        canvas,
        Offset(radius * 0.25, -textPainter.height / 2),
      );
      canvas.restore();
    }

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    canvas.drawCircle(
      center,
      radius * 0.105,
      Paint()..color = Colors.white,
    );

    canvas.drawCircle(
      center,
      radius * 0.055,
      Paint()..color = plum,
    );
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) {
    return oldDelegate.options != options;
  }
}

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WheelState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your choices')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Edit the wheel',
            style: TextStyle(
              color: ink,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Keep at least two choices so the wheel has a decision to make.',
            style: TextStyle(color: muted),
          ),
          const SizedBox(height: 20),
          for (final option in state.options)
            Card(
              color: Colors.white,
              elevation: 0,
              child: ListTile(
                leading: const Icon(
                  Icons.circle_outlined,
                  color: plum,
                ),
                title: Text(option),
                trailing: IconButton(
                  tooltip: 'Remove $option',
                  onPressed: state.options.length <= 2
                      ? null
                      : () => state.removeOption(option),
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  bool loading = false;
  String? result;
  String? error;

  Future<void> fetchSuggestion() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final response = await http
          .get(
            Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception('Server error ${response.statusCode}');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (!mounted) return;
      setState(() {
        result = data['title'] as String? ?? 'No suggestion available';
      });
    } on TimeoutException {
      if (!mounted) return;
      setState(() => error = 'The request timed out. Try again.');
    } catch (_) {
      if (!mounted) return;
      setState(() => error = 'Could not connect. Check your internet.');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A little inspiration')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFEFEAE4)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: lavender,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: plum,
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'A random little idea',
                    style: TextStyle(
                      color: ink,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    loading
                        ? 'Finding something for you...'
                        : error ?? result ??
                            'Tap below to fetch a suggestion from the web.',
                    style: const TextStyle(color: muted, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  if (loading) ...[
                    const SizedBox(height: 18),
                    const CircularProgressIndicator(),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: loading ? null : fetchSuggestion,
                      style: FilledButton.styleFrom(
                        backgroundColor: plum,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                      ),
                      child: const Text('GET A SUGGESTION'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

