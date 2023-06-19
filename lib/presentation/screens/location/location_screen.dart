import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userLocationAsync = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicación actual'),
            userLocationAsync.when(
              data: (data) => Text('$data'),
              error: (error, stack) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 20),
            const Text('Seguimiento de ubicacion'),
          ],
        ),
      ),
    );
  }
}
