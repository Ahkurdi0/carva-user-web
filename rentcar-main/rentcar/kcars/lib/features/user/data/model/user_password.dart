import 'package:dart_mappable/dart_mappable.dart';
part 'user_password.mapper.dart';

@MappableClass()
class UserPassword with UserPasswordMappable {
  UserPassword({required this.password, required this.userId});
  final String password;
  final String userId;
}
