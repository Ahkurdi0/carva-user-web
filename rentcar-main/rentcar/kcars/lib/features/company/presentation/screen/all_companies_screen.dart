import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/app_bar.dart';
import 'package:kcars/core/widget/custom_tabbar.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/core/widget/profile_container.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/presentation/riverpod/all_companies.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class AllCompaniesScreen extends HookConsumerWidget {
  const AllCompaniesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lcoale = useMemoized(() => context.locale.toLanguageTag(), []);
    return Scaffold(
      appBar: HomeAppBar(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            CustomTabbar(
              tabAlignment: TabAlignment.fill,
              key: ValueKey(lcoale),
              tabs: [
                Tab(text: LocaleKeys.tabViews_local.tr()),
                Tab(text: LocaleKeys.tabViews_international.tr()),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [AllCompaniesView(), AllCompaniesView(inl: true)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllCompaniesView extends ConsumerWidget {
  const AllCompaniesView({super.key, this.inl = false});
  final bool inl;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesAsync = ref.watch(allCompaniesProvider(inl));
    return GridPagingSliverList(
      emptyMessage: LocaleKeys.empty_emptyCompany.tr(),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
      ).copyWith(bottom: 26.w, top: 4.w),
      onRefresh: () =>
          ref.read(allCompaniesProvider(inl).notifier).loadInitial(),
      onLoadMore: () => ref.read(allCompaniesProvider(inl).notifier).loadMore(),
      state: companiesAsync,
      itemBuilder: (context, item, index) {
        return CompanyWidget(company: item);
      },
    );
  }
}

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({super.key, required this.company});
  final Company company;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(CompanyDetailsRoute(companyId: company.id));
      },
      child: Material(
        clipBehavior: Clip.hardEdge,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(14.w),
          side: BorderSide(color: context.surfaceContainer, width: 0.3),
        ),
        child: ColoredBox(
          color: context.secondaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32.w,
                child: Stack(
                  children: [
                    ImageHolder(
                      aspectRation: 16 / 9,
                      padding: EdgeInsets.zero,
                      fit: BoxFit.cover,
                      image: company.coverImage,
                      height: 24.w,
                      width: 100.w,
                      borderRadius: BorderRadius.zero,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ProfileContainer(
                          child: ImageHolder(
                            width: 20.w,
                            height: 20.w,
                            image: company.image,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(100.w),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1.w),
                child: Text(
                  company.name,
                  style: context.labelSemiBold,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
