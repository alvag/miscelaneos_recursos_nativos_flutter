import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeXYZ {
  final double x;
  final double y;
  final double z;

  GyroscopeXYZ({
    required this.x,
    required this.y,
    required this.z,
  });
}

final gyroscopeProvider = StreamProvider<GyroscopeXYZ>((ref) async* {
  await for (final event in gyroscopeEvents) {
    yield GyroscopeXYZ(
      x: double.parse(event.x.toStringAsFixed(2)),
      y: double.parse(event.y.toStringAsFixed(2)),
      z: double.parse(event.z.toStringAsFixed(2)),
    );
  }
});
