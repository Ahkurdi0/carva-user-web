import 'package:dart_mappable/dart_mappable.dart';
import 'package:kcars/core/utils/mixin.dart';
part 'suppprt.mapper.dart';

@MappableClass()
class Support with SupportMappable, CleanMapMixin {
  final String? id;
  final String en;
  final String ku;
  final String ar;
  final String content;
  final String? image;
  final int? sort;
  final bool? available;
  final DateTime? postedAt;

  Support({
    this.id,
    required this.en,
    required this.ku,
    required this.ar,
    required this.content,
    this.image,
    this.sort,
    this.available,
    this.postedAt,
  });

  String getTitle(String locale) => switch (locale) {
    'ku' => ku,
    'ar' => ku,
    _ => en,
  };
  Support toDiffer(Support? support) {
    return Support(
      id: support?.id == id ? support?.id : null,
      en: en == support?.en ? "" : en,
      ku: ku == support?.ku ? "" : ku,
      ar: ar == support?.ar ? "" : ar,
      content: content == support?.content ? "" : content,
      image: image == support?.image ? null : image,
      sort: null,
      available: available == support?.available ? null : available,
      postedAt: null,
    );
  }
}
