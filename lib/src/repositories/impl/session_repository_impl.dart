import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_sdk/src/models/session_model.dart';
import 'package:swipe_sdk/src/repositories/session_repository.dart';

const _SESSION = "session";

class SessionRepositoryImpl implements SessionRepository {
  final SharedPreferences _sharedPreferences;

  SessionRepositoryImpl(this._sharedPreferences);

  @override
  SessionModel get() {
    try {
      return sessionModelFromJson(_sharedPreferences.getString(_SESSION));
    } catch (e) {
      return null;
    }
  }

  @override
  void save(SessionModel sessionModel) {
    _sharedPreferences.setString(_SESSION, sessionModelToJson(sessionModel));
  }

  @override
  void delete() {
    _sharedPreferences.remove(_SESSION);
  }
}
