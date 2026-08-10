import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/configs/app_theme.dart';
import 'package:kcars/core/providers/app_router_provider.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/service_location.dart';
import 'package:kcars/core/utils/location_listeners.dart';
import 'package:kcars/translations/codegen_loader.g.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_kurdish_localization/flutter_kurdish_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await intl.initializeDateFormatting('en');
  Intl.defaultLocale = 'en';

  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(Info.oneSignal);

  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('ku'),
        assetLoader: const CodegenLoader(),
        supportedLocales: const [Locale('en'), Locale('ar'), Locale('ku')],
        child: Sizer(
          builder: (context, orenttation, deviceyupe) {
            return LocationPermissionListener(child: const MyApp());
          },
        ),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool isSetted = false;
  Uri? _lastHandledUri;
  bool _isNavigating = false;
  bool _isInitialLinkCooldown = false;

  @override
  void initState() {
    super.initState();
    _initializeAppLinkListener();
  }

  void _initializeAppLinkListener() async {
    final appLinks = AppLinks();

    try {
      final initialUri = await appLinks.getInitialLink();
      if (initialUri != null) {
        debugPrint("Handling INITIAL deep link: $initialUri");
        _lastHandledUri = initialUri;
        await _handleNavigation(initialUri, isInitialLink: true);
        _isInitialLinkCooldown = true;

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _isInitialLinkCooldown = false;
          }
        });
      }
    } catch (e) {
      debugPrint("Error getting initial link: $e");
    }

    appLinks.uriLinkStream.listen(
      (uri) {
        if (_isInitialLinkCooldown) {
          debugPrint("Skipping deep link: Initial link cooldown active.");
          return;
        }

        if (_isNavigating) {
          debugPrint("Skipping deep link: Navigation in progress.");
          return;
        }

        if (uri == _lastHandledUri) {
          debugPrint("Skipping duplicate stream deep link: $uri");
          return;
        }

        debugPrint("Handling STREAM deep link: $uri");
        _lastHandledUri = uri;
        _handleNavigation(uri);
      },
      onError: (err) {
        debugPrint("Deep link stream error: $err");
      },
    );
  }

  Future<void> _handleNavigation(Uri uri, {bool isInitialLink = false}) async {
    if (_isNavigating) return;
    _isNavigating = true;

    try {
      final segments = uri.pathSegments;
      String? carId;
      if (segments.length >= 2 && segments[0] == 'car') {
        carId = segments[1];
      }

      if (carId != null) {
        if (isInitialLink) {
          await ref.read(appRouterProvider).replaceAll([
            CarDetailsRoute(carId: carId),
          ]);
        } else {
          await ref.read(appRouterProvider).push(CarDetailsRoute(carId: carId));
        }
      }
    } catch (e) {
      debugPrint("Navigation error for deep link $uri: $e");
    } finally {
      _isNavigating = false;
      _lastHandledUri = null;
    }
  }

  initService() async {
    if (isSetted) return;
    initServiceLocator(context, ref);
    isSetted = true;
  }

  @override
  void didChangeDependencies() {
    initService();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      localizationsDelegates: [
        ...context.localizationDelegates,
        KurdishMaterialLocalizations.delegate,
        KurdishWidgetLocalizations.delegate,
        KurdishCupertinoLocalizations.delegate,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      routerConfig: appRouter.config(
        deepLinkBuilder: (uri) => DeepLink.defaultPath,
      ),
      builder: (context, child) {
        return Navigator(
          key: sl<GlobalKey<NavigatorState>>(),
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
