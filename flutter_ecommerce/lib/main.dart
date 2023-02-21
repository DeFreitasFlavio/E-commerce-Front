import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/router.dart';
import 'utils/state_logger.dart';

void main() {
  runApp(
    const ProviderScope(observers: [StateLogger()], child: App()),
  );
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'SkateShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
