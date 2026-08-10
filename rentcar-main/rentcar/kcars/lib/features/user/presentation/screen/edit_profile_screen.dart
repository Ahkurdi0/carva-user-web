import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/core/widget/custom_alert.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_states.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserControllerProvider);
    ref.listen(authControllerProvider, (prev, next) {
      if (next is UpdateNameCompleted ||
          next is UpdatePhoneCompleted ||
          next is UpdatePasswordCompleted ||
          next is UpdateEmailVerifyOtpCompleted) {
        showMessages(context, message: LocaleKeys.alertMessages_updated.tr());
        context.maybePop();
      }
      if (next is UpdateNameFailed) {
        showMessages(context, message: next.message);
      }
      if (next is UpdatePasswordFailed) {
        showMessages(context, message: next.message);
      }
      if (next is UpdatePhoneFailed) {
        showMessages(context, message: next.message);
      }
      if (next is UpdateEmailSendOtpFailed) {
        showMessages(context, message: next.message);
      }
      if (next is UpdateEmailVerifyOtpFailed) {
        showMessages(context, message: next.message);
      }
    });

    final name = useTextEditingController(text: profile.name);
    final email = useTextEditingController(text: profile.email);
    final code = useTextEditingController();
    final oldPassword = useTextEditingController();
    final newPassword = useTextEditingController();
    final phoneNumber = useTextEditingController(text: profile.phoneNumber);
    final expandedIndex = useState<int?>(null);
    final auth = ref.watch(authControllerProvider);

    final settings = useMemoized<List<SettingsModel>>(
      () => [
        SettingsModel(
          label: LocaleKeys.inputLabels_name.tr(),
          children: [
            AppTextField(
              controller: name,
              hint: LocaleKeys.inputHintText_yourName.tr(),
            ),
            Gap(2.w),
            PrimaryButton(
              height: 10.w,
              width: 40.w,
              text: LocaleKeys.buttons_update.tr(),
              isLoading: auth is UpdateNameLoading,
              onPress: () {
                if (profile.name == name.text) {
                  showMessages(
                    context,
                    message: LocaleKeys.alertMessages_diffName.tr(),
                  );
                  return;
                }
                if (name.text.length >= 3) {
                  ref
                      .read(authControllerProvider.notifier)
                      .updateName(Auth(name: name.text));
                }
              },
            ),
          ],
        ),
        SettingsModel(
          label: LocaleKeys.inputLabels_email.tr(),
          children: [
            AppTextField(
              readOnly:
                  auth is UpdateEmailSendOtpCompleted ||
                  auth is UpdateEmailSendOtpLoading,
              controller: email,
              hint: "example@gmail.com",
            ),
            Gap(2.w),
            ...[
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child:
                    (auth is UpdateEmailSendOtpCompleted ||
                        auth is UpdateEmailVerifyOtpLoading ||
                        auth is UpdateEmailVerifyOtpFailed)
                    ? AppTextField(
                        readOnly: auth is UpdateEmailVerifyOtpLoading,
                        controller: code,
                        hint: "XXXXXX",
                        maxLength: 6,
                        helperText: LocaleKeys.auth_verify_codeSent.tr(),
                      )
                    : SizedBox.shrink(),
              ),
            ],
            Gap(2.w),
            PrimaryButton(
              height: 10.w,
              width: 40.w,
              isLoading:
                  auth is UpdateEmailSendOtpLoading ||
                  auth is UpdateEmailVerifyOtpLoading,
              text: auth is UpdateEmailSendOtpCompleted
                  ? LocaleKeys.buttons_verify.tr()
                  : LocaleKeys.buttons_continue.tr(),
              onPress: () {
                if (!email.text.isValidEmail()) {
                  showMessages(
                    context,
                    message: LocaleKeys.validations_invalidEmail.tr(),
                  );
                  return;
                }
                if (auth is UpdateEmailSendOtpCompleted &&
                    code.text.length != 6) {
                  showMessages(
                    context,
                    message: LocaleKeys.validations_otp.tr(),
                  );
                  return;
                }
                if (email.text == profile.email) {
                  showMessages(
                    context,
                    message: LocaleKeys.alertMessages_diffEmail.tr(),
                  );
                  return;
                }
                if (auth is UpdateEmailSendOtpCompleted) {
                  ref
                      .read(authControllerProvider.notifier)
                      .updateEmailVerifyOtp(
                        Auth(email: email.text, code: code.text),
                      );
                } else {
                  ref
                      .read(authControllerProvider.notifier)
                      .updateEmailSendOtp(Auth(email: email.text));
                }
              },
            ),
          ],
        ),
        SettingsModel(
          label: LocaleKeys.inputLabels_password.tr(),
          children: [
            AppTextField(
              label: LocaleKeys.inputLabels_previousPassword.tr(),
              isPassword: true,
              controller: oldPassword,
              hint: "••••••••",
            ),
            Gap(2.w),
            AppTextField(
              label: LocaleKeys.inputLabels_newPassword.tr(),
              isPassword: true,
              controller: newPassword,
              hint: "••••••••",
            ),
            Gap(2.w),
            PrimaryButton(
              isLoading: auth is UpdatePasswordLoading,
              width: 40.w,
              height: 10.w,
              text: LocaleKeys.buttons_update.tr(),
              onPress: () {
                if (newPassword.text.length < 8 ||
                    oldPassword.text.length < 8) {
                  showMessages(
                    context,
                    message: LocaleKeys.validations_password.tr(),
                  );
                  return;
                }
                if (newPassword.text == oldPassword.text) {
                  showMessages(
                    context,
                    message: LocaleKeys.alertMessages_diffPassword.tr(),
                  );
                  return;
                }
                ref
                    .read(authControllerProvider.notifier)
                    .updatePassword(
                      Auth(
                        oldPassword: oldPassword.text,
                        password: newPassword.text,
                      ),
                    );
              },
            ),
          ],
        ),
        SettingsModel(
          label: LocaleKeys.inputLabels_phoneNumber.tr(),

          children: [
            AppTextField(
              isPhoneNumber: true,
              controller: phoneNumber,
              hint: "7XXxxxxxxx",
              keyboardType: TextInputType.number,
            ),
            Gap(2.w),
            PrimaryButton(
              isLoading: auth is UpdatePhoneLoading,
              height: 10.w,
              width: 40.w,
              text: LocaleKeys.buttons_update.tr(),

              onPress: () {
                if (phoneNumber.text.length < 10) {
                  showMessages(
                    context,
                    message: LocaleKeys.validations_phone.tr(),
                  );
                  return;
                }
                if (phoneNumber.text == profile.phoneNumber) {
                  showMessages(
                    context,
                    message: LocaleKeys.alertMessages_diffPhone.tr(),
                  );
                  return;
                }
                ref
                    .read(authControllerProvider.notifier)
                    .updatePhoneNumber(
                      Auth(
                        phoneNumber: phoneNumber.text,
                        countryCode: profile.countryCode,
                      ),
                    );
              },
            ),
          ],
        ),
      ],
      [auth],
    );

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          ref.invalidate(authControllerProvider);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.screens_editProflie.tr()),
          leading: CustomBackButton(
            onPressed: () {
              ref.invalidate(authControllerProvider);
              context.maybePop();
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(authControllerProvider.notifier).refreesh(isCheking: true);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
            ).copyWith(top: 2.w, bottom: 20.w),

            child: user.when(
              data: (data) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: settings.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MyControlledExpansionTile(
                      title: Text(settings[index].label),
                      isExpanded: expandedIndex.value == index,
                      onExpansionChanged: (expanded) {
                        expandedIndex.value = expanded ? index : null;
                      },
                      children: settings[index].children,
                    );
                  },
                );
              },
              error: (error, trace) => Center(child: Text(error.toString())),
              loading: () => Center(child: Text("....")),
            ),
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
    this.children = const [],
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.isEnabled,
    this.onCloseRequested,
  });

  final String lable;
  final List<Widget> children;
  final bool isExpanded;
  final bool isEnabled;
  final ValueChanged<bool> onExpansionChanged;
  final VoidCallback? onCloseRequested;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled && !isExpanded,
      child: ExpansionTile(
        maintainState: true,
        initiallyExpanded: isExpanded,
        childrenPadding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 2.w, bottom: 4.w),
        onExpansionChanged: (expanded) {
          if (isEnabled || isExpanded) {
            onExpansionChanged(expanded);
          }
        },
        shape: ContinuousRectangleBorder(
          side: BorderSide(width: 1, color: context.surfaceContainerLow),
          borderRadius: BorderRadius.circular(10.w),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        title: Text(lable),
        children: children,
      ),
    );
  }
}

class SettingsModel {
  final String label;
  final List<Widget> children;

  SettingsModel({required this.label, required this.children});
}

class MyControlledExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;

  const MyControlledExpansionTile({
    super.key,
    required this.title,
    required this.children,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  State<MyControlledExpansionTile> createState() =>
      _MyControlledExpansionTileState();
}

class _MyControlledExpansionTileState extends State<MyControlledExpansionTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (widget.isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MyControlledExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onExpansionChanged(!widget.isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.w),
      child: Material(
        shape: ContinuousRectangleBorder(
          side: BorderSide(width: 2, color: context.surfaceContainerLow),
          borderRadius: BorderRadius.circular(10.w),
        ),
        clipBehavior: Clip.hardEdge,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Column(
            children: [
              ListTile(
                title: widget.title,
                splashColor: Colors.transparent,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotationTransition(
                      turns: Tween<double>(
                        begin: 0,
                        end: 0.5,
                      ).animate(_controller),
                      child: const Icon(Icons.expand_more),
                    ),
                  ],
                ),

                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _handleTap();
                },
              ),

              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipRect(
                    child: Align(
                      heightFactor: _heightFactor.value,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ).copyWith(bottom: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: widget.children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
