import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/services/app_icons.dart';
import 'package:kcars/core/services/dio_service.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/core/widget/app_bar.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/core/widget/loadin_widget.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:kcars/features/company/presentation/views/profile_picture.dart';
import 'package:kcars/features/user/presentation/riverpod/user_notification.dart';
import 'package:kcars/features/user/presentation/view/supports_view.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserControllerProvider);
    final authController = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (prev, next) {
      if (next is LogoutCompleted || next is DeleteAccountCompleted) {
        context.router.replaceAll([const WelcomeRoute()]);
      }
      if (next is LogoutFailed) {
        showMessages(context, message: next.message);
      }
      if (next is DeleteAccountFailed) {
        showMessages(context, message: next.message);
      }
      if (next is UpdateProfilePicCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_updated.tr());
      }
      if (next is UpdateProfilePicFailed) {
        showMessages(context, message: next.message);
      }
    });

    return Scaffold(
      appBar: HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(authControllerProvider.notifier).refreesh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ).copyWith(top: 4.w, bottom: 20.w),

          child: user.when(
            data: (data) {
              return Column(
                children: [
                  ProfilePicture(
                    data?.image,
                    isLoading: authController is UpdateProfilePicLoading,
                    onTap: () async {
                      final image = await selectImageWithPermissionPrompt(
                        context,
                      );
                      if (image != null) {
                        ref
                            .read(authControllerProvider.notifier)
                            .updateProfilePicture(Auth(image: image.path));
                      }
                    },
                  ),
                  Gap(2.w),
                  Text(data?.name ?? "", style: context.label2SemiBold),
                  Gap(10.w),
                  SettingTile(
                    lable: LocaleKeys.buttons_profile.tr(),
                    icon: AppIcons.edit,
                    onTap: () {
                      context.router.push(EditProfileRoute(profile: data!));
                    },
                  ),
                  Gap(2.w),
                  SettingTile(
                    lable: LocaleKeys.buttons_supprt.tr(),
                    icon: AppIcons.support,
                    onTap: () {
                      showCustomBottomSheet(context, SupportsView());
                    },
                  ),
                  Gap(2.w),
                  SettingTile(
                    lable: LocaleKeys.buttons_language.tr(),
                    icon: AppIcons.language,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return Dialog(
                            clipBehavior: Clip.antiAlias,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(12.w),
                            ),
                            child: LanguagesContent(),
                          );
                        },
                      );
                    },
                  ),
                  Gap(2.w),
                  SettingTile(
                    lable: LocaleKeys.buttons_notification.tr(),
                    icon: AppIcons.notificaton,
                    onTap: () {},
                    trailing: NotificatinView(userId: user.value?.userId ?? ""),
                  ),
                  Gap(2.w),
                  SettingTile(
                    lable: LocaleKeys.buttons_signOut.tr(),
                    icon: AppIcons.logout,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                          child: SignOutContenr(),
                        ),
                      );
                    },
                  ),
                  Gap(2.w),
                  SettingTile(
                    lable: LocaleKeys.buttons_deleteAccount.tr(),
                    icon: AppIcons.trash,
                    onTap: () {
                      showCustomAlert(
                        context,
                        content: LocaleKeys.alertMessages_deleteAccount.tr(),
                        isDeleting: true,
                        primaryAction: () {
                          ref
                              .read(authControllerProvider.notifier)
                              .deleteAccount();
                        },
                      );
                    },
                  ),
                ],
              );
            },
            error: (error, trace) => Center(child: Text(error.toString())),
            loading: () => LoadingWidget(),
          ),
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.lable,
    required this.icon,
    this.onTap,
    this.trailing,
  });
  final String icon;
  final String lable;
  final VoidCallback? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconLoadaer(icon, width: 5.w),
      shape: ContinuousRectangleBorder(
        side: BorderSide(width: 1, color: context.surfaceContainerLow),
        borderRadius: BorderRadius.circular(10.w),
      ),
      onTap: onTap,
      title: Text(lable),
      splashColor: Colors.transparent,
      trailing: trailing,
    );
  }
}

class SignOutContenr extends HookConsumerWidget {
  const SignOutContenr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allDevics = useState(false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.alertMessages_logOut.tr(),
            style: context.label2SemiBold,
            textAlign: TextAlign.center,
          ),
          Gap(2.w),
          CheckboxListTile.adaptive(
            dense: true,
            contentPadding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(LocaleKeys.buttons_allDevices.tr()),
            visualDensity: VisualDensity.compact,
            value: allDevics.value,
            onChanged: (v) => allDevics.value = v!,
          ),
          Gap(4.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SecondaryButton(
                width: 34.w,
                height: 11.w,
                color: context.secondaryContainer,
                borderRadius: BorderRadius.circular(100.w),
                text: LocaleKeys.buttons_close.tr(),
                onPress: () => Navigator.pop(context),
              ),

              PrimaryButton(
                borderRadius: BorderRadius.circular(100.w),
                width: 34.w,
                height: 11.w,
                text: LocaleKeys.buttons_signOut.tr(),
                onPress: () {
                  Navigator.pop(context);
                  ref
                      .read(authControllerProvider.notifier)
                      .logout(Auth(allDevices: allDevics.value));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LanguagesContent extends HookConsumerWidget {
  const LanguagesContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = context.locale.languageCode;
    final changeLang = useMemoized(
      () => (String locale) async {
        if (context.mounted) {
          Navigator.pop(context);
        }
        ref
            .read(authControllerProvider.notifier)
            .updatePrefLang(Auth(prefLang: locale));
        GetIt.instance<DioService>().dio.options.headers["devicelang"] = locale;
        EasyLocalization.of(context)?.setLocale(Locale(locale));
        await OneSignal.User.getTags();
        await OneSignal.User.addTagWithKey("appLang", locale);
      },
      [],
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LanuguageTile(
          title: "کوردی",
          selected: locale == "ku",
          onTap: () => changeLang("ku"),
        ),
        LanuguageTile(
          title: "عربی",
          selected: locale == "ar",
          onTap: () => changeLang("ar"),
        ),
        LanuguageTile(
          title: "English",
          selected: locale == "en",
          onTap: () => changeLang("en"),
        ),
      ],
    );
  }
}

class LanuguageTile extends StatelessWidget {
  const LanuguageTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });
  final String title;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.outline, width: 0.03),
      ),
      child: ListTile(
        splashColor: Colors.transparent,
        title: Text(title, textAlign: TextAlign.center),
        selected: selected,
        onTap: onTap,
        selectedColor: context.primary,
      ),
    );
  }
}

class NotificatinView extends ConsumerWidget {
  const NotificatinView({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationsProvider);

    return notificationState.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Switch.adaptive(value: false, onChanged: (_) {}),
      data: (notification) => Switch.adaptive(
        value: notification.isEnabled,
        onChanged: (value) async {
          final granted = await notificaPermission(context);
          ref
              .read(notificationsProvider.notifier)
              .toggleNotifications(granted, value, userId);
        },
      ),
    );
  }
}
