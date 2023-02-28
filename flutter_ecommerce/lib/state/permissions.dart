import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/user_role.dart';

/// If our user is signed out, this provider returns [UserRole.none]
/// Otherwise, it mocks a network request and gives out some [UserRole].
final permissionsProvider = FutureProvider.autoDispose<UserRole>((ref) async {
  // final userId = await ref.watch(authNotifierProvider.future);

  // if (userId == null)
  // return UserRole.guest;

  return _requestMock();
});

UserRole _requestMock() {
  return UserRole.user;
}
