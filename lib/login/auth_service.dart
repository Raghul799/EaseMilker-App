import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage user authentication state
class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Keys for shared preferences
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _machineIdKey = 'machine_id';
  static const String _userTypeKey = 'user_type';

  /// Check if user is currently logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Save login state after successful authentication
  Future<void> saveLoginState(String machineId, {String userType = 'admin'}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_machineIdKey, machineId);
    await prefs.setString(_userTypeKey, userType);
  }

  /// Get stored machine ID
  Future<String?> getMachineId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_machineIdKey);
  }

  /// Get stored user type
  Future<String> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey) ?? 'admin';
  }

  /// Clear login state (logout)
  Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_machineIdKey);
    await prefs.remove(_userTypeKey);
  }
}
