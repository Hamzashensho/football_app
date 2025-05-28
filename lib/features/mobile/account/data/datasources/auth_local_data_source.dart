import 'dart:convert';
import 'package:sport_app_user/core/services/shared_prefs_service.dart';
import 'package:sport_app_user/features/mobile/account/data/model/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'cached_user';
  final SharedPrefsService _prefsService;

  AuthLocalDataSourceImpl(this._prefsService);

  @override
  Future<void> cacheUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefsService.setString(_userKey, userJson);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = _prefsService.getString(_userKey);
    if (jsonString == null) return null;
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  @override
  Future<void> clearCache() async {
    await _prefsService.remove(_userKey);
  }
}
