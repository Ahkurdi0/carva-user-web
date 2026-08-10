import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/features/car/presentation/widget/custom_marker.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, this.latLang, this.image, this.onTap});
  final VoidCallback? onTap;
  final LatLng? latLang;
  final String? image;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng? _merchantLocation;
  final MapController _mapController = MapController();
  @override
  void initState() {
    super.initState();
    _updateMerchantLocation(); // Set initial location
  }

  @override
  void didUpdateWidget(covariant MapView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.latLang?.latitude != oldWidget.latLang?.latitude ||
        widget.latLang?.longitude != oldWidget.latLang?.longitude) {
      _updateMerchantLocation();
      _moveCameraToNewLocation();
    }
  }

  void _updateMerchantLocation() {
    if (widget.latLang?.latitude != null && widget.latLang?.longitude != null) {
      setState(() {
        _merchantLocation = LatLng(
          widget.latLang!.latitude,
          widget.latLang!.longitude,
        );
      });
    }
  }

  void _moveCameraToNewLocation() {
    if (_merchantLocation != null) {
      _mapController.move(_merchantLocation!, 10.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          MapRoute(latLng: widget.latLang!, image: widget.image),
        );
      },
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
              initialCenter:
                  _merchantLocation ?? const LatLng(35.5558, 45.4351),
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
              MarkerLayer(
                markers: [
                  if (_merchantLocation != null)
                    Marker(
                      point: _merchantLocation!,
                      width: 80.0,
                      height: 80.0,
                      child: CustomLocationIcon(imageUrl: widget.image),
                    ),
                ],
              ),
            ],
          ),
          Positioned.fill(child: Container(color: Colors.transparent)),
        ],
      ),
    );
  }
}
