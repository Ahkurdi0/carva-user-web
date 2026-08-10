import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/company/data/model/company.dart';
part 'sliders.mapper.dart';

@MappableClass()
class Sliders with SlidersMappable, CleanMapMixin {
  final String? id;
  final String? carId;
  final String? companyId;
  final String? url;
  final String? image;
  final int? sort;
  final SlideType? type;
  final int? clicked;
  final Company? company;
  final Car? car;
  final bool? available;
  final DateTime? createdAt;

  Sliders({
    this.id,
    this.carId,
    this.companyId,
    this.url,
    this.image,
    this.sort,
    this.clicked,
    this.type,
    this.company,
    this.car,
    this.available,
    this.createdAt,
  });

  Sliders toDiffer(Sliders? orginal) {
    return Sliders(
      id: orginal?.id == id ? orginal?.id : null,
      image: image == orginal?.image ? null : image,
      url: orginal?.url == url ? null : url,
      carId: orginal?.carId == carId ? null : carId,
      companyId: orginal?.companyId == companyId ? null : companyId,
      type: orginal?.type == type ? null : type,
      sort: null,
      createdAt: null,
      available: available == orginal?.available ? null : available,
    );
  }
}
