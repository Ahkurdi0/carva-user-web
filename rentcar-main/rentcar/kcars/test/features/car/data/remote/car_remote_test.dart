import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/filter.dart';
import 'package:kcars/features/car/data/model/paln.dart';
import 'package:kcars/features/car/data/model/post_location.dart';
import 'package:kcars/features/car/data/model/promotion.dart';
import 'package:kcars/features/car/data/model/rental_plan.dart';
import 'package:kcars/features/car/data/remote/car_remote.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper_tests.dart';
import '../../../../utils.dart';
import '../../../auth/data/remote/auth_remote.mocks.mocks.dart';
import '../../utils/car_test_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockApiService mockApiService;
  late CarRemote carRemote;

  setUp(() {
    mockApiService = MockApiService();
    carRemote = CarRemoteImpl(mockApiService);
  });

  group('Car [CRUD] Tests', () {
    test("Should Success when list new [Car]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/car/new", data: anyNamed('data')),
      ).thenAnswer((_) async => null);

      await carRemote.listCar(CarTestData.carPost());

      verify(
        mockApiService.post(
          "$url/car/new",
          data: argThat(
            predicate<FormData>((formData) {
              final hasExpectedFields = formData.fields.length >= 2;
              final hasImageFiles = formData.files.any(
                (file) => file.key == 'images',
              );
              return hasExpectedFields && hasImageFiles;
            }),
            named: 'data',
          ),
        ),
      ).called(1);
    });

    test("[Shoulf fail when list new car]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/car/new", data: anyNamed('data')),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.listCar(CarTestData.carPost()));
      verify(
        mockApiService.post("$url/car/new", data: anyNamed('data')),
      ).called(1);
    });

    test("Should success when update [Car]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/car/update", data: anyNamed('data')),
      ).thenAnswer((_) async => null);

      await carRemote.updateCar(CarTestData.carPost());

      verify(
        mockApiService.post(
          "$url/car/update",
          data: argThat(
            predicate<FormData>((formData) {
              final hasExpectedFields = formData.fields.isNotEmpty;

              final carId = formData.fields.any(
                (file) => file.key == 'id' && file.value != "",
              );

              return carId && hasExpectedFields;
            }),
            named: 'data',
          ),
        ),
      ).called(1);
    });

    test("[Should fail when update car]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/car/update", data: anyNamed('data')),
      ).thenThrow(apiException());
      await expectApiException(
        () => carRemote.updateCar(CarTestData.carPost()),
      );
      verify(
        mockApiService.post("$url/car/update", data: anyNamed('data')),
      ).called(1);
    });

    test("Should Delete [Car]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/car/delete", data: anyNamed("data")),
      ).thenAnswer((_) async => null);

      await carRemote.deleteCar("A");

      verify(
        mockApiService.post("$url/car/delete", data: anyNamed("data")),
      ).called(1);
    });

    test("[Should fail when delete car]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/car/delete", data: anyNamed("data")),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.deleteCar("A"));

      verify(
        mockApiService.post("$url/car/delete", data: anyNamed("data")),
      ).called(1);
    });

    test("Should Sort Car images", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/car/sort", data: anyNamed("data")),
      ).thenAnswer((_) async => null);

      final images = CarTestData.car().images!;
      await carRemote.sortImages(images);

      verify(
        mockApiService.post(
          "$url/car/sort",
          data: equals(images.map((e) => e.toMap()).toList()),
        ),
      ).called(1);
    });

    test("[Should fail when sort images]", () async {
      final url = "${Info.company}/car/sort";
      final param = CarTestData.car().images!;
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.sortImages(param));
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });
  });

  group("Promotion Tests", () {
    test("Should Post new [Promotion]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/promotion/new", data: anyNamed("data")),
      ).thenAnswer((_) async => "A");
      final promotion = CarTestData.promotion();
      final result = await carRemote.promotion(promotion);
      expect(result, "A");
      verify(
        mockApiService.post("$url/promotion/new", data: promotion.cleanedMap()),
      ).called(1);
    });
    test("[Should fail when post new promotion]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/promotion/new", data: anyNamed("data")),
      ).thenThrow(apiException());
      await expectApiException(
        () => carRemote.promotion(CarTestData.promotion()),
      );
      verify(
        mockApiService.post("$url/promotion/new", data: anyNamed("data")),
      ).called(1);
    });

    test("Should Update [Promotion]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/promotion/update", data: anyNamed("data")),
      ).thenAnswer((_) async => null);
      final promotion = CarTestData.updatePromotion();
      await carRemote.updatePromotion(promotion);

      verify(
        mockApiService.post(
          "$url/promotion/update",
          data: argThat(
            predicate<DataMap>((v) => (v["id"] != null) && (v["id"] != "")),
            named: "data",
          ),
        ),
      ).called(1);
    });

    test("[Should fail when update promotion]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/promotion/new", data: anyNamed("data")),
      ).thenThrow(apiException());
      await expectApiException(
        () => carRemote.promotion(CarTestData.promotion()),
      );
      verify(
        mockApiService.post("$url/promotion/new", data: anyNamed("data")),
      ).called(1);
    });

    test("Should delete [Promotion]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/promotion/delete", data: anyNamed("data")),
      ).thenAnswer((_) async => null);
      await carRemote.deletePromotion("A");
      verify(
        mockApiService.post("$url/promotion/delete", data: {"id": "A"}),
      ).called(1);
    });

    test("[Should fail when delete promotion]", () async {
      final url = Info.company;
      when(
        mockApiService.post("$url/promotion/delete", data: anyNamed("data")),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.deletePromotion("A"));
      verify(
        mockApiService.post("$url/promotion/delete", data: anyNamed("data")),
      ).called(1);
    });

    test("Should Get All Promotions", () async {
      final p = PromotionPost();

      final url = Info.company;

      final promotions = await loadJsonData("promotions");
      final expectedPromotions = List<DataMap>.from(
        promotions,
      ).map((data) => PromotionMapper.fromMap(data)).toList();

      when(
        mockApiService.post(
          "$url/promotions",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<Promotion> Function(dynamic);
        final promotionsList = List<DataMap>.from(promotions);

        return fromMap(promotionsList).toList();
      });
      final result = await carRemote.promotions(p);
      expect(result, equals(expectedPromotions));

      verify(
        mockApiService.post(
          "$url/promotions",
          data: p.toMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get promotions]", () async {
      final url = Info.company;
      when(
        mockApiService.post(
          "$url/promotions",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.promotions(PromotionPost()));
      verify(
        mockApiService.post(
          "$url/promotions",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });

  group("[Return Cars Tests]", () {
    test("Return Suggessted [Cars]", () async {
      final url = Info.user;

      when(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Car> Function(dynamic);
        final cars = await loadJsonData("suggestedCar");
        final carLists = List<DataMap>.from(cars);

        return fromMap(carLists).toList();
      });
      final param = PostLocation();
      final mockData = [CarTestData.car()];

      final result = await carRemote.suggestedCars(param);

      expect(result, equals(mockData));

      verify(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get suggested cars]", () async {
      final url = Info.user;
      when(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.suggestedCars(PostLocation()));
      verify(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("Sould Return [Brand with Cars]", () async {
      final url = "${Info.user}/brands";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as List<Brand> Function(dynamic);

        final brands = await loadJsonData("brandCars");
        final brandList = List<DataMap>.from(brands);
        return fromMap(brandList).toList();
      });
      final param = PostLocation();
      final brandWithCars = [CarTestData.brandCars()];
      final result = await carRemote.brandCars(param);
      expect(result, equals(brandWithCars));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get brand cars]", () async {
      final url = "${Info.user}/brands";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.brandCars(PostLocation()));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("Should Return RecenltyViewd [Cars]", () async {
      final url = "${Info.user}/recentlyViewed";

      when(mockApiService.post(url, fromMap: anyNamed("fromMap"))).thenAnswer((
        invocation,
      ) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Car> Function(dynamic);
        final cars = await loadJsonData("suggestedCar");
        final listCars = List<DataMap>.from(cars);
        return fromMap(listCars).toList();
      });
      final excpectedData = [CarTestData.car()];
      final result = await carRemote.recentlyViewed();
      expect(result, equals(excpectedData));

      verify(mockApiService.post(url, fromMap: anyNamed("fromMap"))).called(1);
    });

    test("[Should fail when get recently viewed cars]", () async {
      final url = "${Info.user}/recentlyViewed";
      when(
        mockApiService.post(url, fromMap: anyNamed("fromMap")),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.recentlyViewed());
      verify(mockApiService.post(url, fromMap: anyNamed("fromMap"))).called(1);
    });

    test("Should Return [Car Details]", () async {
      final url = "${Info.user}/carDetails";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as Car Function(dynamic);
        final cars = await loadJsonData("detailsCar");
        return fromMap(cars);
      });
      final carDetails = CarTestData.detailsCar();
      final result = await carRemote.detailCars("A");
      expect(result, equals(carDetails));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get car details]", () async {
      final url = "${Info.user}/carDetails";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.detailCars("A"));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("Should Return [Cars] (Filters)", () async {
      final url = "${Info.user}/filterCars";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Car> Function(dynamic);
        final cars = await loadJsonData("suggestedCar");
        final carLists = List<DataMap>.from(cars);
        return fromMap(carLists).toList();
      });
      final param = Filter(
        brandId: "A",
        cityId: "A",
        minPrice: 5000,
        rentalPlan: FilterRentalPlan(
          id: "A",
          maxPrice: 5000,
          minPrice: 5000,
          planId: "A",
          plan: Plan(id: "A", periodType: RentalPeriodType.hourly),
        ),
      );
      final excpectedData = [CarTestData.car()];
      final result = await carRemote.filterCars(param);
      expect(result, equals(excpectedData));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get filtered cars]", () async {
      final url = "${Info.user}/filterCars";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.filterCars(Filter()));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Shold Return Company Cars]", () async {
      final url = "${Info.company}/getCars";
      when(
        mockApiService.post(
          any,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Car> Function(dynamic);
        final cars = await loadJsonData("suggestedCar");
        final carLists = List<DataMap>.from(cars);
        return fromMap(carLists).toList();
      });
      final param = CarTestData.carsCursor();
      final excpectedData = [CarTestData.car()];
      final result = await carRemote.companyCars(param);
      expect(result, equals(excpectedData));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get company cars]", () async {
      final url = "${Info.company}/getCars";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = CarTestData.carsCursor();
      await expectApiException(() => carRemote.companyCars(param));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should Return User Company Cars]", () async {
      final url = "${Info.user}/getCars";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Car> Function(dynamic);
        final cars = await loadJsonData("suggestedCar");
        final carLists = List<DataMap>.from(cars);
        return fromMap(carLists).toList();
      });
      final param = CarTestData.carsCursor();
      final excpectedData = [CarTestData.car()];
      final result = await carRemote.userCompanyCars(param);
      expect(result, equals(excpectedData));
      verify(
        mockApiService.post(
          url,
          data: param.cleanedMap(),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get user company cars]", () async {
      final url = "${Info.user}/getCars";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      final param = CarTestData.carsCursor();
      await expectApiException(() => carRemote.userCompanyCars(param));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });

  group("Favorite [Tests]", () {
    test("Should success When Favorite a [Car]", () async {
      final url = "${Info.user}/favoriteCar";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((_) async => "B");

      final result = await carRemote.favoriteCar("A");
      expect(result, equals("B"));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when favorite a car]", () async {
      final url = "${Info.user}/favoriteCar";
      when(
        mockApiService.post(url, data: anyNamed("data")),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.favoriteCar("A"));
      verify(mockApiService.post(url, data: anyNamed("data"))).called(1);
    });

    test("Should Return Favorite [Cars]", () async {
      final url = "${Info.user}/favoriteCars";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Car> Function(dynamic);
        final cars = await loadJsonData("suggestedCar");
        final carLists = List<DataMap>.from(cars);
        return fromMap(carLists).toList();
      });
      final excpectedData = [CarTestData.car()];
      final result = await carRemote.favoriteCars("A");
      expect(result, equals(excpectedData));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when get favorite cars]", () async {
      final url = "${Info.user}/favoriteCars";
      when(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.favoriteCars("A"));
      verify(
        mockApiService.post(
          url,
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });

  group("[Admin All cars tests]", () {
    test("Return All Cars", () async {
      final url = Info.user;

      when(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as List<Car> Function(dynamic);
        final cars = await loadJsonData("suggestedCar");
        final carLists = List<DataMap>.from(cars);

        return fromMap(carLists).toList();
      });
      final param = PostLocation();
      final mockData = [CarTestData.car()];

      final result = await carRemote.suggestedCars(param);

      expect(result, equals(mockData));

      verify(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("[Should fail when return All cars]", () async {
      final url = Info.user;
      when(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenThrow(apiException());
      await expectApiException(() => carRemote.suggestedCars(PostLocation()));
      verify(
        mockApiService.post(
          "$url/suggestedCars",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });
}
