import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/haptic_service.dart';
import '../services/sound_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _soundEnabled;
  late bool _vibrationEnabled;

  @override
  void initState() {
    super.initState();
    _soundEnabled = SoundService.instance.enabled;
    _vibrationEnabled = HapticService.instance.enabled;
  }

  Future<void> _toggleSound(bool value) async {
    setState(() => _soundEnabled = value);
    await SoundService.instance.setEnabled(value);
  }

  Future<void> _toggleVibration(bool value) async {
    setState(() => _vibrationEnabled = value);
    await HapticService.instance.setEnabled(value);
    if (value) {
      // Confirmation pulse so the user knows it works.
      HapticService.instance.tick();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF030614),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.5), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Color(0xFF00D4FF), size: 16),
          ),
        ),
        title: _NeonTitle(l10n.settingsTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00D4FF).withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              _SettingsToggleCard(
                label: l10n.countdownVoiceLabel,
                description: l10n.countdownVoiceDescription,
                value: _soundEnabled,
                onChanged: _toggleSound,
              ),
              const SizedBox(height: 12),
              _SettingsToggleCard(
                label: l10n.vibrationLabel,
                description: l10n.vibrationDescription,
                value: _vibrationEnabled,
                onChanged: _toggleVibration,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

class _SettingsToggleCard extends StatelessWidget {
  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleCard({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFF00D4FF);
    const accent = Color(0xFFFFB347);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628).withValues(alpha: 0.6),
        border: Border.all(color: neon.withValues(alpha: 0.4), width: 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: neon.withValues(alpha: 0.12), blurRadius: 12),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.6),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: accent,
            activeTrackColor: accent.withValues(alpha: 0.4),
            inactiveThumbColor: Colors.white.withValues(alpha: 0.4),
            inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }
}
