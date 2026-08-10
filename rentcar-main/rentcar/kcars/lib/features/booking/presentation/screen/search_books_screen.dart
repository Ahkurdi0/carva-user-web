import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/search_feild.dart';
import 'package:kcars/features/booking/data/model/book_cursor.dart';
import 'package:kcars/features/booking/presentation/riverpod/search_books.dart';
import 'package:kcars/features/company/presentation/screen/company_booked_screen.dart';
import 'package:kcars/translations/locale_keys.g.dart';

@RoutePage()
class SearchBooksScreen extends HookConsumerWidget {
  const SearchBooksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchData = ref.watch(searchBooksProvider);
    final controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: SearchFeild(
          controller: controller,
          isLoading: searchData.isLoading,
          onChanged: (p0) {
            if (controller.text.length <= 2) return;
            ref
                .read(searchBooksProvider.notifier)
                .searchForUsers(controller.text);
          },
          hint: LocaleKeys.inputHintText_searchBooks.tr(),
        ),
        leading: CustomBackButton(),
      ),
      body: searchData.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => BookedCarCard(
              book: data[index],
              param: BookCursor(),
              showStatus: true,
            ),
          );
        },
        error: (err, _) => Center(child: Text(err.toString())),
        loading: () => Text("...."),
        skipError: true,
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
      ),
    );
  }
}
