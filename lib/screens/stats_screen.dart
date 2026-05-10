import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../l10n/app_localizations.dart';
import '../models/record.dart';
import '../services/database_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  static const _cyan = Color(0xFF00D4FF);
  static const _gold = Color(0xFFFFB347);
  static const _bg = Color(0xFF030614);

  late Future<Map<String, dynamic>> _stats;

  @override
  void initState() {
    super.initState();
    _stats = DatabaseService.getStats();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: _cyan.withValues(alpha: 0.5), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: _cyan, size: 16),
          ),
        ),
        title: _NeonTitle(l10n.statsTitle),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _stats,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: _cyan, strokeWidth: 1.5),
            );
          }
          final data = snap.data!;
          final best = data['best'] as int;
          final avg = data['avg'] as double;
          final daily = data['daily'] as Map<DateTime, int>;
          final weekly = data['weekly'] as Map<int, int>;
          final all = data['all'] as List<Record>;

          if (best == 0) {
            return Center(
              child: Text(
                l10n.noDataYet,
                style: TextStyle(
                  color: _cyan.withValues(alpha: 0.5),
                  fontSize: 13,
                  letterSpacing: 4,
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              // ── ベスト・平均カード
              Row(
                children: [
                  Expanded(child: _StatCard(label: l10n.best, value: '${best}s', color: _gold)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      label: l10n.avg,
                      value: '${avg.toStringAsFixed(1)}s',
                      color: _cyan,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── 折れ線グラフ（日別推移）
              _SectionTitle(l10n.dailyBestSection),
              const SizedBox(height: 12),
              _LineChartCard(daily: daily),
              const SizedBox(height: 24),

              // ── 棒グラフ（週別合計）
              _SectionTitle(l10n.weeklyTotalSection),
              const SizedBox(height: 12),
              _BarChartCard(weekly: weekly, nowLabel: l10n.weekNow),
              const SizedBox(height: 24),

              // ── 全記録グラフ
              _SectionTitle(l10n.allRecordsSection(all.length)),
              const SizedBox(height: 12),
              _AllRecordsChart(records: all),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────
// ベスト・平均カード
// ─────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
        borderRadius: BorderRadius.circular(8),
        color: color.withValues(alpha: 0.05),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 16)],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w200,
              color: color,
              shadows: [Shadow(color: color.withValues(alpha: 0.8), blurRadius: 12)],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 3,
              color: color.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// セクションタイトル
// ─────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        letterSpacing: 3,
        color: const Color(0xFF00D4FF).withValues(alpha: 0.6),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// ─────────────────────────────────────────
// 折れ線グラフ（日別）
// ─────────────────────────────────────────
class _LineChartCard extends StatelessWidget {
  final Map<DateTime, int> daily;
  static const _cyan = Color(0xFF00D4FF);

  const _LineChartCard({required this.daily});

  @override
  Widget build(BuildContext context) {
    final entries = daily.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    final spots = entries.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.value.toDouble());
    }).toList();

    return Container(
      height: 180,
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      decoration: BoxDecoration(
        border: Border.all(color: _cyan.withValues(alpha: 0.2), width: 1),
        borderRadius: BorderRadius.circular(8),
        color: _cyan.withValues(alpha: 0.03),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 30,
            getDrawingHorizontalLine: (_) => FlLine(
              color: _cyan.withValues(alpha: 0.08),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 60,
                getTitlesWidget: (v, _) => Text(
                  '${v.toInt()}s',
                  style: TextStyle(
                    fontSize: 9,
                    color: _cyan.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 7,
                getTitlesWidget: (v, _) {
                  final idx = v.toInt();
                  if (idx < entries.length) {
                    final d = entries[idx].key;
                    return Text(
                      '${d.month}/${d.day}',
                      style: TextStyle(
                        fontSize: 9,
                        color: _cyan.withValues(alpha: 0.5),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: _cyan,
              barWidth: 2,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, pct, bar, idx) => FlDotCirclePainter(
                  radius: spot.y > 0 ? 3 : 0,
                  color: _cyan,
                  strokeWidth: 0,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _cyan.withValues(alpha: 0.2),
                    _cyan.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// 棒グラフ（週別合計）
// ─────────────────────────────────────────
class _BarChartCard extends StatelessWidget {
  final Map<int, int> weekly;
  final String nowLabel;
  static const _gold = Color(0xFFFFB347);
  static const _cyan = Color(0xFF00D4FF);

  const _BarChartCard({required this.weekly, required this.nowLabel});

  @override
  Widget build(BuildContext context) {
    // weeksAgo 7→0 の順に左から表示
    final groups = List.generate(8, (i) {
      final weeksAgo = 7 - i;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: (weekly[weeksAgo] ?? 0).toDouble(),
            color: weeksAgo == 0 ? _gold : _cyan,
            width: 14,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: (weekly.values.isEmpty ? 1 : weekly.values.reduce((a, b) => a > b ? a : b)).toDouble(),
              color: _cyan.withValues(alpha: 0.05),
            ),
          ),
        ],
      );
    });

    final maxY = weekly.values.isEmpty
        ? 60.0
        : (weekly.values.reduce((a, b) => a > b ? a : b)).toDouble() * 1.2;

    return Container(
      height: 180,
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      decoration: BoxDecoration(
        border: Border.all(color: _gold.withValues(alpha: 0.2), width: 1),
        borderRadius: BorderRadius.circular(8),
        color: _gold.withValues(alpha: 0.03),
      ),
      child: BarChart(
        BarChartData(
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: _gold.withValues(alpha: 0.08),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (v, _) => Text(
                  '${v.toInt()}s',
                  style: TextStyle(
                    fontSize: 9,
                    color: _gold.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final weeksAgo = 7 - v.toInt();
                  return Text(
                    weeksAgo == 0 ? nowLabel : '-${weeksAgo}w',
                    style: TextStyle(
                      fontSize: 9,
                      color: weeksAgo == 0
                          ? _gold
                          : _gold.withValues(alpha: 0.4),
                      fontWeight: weeksAgo == 0
                          ? FontWeight.w700
                          : FontWeight.normal,
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: groups,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => const Color(0xFF0A1628),
              getTooltipItem: (group, groupIdx, rod, rodIdx) => BarTooltipItem(
                '${rod.toY.toInt()}s',
                const TextStyle(color: _gold, fontSize: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// 全記録グラフ
// ─────────────────────────────────────────
class _AllRecordsChart extends StatelessWidget {
  final List<Record> records;
  static const _cyan = Color(0xFF00D4FF);
  static const _gold = Color(0xFFFFB347);

  const _AllRecordsChart({required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) return const SizedBox.shrink();

    final maxY = records.map((r) => r.seconds).reduce((a, b) => a > b ? a : b).toDouble();
    final bestSeconds = maxY.toInt();

    final spots = records.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.seconds.toDouble());
    }).toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      decoration: BoxDecoration(
        border: Border.all(color: _gold.withValues(alpha: 0.2), width: 1),
        borderRadius: BorderRadius.circular(8),
        color: _gold.withValues(alpha: 0.03),
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY * 1.2,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: _gold.withValues(alpha: 0.08),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                interval: (maxY / 3).ceilToDouble(),
                getTitlesWidget: (v, meta) => Text(
                  '${v.toInt()}s',
                  style: TextStyle(fontSize: 9, color: _gold.withValues(alpha: 0.5)),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: records.length <= 10 ? 1 : (records.length / 5).ceilToDouble(),
                getTitlesWidget: (v, meta) {
                  final idx = v.toInt();
                  if (idx < 0 || idx >= records.length) return const SizedBox.shrink();
                  final d = records[idx].date;
                  return Text(
                    '${d.month}/${d.day}',
                    style: TextStyle(fontSize: 9, color: _gold.withValues(alpha: 0.5)),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.3,
              color: _cyan,
              barWidth: 1.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, pct, bar, idx) {
                  final isBest = spot.y == bestSeconds.toDouble();
                  return FlDotCirclePainter(
                    radius: isBest ? 5 : 2.5,
                    color: isBest ? _gold : _cyan,
                    strokeWidth: isBest ? 1.5 : 0,
                    strokeColor: isBest ? Colors.white : Colors.transparent,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _cyan.withValues(alpha: 0.15),
                    _cyan.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => const Color(0xFF0A1628),
              getTooltipItems: (spots) => spots.map((s) {
                final r = records[s.spotIndex];
                return LineTooltipItem(
                  '${r.seconds}s\n${r.date.month}/${r.date.day}',
                  const TextStyle(color: _gold, fontSize: 11),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// ネオンタイトル
// ─────────────────────────────────────────
class _NeonTitle extends StatelessWidget {
  final String text;
  const _NeonTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 6,
        color: Color(0xFF00D4FF),
        shadows: [
          Shadow(color: Color(0xFF00D4FF), blurRadius: 10),
          Shadow(color: Color(0xFF00D4FF), blurRadius: 20),
        ],
      ),
    );
  }
}
