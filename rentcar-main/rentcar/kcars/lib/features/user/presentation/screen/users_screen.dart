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
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/presentation/riverpod/banned_users.dart';
import 'package:kcars/features/user/presentation/riverpod/user_options_provider.dart';
import 'package:kcars/features/user/presentation/riverpod/users.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (headerSliverBuilder, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(LocaleKeys.screens_users.tr()),
              leading: CustomBackButton(),
              actions: [
                IconButton(
                  onPressed: () {
                    context.router.push(const SearchUserRoute());
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ],
          body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                CustomTabbar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: [
                    Tab(text: LocaleKeys.tabViews_uesrs.tr()),
                    Tab(text: LocaleKeys.tabViews_admins.tr()),
                    Tab(text: LocaleKeys.tabViews_banned.tr()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      UserView(role: "user"),
                      UserView(role: "admin"),
                      BannedUserView(),
                    ],
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

class UserView extends ConsumerWidget {
  const UserView({super.key, required this.role});
  final String role;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider(role));

    return PagingSliverList(
      padding: EdgeInsets.only(bottom: 40.w, top: 4.w),
      onLoadMore: () =>
          ref.read(usersProvider(role).notifier).loadMore(users.items.last.id),
      onRefresh: () => ref.read(usersProvider(role).notifier).loadInitial(),
      state: users,
      itemBuilder: (context, profile, index) => UsersWidget(profile: profile),
    );
  }
}

class BannedUserView extends ConsumerWidget {
  const BannedUserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(bannedUsersProvider);
    return PagingSliverList(
      padding: EdgeInsets.only(bottom: 40.w, top: 4.w),
      onLoadMore: () =>
          ref.read(bannedUsersProvider.notifier).loadMore(users.items.last.id),
      onRefresh: () => ref.read(bannedUsersProvider.notifier).loadInitial(),
      state: users,
      itemBuilder: (context, profile, index) => UsersWidget(profile: profile),
    );
  }
}

class UsersWidget extends ConsumerWidget {
  const UsersWidget({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () =>
          context.router.push(UserDetailsRoute(profile: profile)),
      onTap: () {
        showCustomBottomSheet(context, OptionsContent(profile: profile));
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ImageHolder(
                        image: profile.image,
                        width: 12.w,
                        height: 12.w,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(100.w),
                      ),
                      Gap(2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.name, style: context.labelSemiBold),
                          Text(
                            profile.joinedAt?.formatDate(context) ?? "",
                            style: context.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(1.w),
                Text(
                  profile.serial?.forMatNumber() ?? "0",
                  style: context.caption,
                ),
              ],
            ),
            Gap(2.w),
            if (profile.company != null)
              Row(
                children: [
                  ImageHolder(
                    image: profile.company?.image,
                    width: 6.w,
                    height: 6.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(100.w),
                  ),
                  Gap(2.w),
                  Text(profile.company?.name ?? "", style: context.caption),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class OptionsContent extends ConsumerWidget {
  const OptionsContent({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admiUseroOptions = ref.watch(adminUserOptionsScreenProvider(profile));

    return ListView.builder(
      shrinkWrap: true,
      itemCount: admiUseroOptions.length,
      itemBuilder: (context, index) {
        return admiUseroOptions[index].child;
      },
    );
  }
}
