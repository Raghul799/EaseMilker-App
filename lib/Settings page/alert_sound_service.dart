import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage alert sound settings across the app
class AlertSoundService {
  static const String _key = 'alert_sound_enabled';
  static AlertSoundService? _instance;
  SharedPreferences? _prefs;

  AlertSoundService._();

  static AlertSoundService get instance {
    _instance ??= AlertSoundService._();
    return _instance!;
  }

  /// Initialize the service
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Get the current alert sound state
  Future<bool> getAlertSoundEnabled() async {
    await init();
    return _prefs?.getBool(_key) ?? true; // Default is true (enabled)
  }

  /// Set the alert sound state
  Future<void> setAlertSoundEnabled(bool enabled) async {
    await init();
    await _prefs?.setBool(_key, enabled);
  }
}
