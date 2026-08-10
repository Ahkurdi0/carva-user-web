import 'package:dart_mappable/dart_mappable.dart';

part 'session.mapper.dart';

@MappableClass()
class Session with SessionMappable {
  final String? id;
  final String? sessionId;
  final dynamic systemName;
  final dynamic isPhysicalDevice;
  final dynamic model;
  final dynamic localizedModel;
  final dynamic systemVersion;
  final dynamic name;
  final dynamic identifierForVendor;
  final dynamic platform;
  final DateTime? lastLogin;
  const Session({
    this.id,
    this.sessionId,
    this.systemName,
    this.isPhysicalDevice,
    this.model,
    this.localizedModel,
    this.systemVersion,
    this.name,
    this.identifierForVendor,
    this.lastLogin,
    this.platform,
  });
}
