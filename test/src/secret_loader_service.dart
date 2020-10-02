import 'dart:convert';
import 'dart:io';

import 'secret_model.dart';

class SecretLoader {
  final String secretPath;

  SecretLoader({this.secretPath});

  Future<Secret> load() async {
    File secrets = File(this.secretPath);
    final jsonStr = secrets.readAsStringSync();
    final secret = Secret.fromJson(json.decode(jsonStr));
    return secret;
  }
}
