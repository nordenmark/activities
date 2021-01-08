import 'package:app/auth/auth_state.dart';
import 'package:app/auth/tokens.dart';
import 'package:app/models/user.model.dart';
import 'package:app/storage/storage_service.dart';
import 'package:hooks_riverpod/all.dart';

final authControllerProvider = StateNotifierProvider<AuthController>((ref) {
  final storageService = ref.read(storageServiceProvider);

  return AuthController(storageService);
});

class AuthController extends StateNotifier<AuthState> {
  final StorageService storageService;

  AuthController(this.storageService, {AuthState state})
      : super(state ?? AuthState.initial());

  void setState({User user, Token accessToken, Token refreshToken}) {
    this.state = this.state.copyWith(
        user: user, accessToken: accessToken, refreshToken: refreshToken);
    storageService.setUser(user);
    storageService.setAccessToken(accessToken);
    storageService.setRefreshToken(refreshToken);
  }

  void logout() {
    this.state = AuthState.initial();
    this.storageService.clear();
  }
}
