import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_sdk/src/dtos/logged_in_dto.dart';
import 'package:swipe_sdk/swipe_sdk.dart';

import '../secret_loader_service.dart';
import '../secret_model.dart';

final String LOGIN = 'swp';
final String PASSWORD = '123456789';
final String SECRETS_FILENAME = '/home/joseildo/Disks/HdInterno/codigos/Swipe/swipe-sdk-dart/test/src/secrets.json';

void main() {

  group('Login', () {
    setUp(() async {
      final currentPath = path.current.replaceFirst('/test', '');
      await (await SharedPreferences.getInstance()).clear();
      final Secret secret = await SecretLoader(
        secretPath: path.join(currentPath, 'test', 'src', SECRETS_FILENAME),
      ).load();
      final Options options = Options(
        apiKey: secret.apiKey,
        secret: secret.secret,
        baseUrl: secret.baseUrl,
        assetId: secret.backedAsset,
      );
      await SwipeClient.init(options);
    });

    test('newSession login', () async {
      final LoggedInDto result = await login();
      expect(result.login, LOGIN);
    });

    test('newSession right login', () async {
      final LoggedInDto result = await login();
      expect(result.isLogged, equals(true));
    });

    test('newSession session not null', () async {
      final LoggedInDto result = await login();
      expect(result.sessionId, isNotNull);
    });

    test('newSession accountId not null', () async {
      final LoggedInDto result = await login();
      expect(result.accountId, isNotNull);
    });

    test('isLoginSessionActive', () async {
      print('Login');
      final loginDto = await login();
      print('Fim Login\nisactive');
      final LoggedInDto result = await SwipeClient.instance.login
          .isLoginSessionActive(loginDto.sessionId);
      expect(result.isLogged, true);
    });

  });
}

Future<LoggedInDto> login() async =>
    await SwipeClient.instance.login.newLoginSession(LOGIN, PASSWORD, 10);
