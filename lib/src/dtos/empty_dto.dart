import 'package:swipe_sdk/src/interfaces/base_dto.dart';

class EmptyDTO implements BaseDTO<EmptyDTO> {
  static final _instance = EmptyDTO._();

  EmptyDTO._();

  factory EmptyDTO() {
    return _instance;
  }

  factory EmptyDTO.fromJson(Map<String, dynamic> _) => _instance;

  @override
  fromJson(Map<String, dynamic> json) => _instance;
  @override
  Map<String, dynamic> toJson() => {};
}
