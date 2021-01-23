class LoginResponse {
  final bool isSucessful;
  final String contextKey;
  final String name;

  LoginResponse(this.isSucessful, this.contextKey, this.name);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : isSucessful = (json['ErrorId'] != 1),
        contextKey = json['LoginData']['ContextKey'],
        name = json['LoginData']['Name'];

  LoginResponse.withError()
      : isSucessful = false,
        contextKey = null,
        name = null;
}
