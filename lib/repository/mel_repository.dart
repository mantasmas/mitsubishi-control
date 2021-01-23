import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mitsubishi_control/models/auth.dart';
import 'package:mitsubishi_control/models/login_response.dart';

class MELRepository {
  static String baseUrl = env['MITSUBISHI_URL'];

  final Dio _dio = Dio();
  String loginUrl = '$baseUrl/Login/ClientLogin';

  Future<LoginResponse> login(AuthInfo authInfo) async {
    try {
      final loginBody = {
        "Email": authInfo.email,
        "Password": authInfo.password,
        "AppVersion": "0"
      };

      Response response = await _dio.post(loginUrl, data: loginBody);

      return LoginResponse.fromJson(response.data);
    } catch (error) {
      print(error);
      return LoginResponse.withError();
    }
  }
}
