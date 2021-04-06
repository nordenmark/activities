import 'package:app/auth/tokens.dart';
import 'package:app/models/user.model.dart';
import 'package:app/root/http_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Credentials {
  final String email;
  final String password;

  Credentials(this.email, this.password);
}

class LoginResponse {
  final Token accessToken;
  final Token refreshToken;
  final User user;

  LoginResponse(this.accessToken, this.refreshToken, this.user);

  factory LoginResponse.fromJson(dynamic response) {
    Token accessToken = Token(
        jwt: response['accessToken'],
        expiresIn: response['accessTokenExpiresIn']);
    Token refreshToken = Token(
        jwt: response['refreshToken'],
        expiresIn: response['refreshTokenExpiresIn']);
    User user = User.fromJson(response['user']);

    return LoginResponse(accessToken, refreshToken, user);
  }
}

class AuthService {
  final Dio _httpService;

  AuthService(this._httpService);

  Future<LoginResponse> login(Credentials credentials) async {
    try {
      var response = await this._httpService.post('/auth/login', data: {
        "email": credentials.email,
        "password": credentials.password
      }).then((response) => response.data);

      return LoginResponse.fromJson(response);
    } on DioError catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<LoginResponse> refresh(String token) async {
    var response = await this._httpService.post('/auth/refresh',
        data: {"refreshToken": token}).then((response) => response.data);

    return LoginResponse.fromJson(response);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final httpService = ref.read(httpServiceProvider);

  return AuthService(httpService);
});
