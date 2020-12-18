import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppConfiguration {
  final apiUrl = const String.fromEnvironment('API_URL',
      defaultValue: 'https://activities-rjm7jeatiq-ew.a.run.app');
}

final appConfigurationProvider = Provider<AppConfiguration>((ref) {
  return AppConfiguration();
});
