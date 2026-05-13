import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Vibration / haptic feedback service.
///
/// Pairs with SoundService — both deliver per-beat feedback during the
/// countdown. Useful for noisy gym environments where audio can be missed.
/// Uses the built-in HapticFeedback channel; no extra plugin required.
class HapticService {
  HapticService._();
  static final HapticService instance = HapticService._();

  static const _prefsKey = 'vibration_enabled';

  bool _enabled = true;
  bool _initialized = false;

  bool get enabled => _enabled;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_prefsKey) ?? true;
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, value);
  }

  /// Medium haptic — for each countdown beat (3-2-1 prep, 5-4-3-2-1 end).
  void tick() {
    if (!_enabled) return;
    HapticFeedback.mediumImpact();
  }

  /// Heavy haptic — for the punctuation moments (GO! and Done!).
  void hit() {
    if (!_enabled) return;
    HapticFeedback.heavyImpact();
  }
}
