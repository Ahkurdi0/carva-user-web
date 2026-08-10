import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/features/car/data/model/brand.dart';
import 'package:kcars/features/car/data/model/car_type.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:kcars/features/car/presentation/riverpod/brand_cars.dart';
import 'package:kcars/features/car/presentation/riverpod/car_types.dart';
import 'package:kcars/features/car/presentation/views/brands_content.dart';
import 'package:kcars/features/company/presentation/riverpod/cities.dart';

class Brands extends HookConsumerWidget {
  const Brands({super.key, required this.onSelect, this.selectedBrand});
  final Function(Brand) onSelect;
  final Brand? selectedBrand;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    final types = ref.watch(brandCarsProvider);
    return switch (types) {
      AsyncData(:final value) => ListView.builder(
        itemCount: value.length,
        itemBuilder: (_, index) => CustomTile(
          title: value[index].getTitle(locale),
          isSelected: selectedBrand?.id == value[index].id,
          onTap: () {
            onSelect(value[index]);
            Navigator.pop(context);
          },
        ),
      ),
      AsyncLoading() => CustomTile(title: "Toyota", isSkeleton: true),
      _ => const Text("Error"),
    };
  }
}

class CarTypesView extends HookConsumerWidget {
  const CarTypesView({super.key, required this.onSelect, this.selectedType});
  final Function(CarType) onSelect;
  final CarType? selectedType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    final types = ref.watch(carTypesProvider);
    return switch (types) {
      AsyncData(:final value) => ListView.builder(
        itemCount: value.length,
        itemBuilder: (_, index) => CustomTile(
          title: value[index].getTitle(locale),
          isSelected: selectedType?.id == value[index].id,
          onTap: () {
            onSelect(value[index]);
            Navigator.pop(context);
          },
        ),
      ),
      AsyncError(:final error) => Text(error.toString()),
      _ => CustomTile(title: "Sedan", isSkeleton: true),
    };
  }
}

class CityViews extends HookConsumerWidget {
  const CityViews({super.key, this.cityId, this.onSelect});

  final String? cityId;
  final Function(City)? onSelect;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    final cities = ref.watch(citiesProvider);

    return switch (cities) {
      AsyncData(:final value) => ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          final city = value[index];
          return CustomTile(
            isSelected: cityId == city.id,
            title: city.getTitle(locale),
            onTap: () {
              onSelect?.call(city);
              Navigator.pop(context);
            },
          );
        },
      ),
      AsyncError(:final error) => Text(error.toString()),
      _ => const Center(child: Text("....")),
    };
  }
}

class TownsViwe extends HookWidget {
  const TownsViwe({super.key, required this.towns, this.townId, this.onSelect});
  final List<Town> towns;
  final String? townId;
  final Function(Town)? onSelect;
  @override
  Widget build(BuildContext context) {
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);

    return ListView.builder(
      itemCount: towns.length,
      itemBuilder: (context, index) {
        final town = towns[index];
        return CustomTile(
          isSelected: townId == town.id,
          title: town.getTitle(locale),
          onTap: () {
            onSelect?.call(town);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
