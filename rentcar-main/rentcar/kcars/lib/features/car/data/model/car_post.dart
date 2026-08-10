import 'package:dart_mappable/dart_mappable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';

part 'car_post.mapper.dart';

@MappableClass()
class CarPost with CarPostMappable, CleanMapMixin {
  final CarUpdate car;
  final List<Images>? deletedImages;
  final List<RentalPlan>? deletedRentalPlans;
  final List<XFile>? images;
  CarPost({
    required this.car,
    this.deletedImages,
    this.deletedRentalPlans,
    this.images,
  });
}
