extension SwpEnum<T> on T {
  bool equals(String e) => this.value() == e;

  String value() => this.toString().split(".").last;
}
