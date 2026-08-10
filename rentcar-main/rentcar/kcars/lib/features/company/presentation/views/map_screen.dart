import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/presentation/widget/custom_marker.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class PickUpMapScreen extends StatefulWidget {
  const PickUpMapScreen({
    super.key,
    this.company,
    this.onSelect,
    this.type = MapMarkerType.car,
    this.car,
    this.latLng,
  });
  final Function(TapPosition, LatLng)? onSelect;
  final Company? company;
  final Car? car;
  final MapMarkerType type;
  final LatLng? latLng;

  @override
  State<PickUpMapScreen> createState() => _PickUpMapScreenState();
}

class _PickUpMapScreenState extends State<PickUpMapScreen>
    with TickerProviderStateMixin {
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
    if (widget.latLng != null) {
      _currentPosition = LatLng(
        widget.latLng!.latitude,
        widget.latLng!.longitude,
      );
      return;
    } else if (widget.car != null) {
      _currentPosition = LatLng(
        widget.car!.location!.lat!,
        widget.car!.location!.long!,
      );
      return;
    } else if (widget.company?.location?.lat != null) {
      _currentPosition = LatLng(
        widget.company!.location!.lat,
        widget.company!.location!.long,
      );
      setState(() {});

      return;
    }
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    final latLong = LatLng(position.latitude, position.longitude);
    widget.onSelect?.call(const TapPosition(Offset.zero, null), latLong);
    setState(() {
      _currentPosition = latLong;
    });
  }

  void _moveCameraToNewLocation() {
    if (_currentPosition != null) {
      final latLng = _currentPosition!;

      _animatedMapMove(latLng, zoom);
    }
  }

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = _mapController.camera;
    final latTween = Tween<double>(
      begin: camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
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
                onTap: (tapPosition, latlng) {
                  _currentPosition = latlng;
                  widget.onSelect?.call(tapPosition, latlng);
                  setState(() {});
                  _moveCameraToNewLocation();
                },
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
                    Marker(
                      point: _currentPosition!,
                      rotate: true,
                      width: 80.0,
                      height: 80.0,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.company != null) {}
                        },
                        child: CustomLocationIcon(
                          imageUrl: widget.type == MapMarkerType.company
                              ? widget.company?.image
                              : widget.car?.images?.first.image,
                          markerType: widget.type,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
