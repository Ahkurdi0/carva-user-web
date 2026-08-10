import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kcars/core/utils/launch_links.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/presentation/widget/custom_marker.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.latLng,
    this.image,
    this.markerType = MapMarkerType.car,
  });

  final LatLng latLng;
  final String? image;
  final MapMarkerType markerType;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  LatLng? _currentPosition;
  final _mapController = MapController();
  double zoom = 10;
  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMove || event is MapEventDoubleTapZoom) {
        setState(() {
          zoom = _mapController.camera.zoom;
        });
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    _currentPosition = LatLng(widget.latLng.latitude, widget.latLng.longitude);
    setState(() {});

    return;
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        elevation: 0,
        leading: const CustomBackButton(),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                interactionOptions: const InteractionOptions(
                  flags:
                      InteractiveFlag.pinchZoom |
                      InteractiveFlag.drag |
                      InteractiveFlag.doubleTapZoom |
                      InteractiveFlag.doubleTapDragZoom,
                ),

                initialCenter: _currentPosition!,
                initialZoom: 10.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  tileProvider: NetworkTileProvider(
                    headers: {'User-Agent': 'KCARS/1.0 (kcarsapp@gmail.com)'},
                  ),
                  userAgentPackageName: 'com.carvarent',
                ),
                GestureDetector(
                  onTap: () {
                    openMaps(widget.latLng);
                  },
                  child: MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentPosition!,
                        width: 80.0,
                        height: 80.0,
                        child: CustomLocationIcon(imageUrl: widget.image),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
