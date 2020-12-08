import 'package:app/auth/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';

class JwtInterceptor extends Interceptor {
  final ProviderReference ref;

  JwtInterceptor(this.ref);

  @override
  Future onRequest(RequestOptions options) {
    String requestPath = options.path;

    if (requestPath.contains('/auth/login') ||
        requestPath.contains('/auth/refresh')) {
      // We don't care about tokens for these two endpoints
      return super.onRequest(options);
    }

    print("request going to ${options.path}");

    final authState = ref.read(authControllerProvider.state);

    if (authState.accessToken != null) {
      print("USING TOKEN: ${authState.accessToken.suffix}");
      options.headers['Authorization'] = 'Bearer ${authState.accessToken.jwt}';
    } else {
      print("NO TOKEN FROM STATE");
    }

    return super.onRequest(options);
  }
}
