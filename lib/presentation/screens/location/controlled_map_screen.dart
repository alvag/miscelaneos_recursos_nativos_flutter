import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final watchUserLocation = ref.watch(userLocationProvider);

    return Scaffold(
      body: watchUserLocation.when(
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

class MapAndControls extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          ),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.directions_run),
            onPressed: () {},
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

class _MapView extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const _MapView({
    required this.initialLatitude,
    required this.initialLongitude,
  });

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
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
      onMapCreated: (GoogleMapController controller) {},
    );
  }
}
