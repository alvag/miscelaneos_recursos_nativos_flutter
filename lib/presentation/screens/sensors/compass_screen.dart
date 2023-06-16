import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsProvider).locationGranted;
    final compassHeading$ = ref.watch(compassStreamProvider);

    if (!locationGranted) {
      return const AskLocationScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Brújula', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: compassHeading$.when(
          data: (heading) => Compass(
            heading: heading ?? 0,
          ),
          error: (error, stackTrace) => Text(
            '$error',
            style: const TextStyle(color: Colors.white),
          ),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class Compass extends StatelessWidget {
  final double heading;

  const Compass({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${heading.ceil()}',
            style: const TextStyle(color: Colors.white, fontSize: 30)),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/compass/quadrant-2.png'),
            Transform.rotate(
              angle: (heading * (pi / 180) * -1),
              child: Image.asset('assets/images/compass/needle-1.png'),
            ),
          ],
        )
      ],
    );
  }
}
