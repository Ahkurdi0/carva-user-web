import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:sizer/sizer.dart';

class PcikedImagesScreen extends StatefulWidget {
  final bool isPost;
  final Function(List<XFile> selectedImages) selectedImages;
  const PcikedImagesScreen({
    super.key,
    required this.selectedImages,

    this.isPost = false,
  });

  @override
  State<PcikedImagesScreen> createState() => _PcikedImagesScreenState();
}

class _PcikedImagesScreenState extends State<PcikedImagesScreen> {
  List<XFile> images = [];
  selectImages() async {
    final selectedImages = await selectMultipleImages();

    if (selectedImages == null) return;

    setState(() {
      if (images.isEmpty && selectedImages.length <= 5) {
        for (final image in selectedImages) {
          images.add(image);
        }
      } else {
        for (int i = 0; i < selectedImages.length && images.length < 5; i++) {
          images.add(selectedImages[i]);
        }
      }
      widget.selectedImages(images);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = <Widget>[
      for (int index = 0; index < images.length; index += 1)
        Container(
          key: Key('$index'),
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: 40.w,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.w)),
          child: AspectRatio(
            aspectRatio: widget.isPost ? 16 / 9 : 1 / 1,
            child: Stack(
              children: [
                Platform.isIOS
                    ? Image.asset(
                        images[index].path,
                        fit: BoxFit.cover,
                        width: 40.w,
                        height: 30.w,
                      )
                    : Image.file(File(images[index].path)),
                Positioned(
                  top: 1.w,
                  left: 1.w,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).disabledColor,
                    maxRadius: 10,
                    child: Icon(Icons.drag_handle, size: 10.sp),
                  ),
                ),
                Positioned(
                  top: 1.w,
                  right: 1.w,
                  child: SizedBox(
                    height: 6.w,
                    width: 6.w,
                    child: IconButton.filled(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          images.removeAt(index);
                        });
                        widget.selectedImages(images);
                      },
                      icon: Icon(Icons.delete, size: 10.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    ];

    Widget proxyDecorator(
      Widget child,
      int index,
      Animation<double> animation,
    ) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            child: Container(child: cards[index]),
          );
        },
        child: child,
      );
    }

    return Material(
      child: SizedBox(
        height: 30.w,
        child: ReorderableListView(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          proxyDecorator: proxyDecorator,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex == images.length + 1) {
                return;
              }
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final image = images.removeAt(oldIndex);
              images.insert(newIndex, image);
            });
            widget.selectedImages(images);
          },
          children: cards.isEmpty
              ? [
                  ImagePickerButton(
                    key: const ValueKey("Add"),
                    onTap: selectImages,
                    imageLength: images.length,
                  ),
                ]
              : cards.isNotEmpty && cards.length < 5
              ? [
                  ...cards,
                  ImagePickerButton(
                    key: const ValueKey("Add"),
                    onTap: selectImages,
                    imageLength: images.length,
                  ),
                ]
              : cards,
        ),
      ),
    );
  }
}

class EditPcikerImageServiceScreen extends StatefulWidget {
  final List<Images> images;
  final bool isPost;
  final Function(List<XFile> selectedImages) selectedImages;
  final Function(Images deletedImages) deletedImages;
  const EditPcikerImageServiceScreen({
    super.key,
    required this.selectedImages,
    required this.deletedImages,
    required this.images,
    this.isPost = false,
  });

  @override
  State<EditPcikerImageServiceScreen> createState() =>
      _EditPcikerImageServiceScreenState();
}

class _EditPcikerImageServiceScreenState
    extends State<EditPcikerImageServiceScreen> {
  List<String> images = [];
  List<XFile> newImages = [];
  List<Images> prevImages = [];
  @override
  initState() {
    prevImages.addAll(widget.images);
    for (final url in widget.images) {
      images.add(url.image);
    }
    super.initState();
  }

  selectImages() async {
    final selectedImages = await selectMultipleImages();

    if (selectedImages == null) return;

    setState(() {
      if (images.isEmpty && selectedImages.length <= 5) {
        for (final image in selectedImages) {
          images.add(image.path);
          newImages.add(image);
        }
      } else {
        for (int i = 0; i < selectedImages.length && images.length < 5; i++) {
          images.add(selectedImages[i].path);
          newImages.add(selectedImages[i]);
        }
      }
      widget.selectedImages(newImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = <Widget>[
      for (int index = 0; index < images.length; index += 1)
        GestureDetector(
          key: Key('$index'),
          onLongPress: () {},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            width: 40.w,
            height: 40.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.w)),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Stack(
                children: [
                  detectImageSourceType(images[index]) ==
                          ImageSourceType.network
                      ? ImageHolder(
                          image: images[index],
                          height: 30.w,
                          width: 100.w,
                          borderRadius: BorderRadius.circular(2.w),
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(images[index]),
                          fit: BoxFit.cover,
                          width: 40.w,
                          height: 30.w,
                        ),
                  Positioned(
                    top: 1.w,
                    right: 1.w,
                    child: SizedBox(
                      height: 6.w,
                      width: 6.w,
                      child: IconButton.filled(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          final ImageSourceType source = detectImageSourceType(
                            images[index],
                          );
                          if (source == ImageSourceType.network) {
                            widget.deletedImages(prevImages[index]);
                            prevImages.removeAt(index);
                          }
                          setState(() {
                            newImages = newImages
                                .where((image) => image.path != images[index])
                                .toList();
                            images.removeAt(index);
                          });
                          widget.selectedImages(newImages);
                        },
                        icon: Icon(Icons.delete, size: 4.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ];

    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SizedBox(
              height: 30.w,

              child: ReorderableListView(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                onReorder: (int oldIndex, int newIndex) {},
                children: cards.isEmpty
                    ? [
                        ImagePickerButton(
                          key: const ValueKey("Add"),
                          onTap: selectImages,
                          imageLength: images.length,
                        ),
                      ]
                    : cards.isNotEmpty && cards.length < 5
                    ? [
                        ...cards,
                        ImagePickerButton(
                          key: const ValueKey("Add"),
                          onTap: selectImages,
                          imageLength: images.length,
                        ),
                      ]
                    : cards,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ImageSourceType { network, asset, unknown }

ImageSourceType detectImageSourceType(String imageUrl) {
  Uri uri = Uri.parse(imageUrl);

  if (imageUrl.startsWith("car")) {
    return ImageSourceType.network;
  } else if (uri.scheme == 'asset') {
    return ImageSourceType.asset;
  } else {
    return ImageSourceType.unknown;
  }
}

class ImagePickerButton extends StatelessWidget {
  final VoidCallback onTap;
  final int imageLength;
  const ImagePickerButton({
    super.key,
    required this.onTap,
    required this.imageLength,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonWrapper(
      onTap: onTap,
      onLongPress: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        alignment: Alignment.center,
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          color: Theme.of(context).hoverColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: 2.w),
            Text(
              "$imageLength / 5",
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonWrapper extends HookWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget child;
  final double? borderRadius;
  const CustomButtonWrapper({
    super.key,
    this.borderRadius,
    this.onTap,
    required this.child,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isHighlited = useState<bool>(false);
    return AnimatedScale(
      scale: isHighlited.value ? .98 : 1,
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 4.w),
        child: InkResponse(
          onLongPress: onLongPress,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius ?? 4.w),
          onHighlightChanged: (v) {
            isHighlited.value = !isHighlited.value;
          },
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
