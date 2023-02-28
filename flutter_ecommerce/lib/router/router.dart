import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'router_notifier.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _shellNavigatorKey,
    refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: SplashPage.path,
    routes: notifier.routes,
    redirect: notifier.redirect,
  );
});
