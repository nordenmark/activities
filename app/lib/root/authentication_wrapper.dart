import 'package:app/auth/auth_controller.dart';
import 'package:app/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'home_screen.dart';

// final initializeAppFuture = FutureProvider.autoDispose<void>((ref) async {
//   ref.maintainState = true;
//   final storageService = ref.read(storageServiceProvider);
//   final authController = ref.read(authControllerProvider);

//   Token refreshToken = await storageService.getRefreshToken();

//   if (refreshToken != null) {
//     print("refreshtoken not null $refreshToken");
//   }

//   return;
// });

class AuthenticationWrapper extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authState = useProvider(authControllerProvider.state);
    // final authService = useProvider(authServiceProvider);

    // return FutureBuilder(future: authService.initialize(),
    // builder: (BuildContext context, AsyncSnapshot snapshot) {
    //   if (snapshot.connectionState == )
    // }
    // );

    // if (authState.isLoading) {
    //   return SplashScreen();
    // }

    if (!authState.isLoggedIn) {
      return LoginScreen();
    }

    return HomeScreen();
  }
}
