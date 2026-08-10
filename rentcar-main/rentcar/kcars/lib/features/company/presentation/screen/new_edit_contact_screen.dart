import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/app_textfeild.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/buttons.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class NewEditContactScreen extends HookConsumerWidget {
  const NewEditContactScreen({super.key, this.contact});
  final Contact? contact;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = useTextEditingController(text: contact?.value);
    final available = useState(contact?.available ?? true);
    final formKey = useMemoized(() => GlobalKey<FormState>(), []);
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ).copyWith(top: 4.w, bottom: 10.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                controller: value,
                isPhoneNumber: true,
                label: LocaleKeys.inputLabels_phoneNumber.tr(),
                hint: "7XXxxxxxxx",
                keyboardType: TextInputType.number,
                validator: (value) => value!.length >= 10
                    ? null
                    : LocaleKeys.validations_phone.tr(),
              ),

              Gap(4.w),
              PrimaryButton(
                text: contact == null
                    ? LocaleKeys.buttons_add.tr()
                    : LocaleKeys.buttons_update.tr(),
                onPress: () {
                  if (!formKey.currentState!.validate()) return;

                  final data = (contact ?? Contact(id: "")).copyWith(
                    value: value.text,
                    available: available.value,
                  );
                  context.maybePop(data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
