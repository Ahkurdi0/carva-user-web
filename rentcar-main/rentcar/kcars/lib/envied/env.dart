import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'baseUrl', obfuscate: true)
  static final String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'oneSignal', obfuscate: true)
  static final String oneSignal = _Env.oneSignal;
  @EnviedField(varName: 'imageUrl', obfuscate: true)
  static final String imageUrl = _Env.imageUrl;
}
