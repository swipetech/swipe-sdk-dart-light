import 'package:swipe_sdk/src/models/session_model.dart';

abstract class SessionRepository{
  void save(SessionModel sessionModel);
  SessionModel get();
  void delete();
}