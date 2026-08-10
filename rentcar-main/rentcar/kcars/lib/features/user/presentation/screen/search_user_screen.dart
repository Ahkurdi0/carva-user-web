import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/search_feild.dart';
import 'package:kcars/features/user/presentation/riverpod/search_user.dart';
import 'package:kcars/features/user/presentation/screen/users_screen.dart';

@RoutePage()
class SearchUserScreen extends HookConsumerWidget {
  const SearchUserScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchData = ref.watch(searchUsersProvider);
    final controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: SearchFeild(
          controller: controller,
          isLoading: searchData.isLoading,
          onChanged: (p0) {
            if (controller.text.length <= 2) return;
            ref
                .read(searchUsersProvider.notifier)
                .searchForUsers(controller.text);
          },
          hint: "Search ....",
        ),
        leading: CustomBackButton(),
      ),
      body: searchData.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => UsersWidget(profile: data[index]),
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
