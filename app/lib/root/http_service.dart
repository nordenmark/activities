import 'package:app/config/configuration.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'jwt_interceptor.dart';

final httpServiceProvider = Provider<Dio>((ref) {
  final config = ref.read(appConfigurationProvider);

  var dio = Dio(BaseOptions(baseUrl: config.apiUrl));

  print(
      "### CONSTRUCTING httpServiceProvider with baseUrl: ${dio.options.baseUrl}");

  dio.interceptors.add(JwtInterceptor(ref, dio));

  return dio;
});
