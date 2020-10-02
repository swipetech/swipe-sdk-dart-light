library swipe_sdk;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_sdk/src/models/options.dart';
import 'package:swipe_sdk/src/models/session_model.dart';
import 'package:swipe_sdk/src/repositories/impl/session_repository_impl.dart';
import 'package:swipe_sdk/src/repositories/session_repository.dart';
import 'package:swipe_sdk/src/services/http_data.dart';
import 'package:swipe_sdk/src/services/http_service.dart';
import 'package:swipe_sdk/src/services/ledger_service.dart';
import 'package:swipe_sdk/src/services/login_service.dart';

class SwipeClient {
  static SessionRepository _sessionRepository;
  static HttpData _httpData;

  static LedgerService _ledger;
  static LoginService _login;

  LedgerService get ledger => _ledger;

  LoginService get login => _login;

  static final SwipeClient _instance = new SwipeClient._internal();

  SwipeClient._internal();

  SessionModel get session => _httpData.session;

  String get assetId => SwipeClient._httpData.options.assetId;

  static Future<void> init(Options op) async {
    _sessionRepository =
        SessionRepositoryImpl(await SharedPreferences.getInstance());
    _httpData = HttpData(op, _sessionRepository.get());
    _updateServices(_httpData);
  }

  static SwipeClient get instance {
    return _instance;
  }

  static _setSession(SessionModel session) {
    if (session != null)
      _sessionRepository.save(session);
    else
      _sessionRepository.delete();
    _httpData = _httpData.mutate(session: session);
    _updateServices(_httpData);
  }

  static _updateServices(HttpData httpData) async {
    _ledger =
        LedgerService(HttpService(httpData: httpData, service: '/ledger'));
    _login = LoginService(
        HttpService(httpData: httpData, service: '/login'), _setSession);
  }
}
