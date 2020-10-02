extension on ErrorCode{
  bool equals(String e) => this.typeToString() == e;

  String typeToString() => this.toString().split(".").last;
}
enum ErrorCode{
  UNAUTHORIZED,
  FORBIDDEN,
  INTERNAL_SERVER_ERROR,
  BAD_REQUEST_BODY,
  NOT_FOUND,
  TIMEOUT
}