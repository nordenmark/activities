import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppConfiguration {
  final apiUrl = const String.fromEnvironment('API_URL',
      defaultValue: 'http://localhost:8888');
}

final appConfigurationProvider = Provider<AppConfiguration>((ref) {
  return AppConfiguration();
});
