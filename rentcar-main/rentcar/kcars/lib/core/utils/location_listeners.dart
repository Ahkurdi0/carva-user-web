import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/core/providers/location_servic_provider.dart';

class LocationPermissionListener extends ConsumerStatefulWidget {
  final Widget child;
  const LocationPermissionListener({super.key, required this.child});

  @override
  ConsumerState<LocationPermissionListener> createState() =>
      _LocationPermissionListenerState();
}

class _LocationPermissionListenerState
    extends ConsumerState<LocationPermissionListener>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint("App resumed, checking location...");
      ref.invalidate(locationStatusProvider);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
