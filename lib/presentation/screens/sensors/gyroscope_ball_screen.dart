import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio'),
      ),
      body: SizedBox.expand(
        child: gyroscope$.when(
          data: (value) => MovieBall(x: value.x, y: value.y),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class MovieBall extends StatelessWidget {
  final double x;
  final double y;

  const MovieBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Ball(),
        Text(
          '''
        X: $x,
        Y: $y
        ''',
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }
}
