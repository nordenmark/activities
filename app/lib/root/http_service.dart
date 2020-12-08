import 'package:app/auth/auth_controller.dart';
import 'package:app/auth/tokens.dart';
import 'package:app/config/configuration.dart';
import 'package:app/models/user.model.dart';
import 'package:app/root/refresh_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';

import 'jwt_interceptor.dart';

final httpServiceProvider = Provider<Dio>((ref) {
  final config = ref.read(appConfigurationProvider);
  // final authState = ref.watch(authControllerProvider.state);
  // final authController = ref.read(authControllerProvider);

  final dio = Dio();

  dio.options.baseUrl = config.apiUrl;

  print("### CONSTRUCTING httpServiceProvider");
  print("base url ${dio.options.baseUrl}");

  dio.interceptors.add(JwtInterceptor(ref));
  dio.interceptors.add(RefreshInterceptor(ref, dio));

  // dio.interceptors.;

  // dio.interceptors
  //     .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
  //   print("Request going to ${options.path}");
  //   if (authState.accessToken != null) {
  //     print(
  //         "Setting accessToken in Authorization: ${authState.accessToken.suffix}");
  //     options.headers['Authorization'] = 'Bearer ${authState.accessToken.jwt}';
  //   }
  //   return options;
  // }, onError: (DioError dioError) async {
  //   print("Error in interceptor");
  //   print("${dioError.request.path} code: ${dioError.response?.statusCode}");

  //   if (dioError.response?.statusCode == 401) {
  //     if (dioError.request.path.contains('/auth/refresh')) {
  //       // Refresh call failed, just die
  //       print("Refresh call failed, we will now die");
  //       return dioError;
  //     } else {
  //       // We will try to refresh
  //       print("NON-Refresh call failed with 401, we will try to refresh");
  //       if (authState.refreshToken == null) {
  //         // No refresh token, we have to die
  //         print("we DO NOT have a refresh token so let's die");
  //         return dioError;
  //       }
  //       if (authState.refreshToken != null) {
  //         print(
  //             "we have a refresh token so let's try to use that: ${authState.refreshToken.suffix}");
  //         Map<String, dynamic> response = await dio.post('/auth/refresh',
  //             data: {
  //               "refreshToken": authState.refreshToken.jwt
  //             }).then((response) => response.data);

  //         Token accessToken = Token(
  //             jwt: response['accessToken'],
  //             expiresIn: response['accessTokenExpiresIn']);
  //         Token refreshToken = Token(
  //             jwt: response['refreshToken'],
  //             expiresIn: response['refreshTokenExpiresIn']);
  //         User user = User.fromJson(response['user']);

  //         authController.initialize(
  //             user: user, accessToken: accessToken, refreshToken: refreshToken);

  //         return dioError;
  //         // return dio.request(dioError.request.path, options: dioError.request);
  //       }
  //     }
  //   }

  //   return dioError;
  // }));

  return dio;
});
