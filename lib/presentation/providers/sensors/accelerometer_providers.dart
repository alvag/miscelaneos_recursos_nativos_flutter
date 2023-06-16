import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerXYZ {
  final double x;
  final double y;
  final double z;

  AccelerometerXYZ({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() {
    return 'x: $x, y: $y, z: $z';
  }
}

final accelerometerGravityProvider =
    StreamProvider.autoDispose<AccelerometerXYZ>((ref) async* {
  await for (final event in accelerometerEvents) {
    yield AccelerometerXYZ(
      x: double.parse(event.x.toStringAsFixed(2)),
      y: double.parse(event.y.toStringAsFixed(2)),
      z: double.parse(event.z.toStringAsFixed(2)),
    );
  }
});

final accelerometerUserProvider =
    StreamProvider.autoDispose<AccelerometerXYZ>((ref) async* {
  await for (final event in userAccelerometerEvents) {
    yield AccelerometerXYZ(
      x: double.parse(event.x.toStringAsFixed(2)),
      y: double.parse(event.y.toStringAsFixed(2)),
      z: double.parse(event.z.toStringAsFixed(2)),
    );
  }
});
