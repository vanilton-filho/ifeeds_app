class AuthResponse<T> {
  bool? ok;
  String? msg;
  T? result;

  AuthResponse.ok({this.result, this.msg}) {
    ok = true;
  }

  AuthResponse.error({this.result, this.msg}) {
    ok = false;
  }
}
