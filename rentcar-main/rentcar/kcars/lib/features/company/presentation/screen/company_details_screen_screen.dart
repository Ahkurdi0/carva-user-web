import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/launch_links.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/booking/presentation/application/book_controller.dart';
import 'package:kcars/features/booking/presentation/application/book_states.dart';
import 'package:kcars/features/car/presentation/views/company_cars_view.dart';
import 'package:kcars/features/car/presentation/widget/custom_sheet.dart';
import 'package:kcars/features/company/data/model/contact_statistic.dart';
import 'package:kcars/features/company/data/model/enums.dart';
import 'package:kcars/features/company/presentation/riverpod/details_company.dart';
import 'package:kcars/features/company/presentation/views/contacts_view.dart';
import 'package:kcars/features/company/presentation/views/map_viwe.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

@RoutePage()
class CompanyDetailsScreen extends ConsumerWidget {
  const CompanyDetailsScreen({super.key, required this.companyId});
  final String companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyData = ref.watch(detailCompanyProvider(companyId));
    ref.listen(bookControllerProvider, (prev, next) {
      if (next is ContactFailed) {
        showMessages(context, message: next.message);
      }
      if (next is ContactCompleted) {
        if (next.result != null && next.result!.isNotEmpty) {
          openLinks(appLink: next.result!, webLink: next.result!);
        }
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CustomBackButton(),
        forceMaterialTransparency: true,
      ),
      body: companyData.when(
        data: (data) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                MeasuredParallaxHeader(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ).copyWith(top: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 60.w,
                            child: Stack(
                              children: [
                                ImageHolder(
                                  image: data.coverImage,
                                  width: 100.w,
                                  height: 44.w,
                                  borderRadius: BorderRadius.circular(4.w),
                                  fit: BoxFit.cover,
                                ),
                                PositionedDirectional(
                                  bottom: 4.w,
                                  end: 2.w,
                                  child: Row(
                                    children: [
                                      PrimaryButton(
                                        color: context.surfaceTint,
                                        iconColor: context.surface,
                                        textColor: context.surface,
                                        height: 9.w,
                                        width: 33.w,
                                        icon: AppIcons.whatsapp,
                                        text: LocaleKeys.buttons_whatsapp.tr(),
                                        onPress: () {
                                          ref
                                              .read(
                                                bookControllerProvider.notifier,
                                              )
                                              .contact(
                                                ContactStatistic(
                                                  companyId: data.id,
                                                  type: ContactTypes.whatsapp,
                                                ),
                                              );
                                        },
                                      ),
                                      Gap(0.8.w),
                                      PrimaryButton(
                                        iconColor: context.onPrimary,
                                        icon: AppIcons.call,
                                        height: 9.w,
                                        width: 28.w,
                                        text: LocaleKeys.buttons_contact.tr(),
                                        onPress: () {
                                          showSheeet(
                                            context,
                                            ScrollableSheetContent(
                                              showHandle: true,
                                              child: ContactsView(
                                                contacts: data.contacts ?? [],
                                                companyId: data.id,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                PositionedDirectional(
                                  bottom: 3.w,
                                  start: 2.w,
                                  child: Row(
                                    children: [
                                      ProfileContainer(
                                        child: ImageHolder(
                                          image: data.image,
                                          width: 26.w,
                                          height: 26.w,
                                          borderRadius: BorderRadius.circular(
                                            100.w,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Gap(8.w),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(2.w),
                          FittedBox(
                            child: Text(
                              data.name,
                              style: context.title2SemiBold,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "${data.cars?.forMatNumber() ?? "0"} ${LocaleKeys.labels_carP.plural(data.cars ?? 0)}",
                              style: context.caption,
                            ),
                          ),
                          Gap(4.w),
                          Linkify(
                            text: data.desc ?? "",
                            linkStyle: context.caption.copyWith(
                              color: context.primary,
                            ),
                            style: context.caption,
                            onOpen: (link) =>
                                openLinks(appLink: link.url, webLink: link.url),
                          ),
                          if (data.location?.lat != null &&
                              data.location?.long != null) ...[
                            Gap(4.w),
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              height: 36.w,
                              child: MapView(
                                latLang:
                                    data.location?.lat != null &&
                                        data.location?.long != null
                                    ? LatLng(
                                        data.location!.lat,
                                        data.location!.long,
                                      )
                                    : null,
                                image: data.image,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: CompanyCarsView(company: data),
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => LoadingWidget(),
      ),
    );
  }
}

class StatisticsWidgt extends StatelessWidget {
  const StatisticsWidgt({super.key, required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: context.label2.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                label,
                style: context.label.copyWith(color: context.outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MeasuredParallaxHeader extends StatefulWidget {
  final Widget child;

  const MeasuredParallaxHeader({super.key, required this.child});

  @override
  State<MeasuredParallaxHeader> createState() => _MeasuredParallaxHeaderState();
}

class _MeasuredParallaxHeaderState extends State<MeasuredParallaxHeader> {
  double _measuredHeight = 0;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null && mounted) {
          setState(() {
            _measuredHeight = renderBox.size.height;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_measuredHeight == 0) {
      return SliverToBoxAdapter(
        child: Container(key: _key, child: widget.child),
      );
    }

    return SliverPersistentHeader(
      pinned: false,
      delegate: _ParallaxHeaderDelegate(
        height: _measuredHeight,
        child: widget.child,
      ),
    );
  }
}

class _ParallaxHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _ParallaxHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => 0;
  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(covariant _ParallaxHeaderDelegate oldDelegate) =>
      oldDelegate.height != height || oldDelegate.child != child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final offset = -shrinkOffset * 0.3;

    // Calculate opacity (clamped between 0 and 1)
    final opacity = (1 - (shrinkOffset / maxExtent)).clamp(0.0, 1.0);

    return SizedBox(
      height: maxExtent,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: offset,
              left: 0,
              right: 0,
              child: Opacity(opacity: opacity, child: child),
            ),
          ],
        ),
      ),
    );
  }
}
