import 'dart:io';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/features/app_settings/data/model/suppprt.dart';
import 'package:kcars/features/car/data/model/brand.dart';
part 'post_model.mapper.dart';

@MappableClass()
class PostModel with PostModelMappable {
  final Brand? brand;
  final Support? suppprt;
  final File? image;

  PostModel({this.brand, this.suppprt, this.image});
}
