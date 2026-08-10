import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/date_year_picker.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/company/application/company_controller.dart';
import 'package:kcars/features/company/application/company_states.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/location.dart';
import 'package:kcars/features/company/presentation/riverpod/towns.dart';
import 'package:kcars/features/company/presentation/views/town_goverment_brand_types.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewEditCompanyScreen extends HookConsumerWidget {
  const NewEditCompanyScreen({super.key, this.company, required this.profile});
  final Company? company;
  final Profile profile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = useMemoized(() => context.locale.toLanguageTag());
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    final name = useTextEditingController(text: company?.name);
    final desc = useTextEditingController(text: company?.desc);
    final whatsApp = useTextEditingController(text: company?.contact);
    final inl = useState(company?.international ?? false);

    final activeDate = useState(company?.activeDate ?? DateTime.now());
    final expresDate = useState(
      company?.expiresAt ?? DateTime.now().add(Duration(days: 30)),
    );

    final location = useState(
      Location(
        lat: company?.location?.lat ?? -1,
        long: company?.location?.long ?? -1,
      ),
    );
    final city = useState(company?.location?.city);
    final town = useState(company?.location?.town);
    final available = useState(company?.available ?? true);
    final latLong = useState<LatLng?>(
      company?.location?.lat == null
          ? null
          : LatLng(company?.location?.lat ?? 0, company?.location?.long ?? 0),
    );

    void onSelectMap(TapPosition tap, LatLng ltlg) {
      latLong.value = ltlg;
      location.value = (location.value).copyWith(
        lat: ltlg.latitude,
        long: ltlg.longitude,
      );
    }

    ref.listen(companyControllerProvider, (prev, next) {
      if (next is NewCompanyFailed) {
        showMessages(context, message: next.message);
      }
      if (next is NewCompanyCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_success.tr());
        context.maybePop();
      }
    });

    final towns = ref.watch(townsProvider(city.value?.id));

    final controller = ref.watch(companyControllerProvider);
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 2.w,
            children: [
              AppTextField(
                controller: name,
                label: LocaleKeys.inputLabels_name.tr(),
              ),
              AppTextField(
                controller: desc,
                multiLine: true,
                maxLength: 600,
                label: LocaleKeys.inputLabels_description.tr(),
                validator: (value) => null,
              ),
              AppTextField(
                controller: whatsApp,
                multiLine: true,
                label: LocaleKeys.inputLabels_whatsapp.tr(),
                hint: "96475Xxxxxxxx",
                helperText: LocaleKeys.helpers_countryCode.tr(),
              ),
              AppTextField(
                readOnly: true,
                initialValue: activeDate.value.toLocal().formatDate2(context),
                key: ValueKey(activeDate.value),
                label: LocaleKeys.labels_activeDate.tr(),
                validator: (value) => null,
                onTap: () async {
                  final date = await showDateYearPicker(context);
                  if (date != null) {
                    activeDate.value = date;
                  }
                },
              ),
              AppTextField(
                readOnly: true,
                initialValue: expresDate.value.toLocal().formatDate2(context),
                key: ValueKey(expresDate.value),
                label: LocaleKeys.labels_expireDate.tr(),
                validator: (value) => null,
                onTap: () async {
                  final date = await showDateYearPicker(context);
                  if (date != null) {
                    expresDate.value = date;
                  }
                },
              ),
              AppTextField(
                readOnly: true,
                initialValue:
                    city.value?.getTitle(locale) ??
                    LocaleKeys.labels_selectACity.tr(),
                key: ValueKey(city.value?.id ?? "City"),
                label: LocaleKeys.inputLabels_city.tr(),
                onTap: () {
                  showCustomBottomSheet(
                    context,
                    CityViews(
                      cityId: city.value?.id,
                      onSelect: (selectedCity) {
                        city.value = selectedCity;
                        location.value = location.value.copyWith(
                          cityId: selectedCity.id,
                          city: selectedCity,
                        );
                      },
                    ),
                  );
                },
              ),
              AppTextField(
                readOnly: true,
                initialValue:
                    town.value?.en ?? LocaleKeys.labels_selectTownOptional.tr(),
                key: ValueKey(town.value?.id ?? "Town"),
                label: LocaleKeys.inputLabels_town.tr(),
                onTap: () {
                  showCustomBottomSheet(
                    context,
                    TownsViwe(
                      towns: towns ?? [],
                      townId: town.value?.id,
                      onSelect: (selectedTown) {
                        final isSame = town.value?.id == selectedTown.id;
                        town.value = isSame ? null : selectedTown;
                        location.value = location.value.copyWith(
                          townId: isSame ? null : selectedTown.id,
                          town: isSame ? null : selectedTown,
                        );
                      },
                    ),
                  );
                },
              ),
              Gap(2.w),
              SecondaryButton(
                text: latLong.value == null
                    ? LocaleKeys.buttons_setLocation.tr()
                    : LocaleKeys.buttons_changeLocation.tr(),
                onPress: () {
                  context.router.push(
                    PickUpMapRoute(
                      company: company?.copyWith(
                        location: company?.location?.copyWith(
                          lat: latLong.value?.latitude,
                          long: latLong.value?.longitude,
                        ),
                      ),
                      onSelect: onSelectMap,
                    ),
                  );
                },
              ),
              CheckboxListTile.adaptive(
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                title: Text(LocaleKeys.buttons_available.tr()),
                value: available.value,
                onChanged: (v) => available.value = v!,
              ),
              CheckboxListTile.adaptive(
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                title: Text(LocaleKeys.buttons_international.tr()),
                value: inl.value,
                onChanged: (v) => inl.value = v!,
              ),
              Gap(4.w),
              PrimaryButton(
                isLoading: controller is NewCompanyLoading,
                text: company == null
                    ? LocaleKeys.buttons_add.tr()
                    : LocaleKeys.buttons_update.tr(),
                onPress: () {
                  if (!formKey.currentState!.validate()) return;
                  if (location.value.lat == -1) {
                    showMessages(
                      context,
                      message: LocaleKeys.buttons_setLocation.tr(),
                    );
                    return;
                  }
                  final newData = Company(
                    id: company?.id ?? "",
                    name: name.text,
                    companyId: company?.companyId,
                    desc: desc.text,
                    joinedAt: company?.joinedAt,
                    international: inl.value,
                    contact: whatsApp.text,
                    location: location.value.copyWith(
                      id: null,
                      town: town.value,
                      city: city.value,
                      lat: location.value.lat,
                      long: location.value.long,
                      cityId: location.value.cityId,
                      townId: location.value.townId,
                      createdAt: null,
                      radiusKm: null,
                    ),
                    profile: profile,
                    activeDate: activeDate.value,
                    expiresAt: expresDate.value,
                    available: available.value,
                  );
                  ref
                      .read(companyControllerProvider.notifier)
                      .newCompany(newData, orginal: company);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
