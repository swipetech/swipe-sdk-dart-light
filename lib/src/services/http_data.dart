import 'package:swipe_sdk/src/models/options.dart';

import 'package:swipe_sdk/src/models/session_model.dart';

class HttpData {
  final Options options;
  final SessionModel session;

  HttpData(this.options, this.session);

  HttpData mutate({Options options, SessionModel session}) =>
      HttpData(options ?? this.options, session);

  @override
  toString() => "Options: ${options.toJson()}\n Session: ${session?.toJson()}";
}
