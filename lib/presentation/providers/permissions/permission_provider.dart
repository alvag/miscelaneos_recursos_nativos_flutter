import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>(
  (ref) => PermissionsNotifier(),
);

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState());

  Future<void> checkPermissions() async {
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera: permissionsArray[0],
      photoLibrary: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );
  }

  requestCameraPermission() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _openSettings(status);
  }

  requestPhotoLibraryPermission() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);

    _openSettings(status);
  }

  requestSensorsPermission() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    _openSettings(status);
  }

  requestLocationPermission() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    _openSettings(status);
  }

  _openSettings(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  bool get cameraGranted => camera == PermissionStatus.granted;

  bool get photoLibraryGranted => photoLibrary == PermissionStatus.granted;

  bool get sensorsGranted => sensors == PermissionStatus.granted;

  bool get locationGranted => location == PermissionStatus.granted;

  bool get locationAlwaysGranted => locationAlways == PermissionStatus.granted;

  bool get locationWhenInUseGranted =>
      locationWhenInUse == PermissionStatus.granted;

  copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) {
    return PermissionsState(
      camera: camera ?? this.camera,
      photoLibrary: photoLibrary ?? this.photoLibrary,
      sensors: sensors ?? this.sensors,
      location: location ?? this.location,
      locationAlways: locationAlways ?? this.locationAlways,
      locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
    );
  }
}
