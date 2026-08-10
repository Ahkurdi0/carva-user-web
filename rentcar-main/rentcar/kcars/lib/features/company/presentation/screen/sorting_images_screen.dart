import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/back_button.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/car/application/car_controller.dart';
import 'package:kcars/features/car/data/model/car.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class SortingImageScreen extends HookConsumerWidget {
  const SortingImageScreen({super.key, required this.car});
  final Car car;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = useState(car.images);
    void reorderItems(List<Images> items, int oldIndex, int newIndex) {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final List<Images> updatedList = [...items];

      final Images movedItem = updatedList.removeAt(oldIndex);

      updatedList.insert(newIndex, movedItem);

      for (int i = 0; i < updatedList.length; i++) {
        updatedList[i] = updatedList[i].copyWith(sort: i + 1);
      }
      images.value = updatedList;
      ref.read(carControllerProvider.notifier).sortImages(updatedList, car.id);
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          context.maybePop(images.value);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(
            onPressed: () => Navigator.pop(context, images.value),
          ),
        ),
        body: SizedBox(
          child: ReorderableListView.builder(
            proxyDecorator: (child, index, animation) {
              return AnimatedBuilder(
                key: ValueKey(index),
                animation: animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: 1 - (0.1 * animation.value),
                    child: Material(elevation: 1, child: child),
                  );
                },
                child: child,
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (old, newidx) =>
                reorderItems(images.value!, old, newidx),

            itemBuilder: (context, index) {
              final slider = images.value?[index];
              return ReorderableDragStartListener(
                key: ValueKey(index),
                index: index,
                child: Container(
                  margin: EdgeInsets.only(bottom: 2.w),
                  child: ListTile(
                    trailing: Icon(Icons.menu, size: 4.w),
                    leading: ImageHolder(image: slider?.image),
                    title: Text(slider?.sort?.forMatNumber() ?? ""),
                  ),
                ),
              );
            },
            itemCount: car.images?.length ?? 0,
          ),
        ),
      ),
    );
  }
}
