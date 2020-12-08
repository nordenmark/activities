import 'package:app/auth/auth_controller.dart';
import 'package:app/auth/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';

class RefreshInterceptor extends Interceptor {
  final ProviderReference ref;
  final Dio dio;

  RefreshInterceptor(this.ref, this.dio);

  @override
  Future onError(DioError dioError) async {
    final authController = ref.read(authControllerProvider);
    print(
        "ERROR ON PATH ${dioError.request.path} code: ${dioError.response?.statusCode}");

    if (dioError.response?.statusCode != 401) {
      // Here we only handle code 401
      return super.onError(dioError);
    }

    if (dioError.request.path.contains('/auth/refresh')) {
      // We can't do anything if refresh fails
      authController.logout();
      return super.onError(dioError);
    }

    final authState = ref.read(authControllerProvider.state);

    if (authState.refreshToken == null) {
      // No refreshToken available, nothing to do
      authController.logout();
      return super.onError(dioError);
    }

    Map<String, dynamic> response = await this.dio.post('/auth/refresh', data: {
      'refreshToken': authState.refreshToken.jwt
    }).then((response) => response.data);

    LoginResponse data = LoginResponse.fromJson(response);

    authController.initialize(
        user: data.user,
        accessToken: data.accessToken,
        refreshToken: data.refreshToken);

    print(
        "STATE HAS BEEN UPDATEd, NOW WE NEED TO RETRY THE REQUEST ${dioError.request.path}");

    return dio.request(dioError.request.path, options: dioError.request);
  }
}
