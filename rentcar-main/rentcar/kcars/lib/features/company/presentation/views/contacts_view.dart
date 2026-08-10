import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/launch_links.dart';
import 'package:kcars/core/widget/icon_loader.dart';
import 'package:kcars/features/booking/presentation/application/book_controller.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/contact_statistic.dart';
import 'package:kcars/features/company/data/model/enums.dart';
import 'package:sizer/sizer.dart';

class ContactsView extends ConsumerWidget {
  const ContactsView({
    super.key,
    required this.contacts,
    required this.companyId,
    this.carId,
  });
  final List<Contact> contacts;
  final String companyId;
  final String? carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20.w),
      itemCount: contacts.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final contact = contacts[index];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.8,
                color: context.surfaceContainerLow,
              ),
            ),
          ),
          child: ListTile(
            onTap: () {
              ref
                  .read(bookControllerProvider.notifier)
                  .contact(
                    ContactStatistic(
                      companyId: companyId,
                      type: contact.type,
                      contactId: contact.id,
                      carId: carId,
                    ),
                  );
              if (contact.type == ContactTypes.phone) {
                openLinks(
                  webLink: "tel://${contact.value}",
                  appLink: "tel://${contact.value}",
                );
              } else {
                openLinks(
                  webLink: "mailto://${contact.value}",
                  appLink: "mailto://${contact.value}",
                );
              }
            },
            splashColor: Colors.transparent,
            leading: IconLoadaer(
              "assets/icons/${contact.type?.name}.svg",
              width: 5.w,
            ),
            title: Text(contact.value ?? "", style: context.label),
          ),
        );
      },
    );
  }
}
