import 'package:flutter_test/flutter_test.dart';
import 'package:swipe_sdk/src/models/search_options.dart';
import 'package:swipe_sdk/swipe_sdk.dart';

import '../secret_loader_service.dart';
import '../secret_model.dart';

void main() {
  group('Ledger', () {
    setUp(() async {
      final Secret secret =
          await SecretLoader(secretPath: '/home/joseildo/Disks/HdInterno/codigos/Swipe/swipe-sdk-dart/test/src/secrets.json').load();
      final Options options = Options(
        apiKey: secret.apiKey,
        secret: secret.secret,
        baseUrl: secret.baseUrl,
        assetId: secret.backedAsset,
      );
      await SwipeClient.init(options);
      await login();
    });

    test('getMyAccount', () async {
      final swipe = SwipeClient.instance;
      final result = await swipe.ledger.getMyAccount();
      expect(result.id, SwipeClient.instance.session.accountId);
    });
  });
}

Future<LoggedInDto> login() async =>
    await SwipeClient.instance.login.newLoginSession('swp', '123456789', 10);
