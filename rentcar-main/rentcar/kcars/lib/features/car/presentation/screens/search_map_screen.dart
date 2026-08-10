import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/providers/location_servic_provider.dart';
import 'package:kcars/core/providers/user_location.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/presentation/riverpod/filter_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/nearby_cars.dart';
import 'package:kcars/features/car/presentation/views/carousal_slider_view.dart';
import 'package:kcars/features/car/presentation/views/nearbay_cars_view.dart';
import 'package:kcars/features/car/presentation/widget/custom_marker.dart';
import 'package:kcars/features/car/presentation/widget/custom_sheet.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import "package:collection/collection.dart";

class SeachMapScreen extends StatefulHookConsumerWidget {
  const SeachMapScreen({super.key});

  @override
  ConsumerState<SeachMapScreen> createState() => _SeachMapScreenState();
}

class _SeachMapScreenState extends ConsumerState<SeachMapScreen> {
  final MapController _filterMapController = MapController();
  final MapController _nearbyMapController = MapController();

  @override
  void dispose() {
    _filterMapController.dispose();
    _nearbyMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNearby = useState(false);

    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isNearby.value
                ? NearbyMap(
                    key: const ValueKey('nearby_map'),
                    controller: _nearbyMapController,
                  )
                : FilteredMap(
                    key: const ValueKey('filtered_map'),
                    controller: _filterMapController,
                  ),
          ),

          Positioned(
            top: 30.w,
            right: 4.w,
            child: MapToggleSwitch(
              isNearby: isNearby.value,
              onToggle: (t) => isNearby.value = t,
            ),
          ),
        ],
      ),
    );
  }
}

class FilteredMap extends ConsumerWidget {
  final MapController controller;

  const FilteredMap({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(filtersCarsProvider());

    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
        initialCenter: const LatLng(36.456636, 44.492313),
        initialZoom: 7.1,
      ),
      children: [
        _defaultTileLayer(),
        if (cars.items.isNotEmpty) AnimatedMarkersLayer(cars: cars.items),
      ],
    );
  }
}

class NearbyMap extends ConsumerWidget {
  final MapController controller;

  const NearbyMap({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationStatus = ref.watch(locationStatusProvider);

    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
        initialCenter: const LatLng(36.456636, 44.492313),
        initialZoom: 7.1,
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
    final location = ref.watch(currentPositionProvider(context));
    final params = ref.watch(userLocationProvider(true));

    return location.when(
      data: (_) {
        final cars = ref.watch(nearbayCarsProvider(params));
        return SizedBox(
          height: 100.h,
          child: cars.when(
            data: (items) => items.isEmpty
                ? const SizedBox()
                : AnimatedMarkersLayer(cars: items),
            loading: () => const SizedBox(),
            error: (e, _) => const SizedBox(),
          ),
        );
      },
      loading: () => const SizedBox(),
      error: (e, _) => const SizedBox(),
    );
  }
}

class NeabyCarMakrs extends ConsumerWidget {
  const NeabyCarMakrs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(currentPositionProvider(context));
    final param = ref.watch(userLocationProvider(true));
    return positionAsync.when(
      data: (position) {
        final cars = ref.watch(nearbayCarsProvider(param));
        return SizedBox(
          height: 40.w,
          child: cars.when(
            data: (data) => data.isEmpty
                ? SizedBox.shrink()
                : AnimatedMarkersLayer(cars: data),
            error: (e, _) => SizedBox.shrink(),
            loading: () => SizedBox.shrink(),
          ),
        );
      },
      loading: () => SizedBox.shrink(),
      error: (e, _) => SizedBox.shrink(),
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
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = widget.cars.map((car) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );
    }).toList();

    _animations = _controllers
        .map(
          (controller) =>
              CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        )
        .toList();

    _playAnimationsStaggered();
  }

  Future<void> _playAnimationsStaggered() async {
    for (var i = 0; i < _controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: List.generate(widget.cars.length, (index) {
        final car = widget.cars[index];

        if (car.location == null) {
          return Marker(
            point: LatLng(0, 0),
            width: 0,
            height: 0,
            child: SizedBox(),
          );
        }
        return Marker(
          point: LatLng(car.location!.lat!, car.location!.long!),
          width: 40,
          height: 40,
          child: FadeTransition(
            opacity: _animations[index],
            child: ScaleTransition(
              scale: _animations[index],
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
      }),
    );
  }
}

class CarContent extends StatelessWidget {
  const CarContent({super.key, required this.car});
  final Car car;
  @override
  Widget build(BuildContext context) {
    final rentPlan = car.rentalPlan?.firstWhereOrNull(
      (plan) => plan.periodType == car.displayPlan,
    );
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CarousalView(
              imageHeight: 34.w,
              imageWidth: 44.w,
              sliders: car.images ?? [],
            ),
          ),
          Gap(4.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.router.push(CarDetailsRoute(carId: car.carId ?? ""));
              },
              child: ColoredBox(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (car.featuredCars != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.w,
                        ),
                        decoration: BoxDecoration(
                          color: context.surfaceTint,
                          borderRadius: BorderRadiusDirectional.circular(100.w),
                        ),
                        child: Text(
                          LocaleKeys.labels_featured.tr(),
                          style: context.caption.copyWith(
                            color: context.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(1.w),
                    ],
                    Text(car.title, style: context.title3SemiBold, maxLines: 2),
                    Gap(2.w),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${car.feature?.year ?? '–'}",
                          style: context.label,
                        ),
                        Gap(1.w),
                        Text(
                          "- ${car.feature?.transmission?.transmissionType() ?? ''}",
                          style: context.caption,
                        ),
                      ],
                    ),
                    Gap(1.w),
                    Text.rich(
                      TextSpan(
                        text:
                            "${rentPlan?.price.forMatNumber() ?? ""} ${rentPlan?.currency?.getCurrency() ?? ''}",
                        children: [
                          TextSpan(
                            text:
                                " - ${rentPlan?.periodType.periodPerType() ?? ''}",
                            style: context.caption,
                          ),
                        ],
                      ),
                      style: context.caption,
                    ),
                    Gap(4.w),
                    PrimaryButton(
                      height: 9.w,
                      text: LocaleKeys.buttons_details.tr(),
                      onPress: () {
                        context.router.push(
                          CarDetailsRoute(carId: car.carId ?? ""),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapToggleSwitch extends StatelessWidget {
  final bool isNearby;
  final void Function(bool) onToggle;

  const MapToggleSwitch({
    super.key,
    required this.isNearby,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: context.surfaceContainerLowest.withAlpha(230),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 44.w,
      height: 12.w,
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: isNearby
                ? AlignmentDirectional.centerEnd
                : AlignmentDirectional.centerStart,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Container(
              width: 20.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ToggleOption(
                label: LocaleKeys.buttons_filter.tr(),
                selected: !isNearby,
                onTap: () => onToggle(false),
              ),
              _ToggleOption(
                label: LocaleKeys.buttons_nearMe.tr(),
                selected: isNearby,
                onTap: () => onToggle(true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? context.secondary : context.outline,
            ),
          ),
        ),
      ),
    );
  }
}
