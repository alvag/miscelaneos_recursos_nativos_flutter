import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerXYZ {
  final double x;
  final double y;
  final double z;

  MagnetometerXYZ({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() {
    return 'x: $x, y: $y, z: $z';
  }
}

final magnetometerProvider =
    StreamProvider.autoDispose<MagnetometerXYZ>((ref) async* {
  await for (final event in magnetometerEvents) {
    yield MagnetometerXYZ(
      x: double.parse(event.x.toStringAsFixed(2)),
      y: double.parse(event.y.toStringAsFixed(2)),
      z: double.parse(event.z.toStringAsFixed(2)),
    );
  }
});
