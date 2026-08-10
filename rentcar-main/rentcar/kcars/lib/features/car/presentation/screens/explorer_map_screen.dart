import 'dart:async';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kcars/core/providers/explorer_location.dart';
import 'package:kcars/core/providers/location_servic_provider.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/presentation/riverpod/explorer_map.dart';
import 'package:kcars/features/car/presentation/screens/search_map_screen.dart';
import 'package:kcars/features/car/presentation/views/nearbay_cars_view.dart';
import 'package:kcars/features/car/presentation/widget/custom_marker.dart';
import 'package:kcars/features/car/presentation/widget/custom_sheet.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class ExplorerMapScreen extends ConsumerStatefulWidget {
  const ExplorerMapScreen({super.key});

  @override
  ConsumerState<ExplorerMapScreen> createState() => _ExplorerMapScreenState();
}

class _ExplorerMapScreenState extends ConsumerState<ExplorerMapScreen> {
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
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    final latLong = LatLng(position.latitude, position.longitude);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onMapMoved(latLong, initialZoom);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentPosition = latLong;
      });
    });
  }

  final MapController _controller = MapController();
  Timer? _debounce;
  final double initialZoom = 8.0;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  /// Calculate visible bounds from center + zoom
  LatLngBounds _calculateBounds(LatLng center, double zoom, Size mapSize) {
    const tileSize = 256.0;
    final scale = (1 << zoom.toInt());

    final degreesPerPixelX = 360 / (tileSize * scale);
    final degreesPerPixelY = 170.1022 / (tileSize * scale);

    final halfWidth = (mapSize.width / 2) * degreesPerPixelX;
    final halfHeight = (mapSize.height / 2) * degreesPerPixelY;

    return LatLngBounds(
      LatLng(center.latitude - halfHeight, center.longitude - halfWidth),
      LatLng(center.latitude + halfHeight, center.longitude + halfWidth),
    );
  }

  /// Called when the map moves
  void _onMapMoved(LatLng? center, double? zoom) {
    if (center == null || zoom == null) return;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final size = MediaQuery.of(context).size;
      final bounds = _calculateBounds(center, zoom, size);

      ref
          .read(explorerLocationProvider.notifier)
          .update(
            PostLocation(
              north: bounds.north,
              south: bounds.south,
              east: bounds.east,
              west: bounds.west,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationStatus = ref.watch(locationStatusProvider);
    final cars = ref.watch(explorerMapProvider);

    return FlutterMap(
      mapController: _controller,
      options: MapOptions(
        initialCenter: _currentPosition ?? const LatLng(36.456636, 44.492313),
        initialZoom: initialZoom,
        minZoom: 8,
        maxZoom: 21,
        interactionOptions: InteractionOptions(
          flags: cars.isLoading ? InteractiveFlag.none : InteractiveFlag.all,
        ),
        onPositionChanged: (position, hasGesture) {
          _onMapMoved(position.center, position.zoom);
        },
      ),

      children: [
        _defaultTileLayer(),
        locationStatus.when(
          data: (granted) {
            return Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: granted
                    ? const NearbyCarMarkers()
                    : Container(
                        decoration: BoxDecoration(
                          color: context.surface.withAlpha(200),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: const EnableLocationPrompt(),
                      ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => const Center(child: Text("Error checking location")),
        ),
        if (cars.isLoading)
          Positioned(
            child: Align(
              child: Container(
                height: 20.w,
                width: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.onSurface.withAlpha(200),
                ),
                child: CircleLoading2(),
              ),
            ),
          ),
      ],
    );
  }
}

TileLayer _defaultTileLayer() {
  return TileLayer(
    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    tileProvider: NetworkTileProvider(
      headers: {'User-Agent': 'KCARS/1.0 (kcarsapp@gmail.com)'},
    ),
    userAgentPackageName: 'com.carvarent',
  );
}

class NearbyCarMarkers extends ConsumerWidget {
  const NearbyCarMarkers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(explorerMapProvider);
    return SizedBox(
      height: 100.h,
      child: cars.when(
        data: (items) => items.isEmpty
            ? const SizedBox()
            : AnimatedMarkersLayer(cars: items),
        loading: () => const SizedBox(),
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        skipError: true,
        error: (e, _) => const SizedBox(),
      ),
    );
  }
}

class NeabyCarMakrs extends ConsumerWidget {
  const NeabyCarMakrs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(explorerMapProvider);
    return SizedBox(
      height: 40.w,
      child: cars.when(
        data: (data) =>
            data.isEmpty ? SizedBox.shrink() : AnimatedMarkersLayer(cars: data),
        error: (e, _) => SizedBox.shrink(),
        loading: () => SizedBox.shrink(),
      ),
    );
  }
}

class AnimatedMarkersLayer extends StatefulWidget {
  final List<Car> cars;
  const AnimatedMarkersLayer({super.key, required this.cars});

  @override
  State<AnimatedMarkersLayer> createState() => _AnimatedMarkersLayerState();
}

class _AnimatedMarkersLayerState extends State<AnimatedMarkersLayer>
    with TickerProviderStateMixin {
  final Map<String, AnimationController> _controllers = {};
  final Map<String, Animation<double>> _animations = {};

  @override
  void initState() {
    super.initState();
    _initAnimations(widget.cars);
  }

  void _initAnimations(List<Car> cars) {
    for (var car in cars) {
      if (!_controllers.containsKey(car.id)) {
        final controller = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 300),
        );
        _controllers[car.id] = controller;
        _animations[car.id] = CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        );
        controller.forward();
      }
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedMarkersLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initAnimations(widget.cars);

    // Optionally, dispose controllers of removed cars
    final removed = oldWidget.cars.where(
      (c) => widget.cars.every((newC) => newC.id != c.id),
    );
    for (var car in removed) {
      _controllers[car.id]?.dispose();
      _controllers.remove(car.id);
      _animations.remove(car.id);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: widget.cars.map((car) {
        if (car.location == null) {
          return Marker(
            point: LatLng(0, 0),
            width: 0,
            height: 0,
            child: SizedBox(),
          );
        }
        final animation = _animations[car.id]!;
        return Marker(
          point: LatLng(car.location!.lat!, car.location!.long!),
          width: 40,
          height: 40,
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: GestureDetector(
                onTap: () {
                  showSheeet(
                    context,
                    ScrollableSheetContent(child: CarContent(car: car)),
                    viewportPadding: EdgeInsets.only(
                      bottom: 30.w,
                      left: 4.w,
                      right: 4.w,
                    ),
                  );
                },
                child: CustomLocationIcon(imageUrl: car.images?.first.image),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
