import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/image_type.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/car/data/model/image.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class CarousalView extends HookConsumerWidget {
  CarousalView({
    super.key,
    required this.sliders,
    this.imageWidth,
    this.imageHeight,
  });
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final List<Images> sliders;
  final double? imageWidth;
  final double? imageHeight;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSlider = useState(0);
    useListenable(selectedSlider);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.w)),
          child: CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: sliders.length,
            options: CarouselOptions(
              onPageChanged: (index, reason) => selectedSlider.value = index,
              aspectRatio: 16 / 9,
              autoPlay: true,
              pageSnapping: true,
              height: imageHeight ?? 50.w,
              viewportFraction: 1,
              autoPlayAnimationDuration: const Duration(seconds: 1),
            ),
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              final slider = sliders[index];
              return SizedBox(
                width: imageWidth ?? 94.w,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    SwipeImageGallery(
                      context: context,
                      initialIndex: index,
                      backgroundOpacity: .8,
                      children: sliders
                          .asMap()
                          .entries
                          .map(
                            (entry) => ImageHolder(
                              image: entry.value.image,
                              type: ImageType.car,
                            ),
                          )
                          .toList(),
                    ).show();
                  },
                  child: ClipRRect(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ImageHolder(
                        image: slider.image,
                        type: ImageType.car,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 2.w),
          child: AnimatedSmoothIndicator(
            activeIndex: selectedSlider.value,
            count: sliders.length,
            curve: Curves.slowMiddle,
            effect: ScrollingDotsEffect(
              dotHeight: 1.5.w,
              dotWidth: 1.5.w,
              activeDotColor: context.surface,
              dotColor: context.surfaceContainerLow,
            ),
          ),
        ),
      ],
    );
  }
}

BoxShadow sliderShadow(BuildContext context) => BoxShadow(
  color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
  blurRadius: 5,
  spreadRadius: 2,
  offset: const Offset(0, 5),
);

class EmptySlider extends StatelessWidget {
  const EmptySlider({super.key, this.message, this.width, this.height});
  final String? message;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height ?? 50.w,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            color: context.primaryContainer,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(borderRadius: BorderRadius.circular(4.w)),
          ),
        ),
      ],
    );
  }
}
