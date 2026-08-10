import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void openGallery(BuildContext context, int initialIndex, List<Images> items) {
  showDialog(
    context: context,
    builder: (context) {
      double verticalDragStart = 0;
      return GestureDetector(
        onVerticalDragStart: (details) {
          verticalDragStart = details.globalPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          final dragDistance = details.globalPosition.dy - verticalDragStart;

          if (dragDistance > 150) {
            Navigator.of(context).pop();
          }
        },
        child: PhotoViewGallery.builder(
          itemCount: items.length,
          pageController: PageController(initialPage: initialIndex),
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(items[index].image),
              heroAttributes: PhotoViewHeroAttributes(tag: items[index]),
              initialScale: PhotoViewComputedScale.contained,
            );
          },
          loadingBuilder: (context, event) => Center(
            child: CircularProgressIndicator(
              value: event == null
                  ? null
                  : event.cumulativeBytesLoaded /
                        (event.expectedTotalBytes ?? 1),
            ),
          ),
        ),
      );
    },
  );
}
