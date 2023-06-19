import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userInitialLocation = ref.watch(userLocationProvider);

    return Scaffold(
      body: userInitialLocation.when(
        data: (data) => MapAndControls(
          latitude: data.$1,
          longitude: data.$2,
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {
    final mapControllerState = ref.watch(mapControllerProvider);

    return Stack(
      children: [
        _MapView(initialLatitude: latitude, initialLongitude: longitude),
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.location_searching),
            onPressed: () {
              ref.read(mapControllerProvider.notifier).goToLocation(
                    latitude,
                    longitude,
                  );
            },
          ),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            icon: Icon(mapControllerState.followUser
                ? Icons.directions_run
                : Icons.accessibility_new),
            onPressed: () {
              ref.read(mapControllerProvider.notifier).toggleFollowUser();
            },
          ),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.pin_drop),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const _MapView({
    required this.initialLatitude,
    required this.initialLongitude,
  });

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
        zoom: 12.0,
      ),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
    );
  }
}
