import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/permissions/permission_provider.dart';
import 'package:miscelaneos/presentation/screens/permissions/ask_location_screen.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsProvider).locationGranted;

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
      body: const Center(
        child: Compass(),
      ),
    );
  }
}

class Compass extends StatelessWidget {
  const Compass({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('155', style: TextStyle(color: Colors.white, fontSize: 30)),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/compass/quadrant-2.png'),
            Image.asset('assets/images/compass/needle-1.png'),
          ],
        )
      ],
    );
  }
}
