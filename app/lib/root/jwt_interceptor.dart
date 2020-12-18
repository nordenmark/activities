import 'package:app/auth/auth_controller.dart';
import 'package:app/auth/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';

class JwtInterceptor extends Interceptor {
  final ProviderReference ref;
  final Dio dio;

  JwtInterceptor(this.ref, this.dio);

  @override
  Future onError(DioError dioError) {
    final authController = ref.read(authControllerProvider);

    print(
        "ERROR ON PATH ${dioError.request.path} code: ${dioError.response?.statusCode}, type: ${dioError.type}");
    print('response?: ${dioError.response?.toString()}');

    if (dioError.response?.statusCode == 401 ||
        dioError.response?.statusCode == 402) {
      authController.logout();
      return super.onError(dioError);
    }

    return super.onError(dioError);
  }

  @override
  Future onRequest(RequestOptions options) async {
    String requestPath = options.path;
    print("calling ${options.method} $requestPath");

    if (requestPath.contains('/auth/login') ||
        requestPath.contains('/auth/refresh')) {
      // We don't care about tokens for these two endpoints
      return super.onRequest(options);
    }

    final authState = ref.read(authControllerProvider.state);
    final authController = ref.read(authControllerProvider);

    // If we have an accessToken that is not expired

    if (authState.accessToken != null) {
      if (authState.accessToken.isValid) {
        print(
            "access TOKEN IS STILL VALID (until: ${authState.accessToken.expiresAt}) so using it TOKEN: ${authState.accessToken.jwt}");
        options.headers['Authorization'] =
            'Bearer ${authState.accessToken.jwt}';
        return super.onRequest(options);
      } else {
        print(
            "the accessToken we have in state is no longer valid, it expired at: ${authState.accessToken.expiresAt} (token: ${authState.accessToken.suffix})");
      }
    } else {
      print("No accessToken found in state");
    }

    if (authState.refreshToken != null) {
      if (authState.refreshToken.isValid) {
        print(
            "refresh TOKEN is still valid (until: ${authState.refreshToken.expiresAt}) so using it to refresh: ${authState.refreshToken.jwt}");
        dio.lock();
        return this.refresh(authState.refreshToken.jwt).then((response) {
          options.headers['Authorization'] =
              'Bearer ${response.accessToken.jwt}';
          authController.setState(
              user: response.user,
              accessToken: response.accessToken,
              refreshToken: response.refreshToken);
          return super.onRequest(options);
        }).whenComplete(() => dio.unlock());
      } else {
        print(
            "the refreshToken we have in state is no longer valid, it expired at: ${authState.refreshToken.expiresAt} (token: ${authState.refreshToken.suffix}");
      }
    } else {
      print("No refreshToken found in state");
    }

    return super.onRequest(options);
  }

  Future<LoginResponse> refresh(String refreshToken) async {
    var tokenDio = Dio();
    tokenDio.options = this.dio.options;

    Map<String, dynamic> response = await tokenDio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    ).then((response) => response.data);

    LoginResponse data = LoginResponse.fromJson(response);

    return data;
  }
}
