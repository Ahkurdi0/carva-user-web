import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/custom_tabbar.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/presentation/riverpod/companies.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class CompaniesScreen extends ConsumerWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(LocaleKeys.screens_companies.tr()),
              leading: CustomBackButton(),
            ),
          ],
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                CustomTabbar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: LocaleKeys.tabViews_active.tr()),
                    Tab(text: LocaleKeys.tabViews_expired.tr()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [CompanyView(), CompanyView(expired: true)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompanyView extends ConsumerWidget {
  const CompanyView({super.key, this.expired = false});
  final bool expired;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(companiesProvider(expired));
    return PagingSliverList(
      onLoadMore: () =>
          ref.read(companiesProvider(expired).notifier).loadMore(),
      onRefresh: () =>
          ref.read(companiesProvider(expired).notifier).loadInitial(),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
      ).copyWith(bottom: 40.w, top: 4.w),
      state: state,
      itemBuilder: (context, item, index) => CompaniesWidget(company: item),
    );
  }
}

class CompaniesWidget extends ConsumerWidget {
  const CompaniesWidget({super.key, required this.company});
  final Company company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showCustomBottomSheet(
          context,
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(LocaleKeys.buttons_editCompany.tr()),
                onTap: () {
                  context.router.push(
                    NewEditCompanyRoute(
                      profile: company.profile!,
                      company: company,
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(LocaleKeys.buttons_company.tr()),
                onTap: () {
                  context.router.push(
                    CompanyDetailsRoute(companyId: company.id),
                  );
                },
              ),
              ListTile(
                title: Text(LocaleKeys.buttons_Slider.tr()),
                onTap: () {
                  context.router.push(
                    NewSliderRoute(
                      companyId: company.id,
                      type: SlideType.company,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4.w),
        decoration: BoxDecoration(
          color: context.secondaryContainer,
          borderRadius: BorderRadius.circular(4.w),
        ),

        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ImageHolder(
                        image: company.image,
                        width: 12.w,
                        height: 12.w,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(100.w),
                      ),
                      Gap(2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(company.name, style: context.labelSemiBold),
                          Text(
                            company.joinedAt?.formatDate(context) ?? "",
                            style: context.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(1.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      company.serial?.forMatNumber() ?? "0",
                      style: context.caption,
                    ),
                    Text(
                      company.companyId?.formatOrderId() ?? "",
                      style: context.caption,
                    ),
                  ],
                ),
              ],
            ),
            Gap(1.w),
            Row(
              children: [
                Text(
                  company.activeDate?.formatDate2(context) ?? "",
                  style: context.caption,
                ),
                Text(" - "),
                Text(
                  company.expiresAt?.formatDate2(context) ?? "",
                  style: context.caption,
                ),
              ],
            ),
            Gap(2.w),
            GestureDetector(
              onTap: () => {
                if (company.profile != null)
                  {
                    context.router.push(
                      UserDetailsRoute(profile: company.profile!),
                    ),
                  },
              },
              child: Row(
                children: [
                  ImageHolder(
                    image: company.profile?.image,
                    width: 6.w,
                    height: 6.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(100.w),
                  ),
                  Gap(2.w),
                  Text(company.profile?.name ?? "", style: context.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
