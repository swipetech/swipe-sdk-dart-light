import 'dart:async';
import 'package:swipe_sdk/src/dtos/account_dto.dart';
import 'package:swipe_sdk/src/services/http_service.dart';

class LedgerService {
  final HttpService _baseRequest;
  LedgerService(this._baseRequest);

  Future<AccountDTO> getMyAccount() {
    return this._baseRequest.getWithUser("/accounts/me", AccountDTO());
  }
}
