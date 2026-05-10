import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/record.dart';
import '../services/database_service.dart';
import '../services/ad_service.dart';
import 'history_screen.dart';
import 'stats_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  static const _presets = [30, 60, 90];

  int _targetSeconds = 60;
  int _elapsed = 0;
  bool _running = false;
  bool _done = false;
  Timer? _timer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;
  BannerAd? _banner;
  bool _bannerReady = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _banner = AdService.createBanner(
      onLoaded: (ad) => setState(() => _bannerReady = true),
    );
  }

  void _start() {
    setState(() {
      _elapsed = 0;
      _running = true;
      _done = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed++);
      if (_elapsed >= _targetSeconds) _finish();
    });
  }

  void _abort() {
    _timer?.cancel();
    setState(() => _running = false);
  }

  Future<void> _giveUp() async {
    _timer?.cancel();
    setState(() {
      _running = false;
      _done = true;
    });
    await DatabaseService.insert(
      Record(date: DateTime.now(), seconds: _elapsed),
    );
  }

  Future<void> _finish() async {
    _timer?.cancel();
    setState(() {
      _running = false;
      _done = true;
    });
    await DatabaseService.insert(
      Record(date: DateTime.now(), seconds: _elapsed),
    );
  }

  void _setCustom() async {
    final controller = TextEditingController();
    final result = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0A1628),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF00D4FF), width: 1),
        ),
        title: const Text('Custom Duration',
            style: TextStyle(color: Color(0xFF00D4FF))),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            suffixText: 'sec',
            suffixStyle: TextStyle(color: Color(0xFF00D4FF)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00D4FF)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB347), width: 2),
            ),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              final v = int.tryParse(controller.text);
              if (v != null && v > 0) Navigator.pop(context, v);
            },
            child: const Text('OK',
                style: TextStyle(color: Color(0xFFFFB347))),
          ),
        ],
      ),
    );
    if (result != null) setState(() => _targetSeconds = result);
  }

  int get _remaining => max(0, _targetSeconds - _elapsed);
  double get _progress => _running ? _elapsed / _targetSeconds : 0;

  String get _timeLabel {
    if (_done) return '✓';
    return _running ? '$_remaining' : '$_targetSeconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _banner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030614),
      bottomNavigationBar: _bannerReady && _banner != null
          ? SizedBox(
              height: _banner!.size.height.toDouble(),
              child: AdWidget(ad: _banner!),
            )
          : null,
      body: Stack(
        children: [
          // ── 背景：ヒーロー画像（下半分、上方向にフェード）
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
                stops: [0.0, 1.0],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/plank_hero.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // ── 背景：上部グラデーション（宇宙感）
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF030614),
                    const Color(0xFF030614).withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 0.7],
                ),
              ),
            ),
          ),

          // ── メインコンテンツ
          SafeArea(
            child: Column(
              children: [
                // AppBar 代替
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ロゴ
                      _NeonText(
                        'PLANK NOW',
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                      // ボタン群
                      Row(
                        children: [
                          _NeonIconButton(
                            icon: Icons.bar_chart,
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const StatsScreen())),
                          ),
                          const SizedBox(width: 8),
                          _NeonIconButton(
                            icon: Icons.history,
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const HistoryScreen())),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ── スローガン
                Text(
                  'DO THE PLANK RIGHT NOW',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                    color: const Color(0xFFFFB347).withValues(alpha: 0.75),
                    shadows: [
                      Shadow(
                          color: const Color(0xFFFFB347).withValues(alpha: 0.5),
                          blurRadius: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── タイマー円
                _TimerRing(
                  progress: _progress,
                  running: _running,
                  done: _done,
                  pulseAnim: _pulseAnim,
                  label: _timeLabel,
                ),

                const SizedBox(height: 36),

                // ── プリセットチップ
                if (!_running && !_done)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ..._presets.map((s) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6),
                            child: _NeonChip(
                              label: '${s}s',
                              selected: _targetSeconds == s,
                              onTap: () =>
                                  setState(() => _targetSeconds = s),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: _NeonChip(
                          label: 'Custom',
                          selected: false,
                          onTap: _setCustom,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 32),

                // ── メインボタン
                if (_running)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _MainButton(
                        label: 'ABORT',
                        color: const Color(0xFFFF4466),
                        onTap: _abort,
                      ),
                      const SizedBox(width: 16),
                      _MainButton(
                        label: 'GIVE UP',
                        color: const Color(0xFFFFB347),
                        onTap: _giveUp,
                      ),
                    ],
                  )
                else
                  _MainButton(
                    label: _done ? 'RETRY' : 'START',
                    color: const Color(0xFF00D4FF),
                    onTap: _done ? () => setState(() => _done = false) : _start,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// ネオン発光テキスト
// ─────────────────────────────────────────
class _NeonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final Color color;

  const _NeonText(
    this.text, {
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.letterSpacing = 0,
    this.color = const Color(0xFF00D4FF),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color,
        shadows: [
          Shadow(color: color.withValues(alpha: 0.9), blurRadius: 12),
          Shadow(color: color.withValues(alpha: 0.5), blurRadius: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// ネオンアイコンボタン
// ─────────────────────────────────────────
class _NeonIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NeonIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00D4FF), width: 1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF00D4FF).withValues(alpha: 0.3),
                blurRadius: 8),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF00D4FF), size: 20),
      ),
    );
  }
}

// ─────────────────────────────────────────
// タイマーリング
// ─────────────────────────────────────────
class _TimerRing extends StatelessWidget {
  final double progress;
  final bool running;
  final bool done;
  final Animation<double> pulseAnim;
  final String label;

  const _TimerRing({
    required this.progress,
    required this.running,
    required this.done,
    required this.pulseAnim,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final neon = done ? const Color(0xFFFFB347) : const Color(0xFF00D4FF);

    return AnimatedBuilder(
      animation: pulseAnim,
      builder: (context, child) {
        final glow = running ? pulseAnim.value : 0.7;
        return SizedBox(
          width: 220,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 外側グロー
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: neon.withValues(alpha: 0.15 * glow),
                      blurRadius: 40,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
              // プログレスリング
              CustomPaint(
                size: const Size(220, 220),
                painter: _RingPainter(
                  progress: progress,
                  color: neon,
                  glowOpacity: glow,
                ),
              ),
              // 内側
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: done ? 64 : 80,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: neon.withValues(alpha: 0.8 * glow),
                            blurRadius: 20),
                        Shadow(
                            color: neon.withValues(alpha: 0.4 * glow),
                            blurRadius: 40),
                      ],
                    ),
                  ),
                  if (!done)
                    Text(
                      running ? 'SEC REMAINING' : 'SECONDS',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 3,
                        color: neon.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double glowOpacity;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.glowOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const startAngle = -pi / 2;

    // ベースリング
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    if (progress <= 0) return;

    // グロープログレス（太め・ぼかし）
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * pi * progress,
      false,
      Paint()
        ..color = color.withValues(alpha: 0.4 * glowOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // シャープなプログレス
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * pi * progress,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.glowOpacity != glowOpacity;
}

// ─────────────────────────────────────────
// ネオンチップ（プリセット）
// ─────────────────────────────────────────
class _NeonChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NeonChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        selected ? const Color(0xFFFFB347) : const Color(0xFF00D4FF);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFB347).withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: selected ? 0.4 : 0.15),
              blurRadius: selected ? 12 : 6,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: color,
            shadows: [Shadow(color: color.withValues(alpha: 0.8), blurRadius: 6)],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// メインボタン
// ─────────────────────────────────────────
class _MainButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MainButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 140,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(4),
          color: color.withValues(alpha: 0.08),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 16),
            BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 32),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 4,
              color: color,
              shadows: [
                Shadow(color: color.withValues(alpha: 0.9), blurRadius: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
