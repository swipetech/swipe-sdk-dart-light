import 'package:swipe_sdk/src/models/session_model.dart';
import 'package:swipe_sdk/src/services/http_service.dart';
import 'package:swipe_sdk/swipe_sdk.dart';

class LoginService {
  final HttpService baseRequest;
  final Function(SessionModel session) setSessionId;

  LoginService(this.baseRequest, this.setSessionId);

  Future<LoggedInDto> newLoginSession(
      String login, String password, int expirationInDays) async {
    final result = await baseRequest.postWithoutUser<LoggedInDto>(
      '/sessions',
      LoggedInDto(),
      body: {
        "login": login,
        "password": password,
        "expirationInDays": expirationInDays
      },
    );
    setSessionId(
        SessionModel(sessionId: result.sessionId, accountId: result.accountId));
    return result;
  }

  Future<LoggedInDto> isLoginSessionActive(String id) =>
      baseRequest.getWithUser<LoggedInDto>('/sessions/$id', LoggedInDto());
}
