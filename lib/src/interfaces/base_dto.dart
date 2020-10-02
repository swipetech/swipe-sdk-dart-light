abstract class BaseDTO<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
