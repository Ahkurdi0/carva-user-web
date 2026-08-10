import 'package:dart_mappable/dart_mappable.dart';

part 'booked_dates.mapper.dart';

@MappableClass()
class BookedDates with BookedDatesMappable {
  final DateTime startDate;
  final DateTime endDate;

  BookedDates({required this.startDate, required this.endDate});
}
