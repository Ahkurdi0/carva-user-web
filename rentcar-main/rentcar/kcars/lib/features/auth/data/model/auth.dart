import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/auth/data/model/session.dart';
part 'auth.mapper.dart';

@MappableClass()
class Auth with AuthMappable {
  final String? userId;
  final String? name;
  final String? userName;
  final String? email;
  final String? password;
  final String? oldPassword;
  final String? phoneNumber;
  final Session? session;
  final String? image;
  final String? imageUrl;
  final String? countryCode;
  final String? imageId;
  final String? code;
  final String? channel;
  final String? otp;
  final String? platform;
  final String? refreshToken;
  final bool? allDevices;
  final String? prefLang;

  const Auth({
    this.userId,
    this.name,
    this.phoneNumber,
    this.userName,
    this.email,
    this.password,
    this.oldPassword,
    this.session,
    this.image,
    this.imageUrl,
    this.countryCode,
    this.imageId,
    this.code,
    this.channel,
    this.otp,
    this.platform,
    this.allDevices,
    this.refreshToken,
    this.prefLang,
  });
}
