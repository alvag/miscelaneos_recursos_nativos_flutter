import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthPlugin.canCheckBiometrics();
});

enum LocalAuthStatus { authenticated, notAuthenticated, authenticating }

class LocalAuthState {
  final bool didAuthenticate;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState({
    this.didAuthenticate = false,
    this.status = LocalAuthStatus.notAuthenticated,
    this.message = '',
  });

  copyWith({
    bool? didAuthenticate,
    LocalAuthStatus? status,
    String? message,
  }) {
    return LocalAuthState(
      didAuthenticate: didAuthenticate ?? this.didAuthenticate,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'didAuthenticate: $didAuthenticate, status: $status, message: $message';
  }
}

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier() : super(LocalAuthState());

  Future<(bool, String)> authenticateUser() async {
    final (didAutenticate, message) = await LocalAuthPlugin.authenticate();
    state = state.copyWith(
      didAuthenticate: didAutenticate,
      status: didAutenticate
          ? LocalAuthStatus.authenticated
          : LocalAuthStatus.notAuthenticated,
      message: message,
    );

    return (didAutenticate, message);
  }
}

final localAuthProvider =
    StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
  return LocalAuthNotifier();
});
