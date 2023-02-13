import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_ecommerce/entities/user_role.dart';
import 'package:flutter_ecommerce/screens/admin_page.dart';
import 'package:flutter_ecommerce/screens/guest_page.dart';
import 'package:flutter_ecommerce/screens/home_page.dart';
import 'package:flutter_ecommerce/screens/login.dart';
import 'package:flutter_ecommerce/screens/splash.dart';
import 'package:flutter_ecommerce/screens/user_page.dart';
import 'package:flutter_ecommerce/state/auth.dart';
import 'package:flutter_ecommerce/state/permissions.dart';
import 'package:flutter_ecommerce/utils/html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = false;

  @override
  Future<void> build() async {
    isAuth = await ref.watch(
      authNotifierProvider.selectAsync((data) => data != null),
    );

    ref.listenSelf((_, __) {
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) return null;

    final isSplash = state.location == SplashPage.path;

    if (isSplash) {
      return isAuth ? HomePage.path : LoginPage.path;
    }

    final isLoggingIn = state.location == LoginPage.path;
    if (isLoggingIn) return isAuth ? HomePage.path : null;

    return isAuth ? null : SplashPage.path;
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: SplashPage.path,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
            path: HomePage.path,
            builder: (context, state) {
              User user = getUser();
              return HomePage(user);
            },
            //  => const HomePage(),
            redirect: (context, state) async {
              if (state.location == HomePage.path) return null;

              final roleListener = ProviderScope.containerOf(context).listen(
                permissionsProvider.select((value) => value.valueOrNull),
                (previous, next) {},
              );

              final userRole = roleListener.read();
              final redirectTo = userRole?.redirectBasedOn(state.location);

              roleListener.close();
              return redirectTo;
            },
            routes: [
              GoRoute(
                path: AdminPage.path,
                builder: (context, state) => const AdminPage(),
              ),
              GoRoute(
                path: UserPage.path,
                builder: (context, state) => const UserPage(),
              ),
              GoRoute(
                path: GuestPage.path,
                builder: (context, state) => const GuestPage(),
              )
            ]),
        GoRoute(
          path: LoginPage.path,
          builder: (context, state) => const LoginPage(),
        ),
      ];

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});

extension RedirecttionBasedOnRole on UserRole {
  String? redirectBasedOn(String location) {
    switch (this) {
      case UserRole.admin:
        return null;
      case UserRole.verifiedUser:
      case UserRole.unverifiedUser:
        if (location == AdminPage.path) return HomePage.path;
        return null;
      case UserRole.guest:
      case UserRole.none:
        if (location != HomePage.path) return HomePage.path;
        return null;
    }
  }
}
