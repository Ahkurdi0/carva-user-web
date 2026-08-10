import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

openLinks({required String appLink, required String webLink}) async {
  final Uri app = Uri.parse(appLink);
  final Uri web = Uri.parse(webLink);
  final canOpen = await canLaunchUrl(app);

  try {
    await launchUrl(canOpen ? app : web, mode: LaunchMode.externalApplication);
  } catch (e) {
    throw Exception(e.toString());
  }
}

openLink(String webLink) async {
  final Uri web = Uri.parse(webLink);

  try {
    await launchUrl(web, mode: LaunchMode.externalApplication);
  } catch (_) {}
}

Future<void> openMaps(LatLng latLng) async {
  Uri mapUri;

  if (Platform.isAndroid) {
    mapUri = Uri.parse(
      "geo:${latLng.latitude},${latLng.longitude}?q=${latLng.latitude},${latLng.longitude}",
    );
  } else if (Platform.isIOS) {
    mapUri = Uri.parse(
      "https://maps.apple.com/?q=${latLng.latitude},${latLng.longitude}",
    );
  } else {
    return;
  }

  if (await canLaunchUrl(mapUri)) {
    await launchUrl(mapUri, mode: LaunchMode.externalApplication);
  } else {
    return;
  }
}
