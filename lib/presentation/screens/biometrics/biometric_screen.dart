import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {},
              child: const Text('Autenticar'),
            ),
            canCheckBiometrics.when(
              data: (canCheck) => Text('Can check: $canCheck'),
              error: (error, _) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 40),
            const Text('Estado del biometrico', style: TextStyle(fontSize: 30)),
            const Text('Estado XXX', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
