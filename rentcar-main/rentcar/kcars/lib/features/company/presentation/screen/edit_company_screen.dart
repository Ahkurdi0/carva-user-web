import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/core/widget/new_edit_image.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/car/data/model/town.dart';
import 'package:kcars/features/car/presentation/riverpod/my_company.dart';
import 'package:kcars/features/company/application/company_controller.dart';
import 'package:kcars/features/company/application/company_states.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/location.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:kcars/features/company/presentation/riverpod/towns.dart';
import 'package:kcars/features/company/presentation/screen/company_details_screen_screen.dart';
import 'package:kcars/features/company/presentation/views/profile_picture.dart';
import 'package:kcars/features/company/presentation/views/town_goverment_brand_types.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class EditCompanyScreen extends StatefulHookConsumerWidget {
  const EditCompanyScreen({super.key});

  @override
  ConsumerState<EditCompanyScreen> createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends ConsumerState<EditCompanyScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _contactController;
  late bool? available;
  late DateTime? expiredAt;
  late DateTime? joinedAt;
  late List<Contact>? contacts;
  late Location? location;
  late int? cars;
  late Company? currentCompany;
  bool _isLoading = true;
  late Town? town;
  late City? city;
  List<Contact> deletedContacts = [];
  List<Contact> newContacts = [];
  late LatLng? latLong;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _contactController = TextEditingController();

    _initializeCompanyData();
  }

  Future<void> _initializeCompanyData() async {
    currentCompany = await ref.read(myCompanyProvider.future);
    _nameController.text = currentCompany?.name ?? "";
    _descController.text = currentCompany?.desc ?? "";
    _contactController.text = currentCompany?.contact ?? "";
    available = currentCompany?.available == true ? true : false;
    joinedAt = currentCompany?.joinedAt;
    contacts = [...?currentCompany?.contacts];
    expiredAt = currentCompany?.expiresAt?.toLocal();
    location = currentCompany?.location;
    cars = currentCompany?.cars;
    city = currentCompany?.location?.city;
    town = currentCompany?.location?.town;
    latLong = location?.lat == null
        ? null
        : LatLng(location?.lat ?? 0, location?.long ?? 0);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void onSelectMap(TapPosition tap, LatLng ltlg) {
    latLong = ltlg;
    location = location?.copyWith(lat: ltlg.latitude, long: ltlg.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final locale = useMemoized(() => context.locale.toLanguageTag(), []);
    final newImage = useState<File?>(null);
    final coverImage = useState<File?>(null);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final companyController = ref.watch(companyControllerProvider);

    ref.listen(companyControllerProvider, (prev, next) {
      if (next is UpdateCompanyFailed) {
        showMessages(context, message: next.message);
      }
      if (next is UpdateCompanyCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_updated.tr());
        context.maybePop();
      }
    });
    final towns = ref.watch(townsProvider(_isLoading ? null : city?.id));

    return Scaffold(
      appBar: AppBar(leading: CustomBackButton()),
      body: _isLoading
          ? LoadingWidget()
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ).copyWith(bottom: 10.w),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 3.w,
                  children: [
                    NewEditImage(
                      key: ValueKey(coverImage.value ?? "cover"),
                      image: currentCompany?.coverImage,
                      width: 100.w,
                      height: 46.w,
                      padding: EdgeInsets.zero,
                      fit: BoxFit.cover,
                      selectedImage: coverImage.value?.path,
                      onTap: () async {
                        final image = await selectImageWithPermissionPrompt(
                          context,
                        );
                        if (image != null) {
                          coverImage.value = image;
                        }
                      },
                    ),
                    Row(
                      children: [
                        ProfilePicture(
                          key: ValueKey(newImage.value ?? "profile"),
                          currentCompany?.image,
                          width: 24.w,
                          height: 24.w,
                          assetImage: newImage.value,
                          onTap: () async {
                            final image = await selectImageWithPermissionPrompt(
                              context,
                            );
                            if (image != null) {
                              newImage.value = image;
                            }
                          },
                        ),
                        Gap(8.w),
                        StatisticsWidgt(
                          value: currentCompany?.cars?.forMatNumber() ?? "0",
                          label: LocaleKeys.labels_carP
                              .plural(currentCompany?.cars ?? 0)
                              .tr(),
                        ),
                      ],
                    ),
                    Gap(4.w),
                    AppTextField(
                      label: LocaleKeys.inputLabels_name.tr(),
                      controller: _nameController,
                    ),
                    AppTextField(
                      label: LocaleKeys.inputLabels_description.tr(),
                      controller: _descController,
                      showCounterText: true,
                      multiLine: true,
                      maxLength: 600,
                      maxHeight: 50.w,
                    ),
                    AppTextField(
                      label: LocaleKeys.inputLabels_whatsapp.tr(),
                      controller: _contactController,
                      maxLength: 20,
                      hint: "96475XXXXXXXXXX",
                      helperText: LocaleKeys.helpers_countryCode.tr(),
                    ),
                    Gap(2.w),
                    AppTextField(
                      readOnly: true,
                      initialValue:
                          city?.getTitle(locale) ??
                          LocaleKeys.labels_selectACity.tr(),
                      key: ValueKey(city?.id ?? "City"),
                      label: LocaleKeys.inputLabels_city.tr(),
                      onTap: () {
                        showCustomBottomSheet(
                          context,
                          CityViews(
                            cityId: city?.id,
                            onSelect: (selectedCity) {
                              city = selectedCity;
                              location = location?.copyWith(
                                cityId: selectedCity.id,
                                city: selectedCity,
                              );
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
                    AppTextField(
                      readOnly: true,
                      initialValue:
                          town?.getTitle(locale) ??
                          LocaleKeys.labels_selectTownOptional.tr(),
                      key: ValueKey(town?.id ?? "Town"),
                      label: LocaleKeys.inputLabels_town.tr(),
                      onTap: () {
                        showCustomBottomSheet(
                          context,
                          TownsViwe(
                            towns: towns ?? [],
                            townId: town?.id,
                            onSelect: (selectedTown) {
                              final isSame = selectedTown.id == town?.id;
                              town = isSame ? null : selectedTown;
                              location = location?.copyWith(
                                townId: isSame ? null : selectedTown.id,
                                town: isSame ? null : selectedTown,
                              );
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
                    if (contacts != null) ...[
                      ...contacts
                              ?.map(
                                (contact) => ListTile(
                                  dense: true,
                                  title: Text(contact.value ?? ""),
                                  trailing: IconButton(
                                    onPressed: () {
                                      if (contact.id != "") {
                                        deletedContacts.add(contact);
                                      }

                                      final cc =
                                          contacts?.indexOf(contact) ?? -1;

                                      if (cc != -1) {
                                        contacts?.removeAt(cc);
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(Icons.close, size: 6.w),
                                  ),
                                ),
                              )
                              .toList() ??
                          [],
                      if (contacts!.length < 5)
                        TertiaryButton(
                          title: LocaleKeys.buttons_addContact.tr(),
                          onPress: () async {
                            final newContact = await context.router.push(
                              NewEditContactRoute(),
                            );
                            if (newContact != null) {
                              newContacts.add(newContact as Contact);
                              contacts?.add(newContact);
                              setState(() {});
                            }
                          },
                        ),
                    ],
                    Gap(2.w),
                    Column(
                      children: [
                        SecondaryButton(
                          text: latLong == null
                              ? LocaleKeys.buttons_setLocation.tr()
                              : LocaleKeys.buttons_changeLocation.tr(),
                          onPress: () {
                            context.router.push(
                              PickUpMapRoute(
                                company: currentCompany,
                                onSelect: onSelectMap,
                                type: MapMarkerType.company,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Gap(4.w),
                    PrimaryButton(
                      text: LocaleKeys.buttons_update.tr(),
                      isLoading: companyController is UpdateCompanyLoading,
                      onPress: () {
                        if (!formKey.currentState!.validate()) return;

                        final currentData = Company(
                          id: "",
                          name: _nameController.text == currentCompany?.name
                              ? ""
                              : _nameController.text,
                          desc: _descController.text == currentCompany?.desc
                              ? ""
                              : _descController.text,
                          location: Location(
                            id: "",
                            town: null,
                            city: null,
                            lat: location?.lat == currentCompany?.location?.lat
                                ? -1
                                : location!.lat,
                            long:
                                location?.long == currentCompany?.location?.long
                                ? -1
                                : location!.long,
                            cityId:
                                location?.cityId ==
                                    currentCompany?.location?.cityId
                                ? null
                                : location?.cityId,
                            townId:
                                location?.townId ==
                                    currentCompany?.location?.townId
                                ? null
                                : location?.townId,
                            createdAt: null,
                            radiusKm: null,
                          ),
                          contact:
                              _contactController.text == currentCompany?.contact
                              ? null
                              : _contactController.text,
                        );

                        if (currentCompany == null) return;

                        ref
                            .read(companyControllerProvider.notifier)
                            .updateCompany(
                              PostCompany(
                                deletedContacts: deletedContacts,
                                newContacts: newContacts,
                                company: currentData,
                                location: location,
                                image: newImage.value,
                                coverImage: coverImage.value,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
