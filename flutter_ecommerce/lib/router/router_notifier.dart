import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/entities/user.dart';
import 'package:flutter_ecommerce/entities/user_role.dart';
import 'package:flutter_ecommerce/screens/admin_page.dart';
import 'package:flutter_ecommerce/screens/basket_page.dart';
import 'package:flutter_ecommerce/screens/home_page.dart';
import 'package:flutter_ecommerce/screens/login.dart';
import 'package:flutter_ecommerce/screens/splash.dart';
import 'package:flutter_ecommerce/screens/user_page.dart';
import 'package:flutter_ecommerce/state/permissions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RouterNotifier extends AutoDisposeAsyncNotifier<void> implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = false;

  @override
  Future<void> build() async {
    final user = ref.watch(userProvider);
    isAuth = user.role != UserRole.guest;

    ref.listenSelf((_, __) {
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    switch (state.location) {
      case SplashPage.path:
        Future.delayed(
          const Duration(milliseconds: 500),
          () => true,
        );
        return HomePage.path;
      case HomePage.path:
        return HomePage.path;
      case UserPage.path:
        return isAuth ? UserPage.path : LoginPage.path;
      case BasketPage.path:
        return isAuth ? BasketPage.path : LoginPage.path;
      case LoginPage.path:
        return isAuth ? HomePage.path : LoginPage.path;
      default:
        return SplashPage.path;
    }
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: SplashPage.path,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
            path: HomePage.path,
            builder: (context, state) {
              return const HomePage();
            },
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
                path: UserPage.relativePath,
                builder: (context, state) => const UserPage(),
              ),
              GoRoute(
                path: BasketPage.relativePath,
                builder: (context, state) => const BasketPage(),
              ),
              GoRoute(
                path: LoginPage.relativePath,
                builder: (context, state) => const LoginPage(),
              ),
              // GoRoute(
              //   path: ProductPage.path,
              //   builder: (context, state) => const productPage(),
              // )
            ]),
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

final routerNotifierProvider = AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
});

extension RedirecttionBasedOnRole on UserRole {
  String? redirectBasedOn(String location) {
    switch (this) {
      case UserRole.admin:
        return null;
      case UserRole.user:
        if (location == AdminPage.path) return HomePage.path;
        return null;
      case UserRole.guest:
        // if (location != HomePage.path || location == ) return HomePage.path;
        return null;
    }
  }
}
