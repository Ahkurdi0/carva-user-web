import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagin_list_view.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/user/application/user_controller.dart';
import 'package:kcars/features/user/data/model/account_status.dart';
import 'package:kcars/features/user/presentation/riverpod/account_statuses.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class AccountStatusView extends ConsumerWidget {
  final Profile _profile;
  const AccountStatusView(this._profile, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountStatusesProvider(_profile.userId));

    return PagingSliverList(
      onRefresh: () async => await ref
          .read(accountStatusesProvider(_profile.userId).notifier)
          .loadInitial(),
      onLoadMore: () => ref
          .read(accountStatusesProvider(_profile.userId).notifier)
          .loadMore(state.items.last.id),
      state: state,
      itemBuilder: (context, item, index) =>
          AccountStatusWidget(item, _profile),
    );
  }
}

class AccountStatusWidget extends StatelessWidget {
  const AccountStatusWidget(this._accountStatus, this._profile, {super.key});
  final AccountStatus _accountStatus;
  final Profile _profile;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.w),
      child: GestureDetector(
        onTap: () => showCustomBottomSheet(
          context,
          BanContent(_profile, _accountStatus),
        ),
        child: Container(
          color: context.surface,
          padding: EdgeInsets.all(2.w),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.secondaryContainer,
                    child: Icon(Icons.shield, color: context.onSurface),
                  ),
                  SizedBox(width: 2.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _accountStatus.title ?? "",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          _accountStatus.description ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(color: Theme.of(context).colorScheme.secondaryContainer),
              Row(
                children: [
                  Text(
                    _accountStatus.bannedAt?.formatDate2(context),
                    style: context.overline.copyWith(color: context.outline),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    _accountStatus.bannedUntil?.formatDate2(context),
                    style: context.overline.copyWith(color: context.outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BanContent extends ConsumerWidget {
  const BanContent(this._profile, this.accountStatus, {super.key});
  final Profile _profile;
  final AccountStatus accountStatus;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: const Icon(Icons.delete),
          title: Text(LocaleKeys.buttons_delete.tr()),
          onTap: () {
            showCustomAlert(
              context,
              content: LocaleKeys.alertMessages_deleteAccount.tr(),
              isDeleting: true,
              primaryAction: () => {
                Navigator.pop(context),
                ref
                    .read(userControllerProvider.notifier)
                    .deleteBan(accountStatus),
              },
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          onTap: () => context.router.push(
            BanUserRoute(profile: _profile, accountStatus: accountStatus),
          ),
          title: Text(LocaleKeys.buttons_update.tr()),
        ),
      ],
    );
  }
}
