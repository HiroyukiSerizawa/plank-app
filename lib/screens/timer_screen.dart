import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../l10n/app_localizations.dart';
import '../models/record.dart';
import '../services/database_service.dart';
import '../services/ad_service.dart';
import '../services/haptic_service.dart';
import '../services/sound_service.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  static const _presets = [30, 60, 90];

  // Pre-roll length in seconds. The spec is fixed at 3-2-1 → GO!.
  static const _prepSeconds = 3;

  int _targetSeconds = 60;
  int _elapsed = 0;
  bool _running = false;
  bool _done = false;

  // Pre-roll state. While prepping, the main timer is not running yet —
  // `_elapsed` stays 0 and the ring shows the prep countdown.
  bool _prepping = false;
  int _prepRemaining = 0;

  // Consecutive recording days. Loaded from DB and refreshed after each
  // completed/given-up session.
  int _streak = 0;

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
    _loadStreak();
  }

  Future<void> _loadStreak() async {
    // Defensive: tolerate DB initialization failures (e.g. widget tests where
    // sqflite_common_ffi isn't wired). The streak badge is purely cosmetic
    // and should never crash the home screen.
    try {
      final value = await DatabaseService.getStreak();
      if (mounted) setState(() => _streak = value);
    } catch (_) {
      // Leave streak at 0.
    }
  }

  void _start() {
    // Reset any in-flight timer/audio before entering pre-roll. Guards against
    // rapid Start/Abort re-taps (test #13).
    _timer?.cancel();
    SoundService.instance.stopAll();

    // Keep the screen on across pre-roll + plank — device screen-off timeout
    // (often 30s) would otherwise blank the timer mid-hold.
    WakelockPlus.enable();

    // When the user has disabled BOTH sound AND vibration, skip the pre-roll
    // entirely and preserve the v1.0.3 tap-to-go UX. A silent 3-second prep
    // with no feedback would look broken. If either feedback channel is on,
    // we still run the prep so the user gets their countdown cue.
    final hasAnyFeedback = SoundService.instance.enabled ||
        HapticService.instance.enabled;
    if (!hasAnyFeedback) {
      setState(() {
        _elapsed = 0;
        _done = false;
        _prepping = false;
      });
      _startRunning();
      return;
    }

    setState(() {
      _elapsed = 0;
      _running = false;
      _done = false;
      _prepping = true;
      _prepRemaining = _prepSeconds;
    });
    // Fire the first SFX/haptic on entry; the periodic timer below handles
    // the remaining beats (2 and 1).
    SoundService.instance.play('$_prepSeconds.mp3');
    HapticService.instance.tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final next = _prepRemaining - 1;
      if (next > 0) {
        setState(() => _prepRemaining = next);
        SoundService.instance.play('$next.mp3');
        HapticService.instance.tick();
      } else {
        t.cancel();
        SoundService.instance.play('go.mp3');
        HapticService.instance.hit();
        _startRunning();
      }
    });
  }

  void _startRunning() {
    setState(() {
      _prepping = false;
      _running = true;
      _elapsed = 0;
    });
    // Beat #1 aligned with the GO! cue (T=0 of the running phase).
    // Without this the periodic tick below wouldn't fire until T=1, leaving
    // a one-second silent gap between GO! and the first body tick that the
    // user perceives as broken rhythm.
    SoundService.instance.playTick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final next = _elapsed + 1;
      setState(() => _elapsed = next);
      final remaining = _targetSeconds - next;
      if (_targetSeconds >= 5 && remaining >= 1 && remaining <= 5) {
        // End-of-session countdown: 5 → 1 (only when the target is long enough
        // to fit it; sub-5s sessions skip the countdown — spec test #18).
        // The countdown voice takes precedence over the tick so the two
        // cues don't collide.
        SoundService.instance.play('$remaining.mp3');
        HapticService.instance.tick();
      } else if (remaining >= 1) {
        // Body of the plank: a soft per-second tick to fill the silence
        // between the GO! and the final countdown. Skipped on the last beat
        // (remaining == 0) — that slot belongs to done.mp3 in _finish().
        SoundService.instance.playTick();
      }
      if (next >= _targetSeconds) _finish();
    });
  }

  void _abort() {
    _timer?.cancel();
    SoundService.instance.stopAll();
    WakelockPlus.disable();
    setState(() {
      _running = false;
      _prepping = false;
    });
  }

  Future<void> _giveUp() async {
    // Early termination: record the elapsed seconds but stay silent
    // (no Done! — that cue is reserved for completing the target — test #14).
    _timer?.cancel();
    SoundService.instance.stopAll();
    await WakelockPlus.disable();
    setState(() {
      _running = false;
      _done = true;
    });
    await DatabaseService.insert(
      Record(date: DateTime.now(), seconds: _elapsed),
    );
    await _loadStreak();
  }

  Future<void> _finish() async {
    _timer?.cancel();
    SoundService.instance.play('done.mp3');
    HapticService.instance.hit();
    await WakelockPlus.disable();
    setState(() {
      _running = false;
      _done = true;
    });
    await DatabaseService.insert(
      Record(date: DateTime.now(), seconds: _elapsed),
    );
    await _loadStreak();
  }

  void _setCustom() async {
    final controller = TextEditingController();
    final l10n = AppLocalizations.of(context);
    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF0A1628),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF00D4FF), width: 1),
        ),
        title: Text(l10n.customDurationTitle,
            style: const TextStyle(color: Color(0xFF00D4FF))),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            suffixText: l10n.secInputSuffix,
            suffixStyle: const TextStyle(color: Color(0xFF00D4FF)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00D4FF)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB347), width: 2),
            ),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel,
                style: const TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              final v = int.tryParse(controller.text);
              if (v != null && v > 0) Navigator.pop(dialogContext, v);
            },
            child: Text(l10n.ok,
                style: const TextStyle(color: Color(0xFFFFB347))),
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
    if (_prepping) return '$_prepRemaining';
    return _running ? '$_remaining' : '$_targetSeconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    // Fire-and-forget — disposal stays sync. Same safety-net pattern as
    // wakelock release: if the user navigates away mid-timer, we must release
    // the wakelock and stop any in-flight SFX.
    SoundService.instance.stopAll();
    WakelockPlus.disable();
    _pulseController.dispose();
    _banner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final showPresets = !_running && !_done && !_prepping;
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
                          const SizedBox(width: 8),
                          _NeonIconButton(
                            icon: Icons.settings,
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const SettingsScreen())),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ── スローガン
                Text(
                  l10n.slogan,
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

                // ── Streak バッジ（連続日数）。1日以上で表示。
                if (_streak > 0 && !_running && !_prepping) ...[
                  const SizedBox(height: 10),
                  _StreakBadge(streak: _streak, label: l10n.streakDays(_streak)),
                ],

                const SizedBox(height: 20),

                // ── タイマー円
                _TimerRing(
                  progress: _progress,
                  running: _running || _prepping,
                  done: _done,
                  prepping: _prepping,
                  pulseAnim: _pulseAnim,
                  label: _timeLabel,
                  remainingLabel: l10n.secRemaining,
                  secondsLabel: l10n.secondsLabel,
                ),

                const SizedBox(height: 36),

                // ── プリセットチップ
                if (showPresets)
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
                          label: l10n.customChip,
                          selected: false,
                          onTap: _setCustom,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 32),

                // ── メインボタン
                if (_prepping)
                  _MainButton(
                    label: l10n.abort,
                    color: const Color(0xFFFF4466),
                    onTap: _abort,
                  )
                else if (_running)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _MainButton(
                        label: l10n.abort,
                        color: const Color(0xFFFF4466),
                        onTap: _abort,
                      ),
                      const SizedBox(width: 16),
                      _MainButton(
                        label: l10n.giveUp,
                        color: const Color(0xFFFFB347),
                        onTap: _giveUp,
                      ),
                    ],
                  )
                else
                  _MainButton(
                    label: _done ? l10n.retry : l10n.start,
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
// Streak バッジ
// ─────────────────────────────────────────
class _StreakBadge extends StatelessWidget {
  final int streak;
  final String label;

  const _StreakBadge({required this.streak, required this.label});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFFFFB347);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        border: Border.all(color: accent.withValues(alpha: 0.5), width: 1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: accent.withValues(alpha: 0.25), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: accent,
              shadows: [
                Shadow(color: accent.withValues(alpha: 0.6), blurRadius: 6),
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
  final bool prepping;
  final Animation<double> pulseAnim;
  final String label;
  final String remainingLabel;
  final String secondsLabel;

  const _TimerRing({
    required this.progress,
    required this.running,
    required this.done,
    required this.prepping,
    required this.pulseAnim,
    required this.label,
    required this.remainingLabel,
    required this.secondsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final neon = done
        ? const Color(0xFFFFB347)
        : prepping
            ? const Color(0xFFFFB347)
            : const Color(0xFF00D4FF);

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
                  if (!done && !prepping)
                    Text(
                      running ? remainingLabel : secondsLabel,
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
