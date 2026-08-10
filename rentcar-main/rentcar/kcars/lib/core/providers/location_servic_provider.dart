import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kcars/core/providers/user_location.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_servic_provider.g.dart';

@riverpod
LocationService locationService(Ref ref) => LocationService();

final locationStatusProvider = FutureProvider<bool>((ref) async {
  final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isServiceEnabled) return false;

  final permission = await Geolocator.checkPermission();
  return permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;
});

final currentPositionProvider = FutureProvider.family<Position, BuildContext>((
  ref,
  context,
) async {
  final locationService = sl<LocationService>();
  final position = await locationService.handleLocationPermission(context);
  if (position == null) throw Exception("Location not available");
  ref
      .read(userLocationProvider().notifier)
      .update(PostLocation(lat: position.latitude, long: position.longitude));
  return position;
});

final currentUserPositionProvider =
    FutureProvider.family<Position?, BuildContext>((ref, context) async {
      final locationService = sl<LocationService>();
      final position = await locationService.handleLocationPermission(context);

      if (position == null) null;
      ref
          .read(userLocationProvider(true).notifier)
          .update(
            PostLocation(lat: position?.latitude, long: position?.longitude),
          );
      return position;
    });
