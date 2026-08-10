import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/launch_links.dart';
import 'package:kcars/core/widget/image_holder.dart';
import 'package:kcars/features/app_settings/application/app_settigngs_controller.dart';
import 'package:kcars/features/app_settings/presentation/riverpod/sliders.dart';
import 'package:kcars/features/car/data/model/enums.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    hide SlideType;

class SlidesViwe extends HookConsumerWidget {
  SlidesViwe({super.key, this.imageWidth, this.imageHeight});
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final double? imageWidth;
  final double? imageHeight;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSlider = useState(0);
    useListenable(selectedSlider);
    final sldiersAsync = ref.watch(allSlidersProvider);
    return SizedBox(
      height: 34.w,
      child: sldiersAsync.when(
        data: (data) {
          if (data.isEmpty) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: context.surfaceContainerLowest,
              ),
            );
          }
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: data.length,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) =>
                        selectedSlider.value = index,
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    pageSnapping: true,
                    height: imageHeight ?? 30.w,
                    viewportFraction: 1,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                  ),
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                        final slider = data[index];
                        return GestureDetector(
                          onTap: () {
                            if (slider.type == SlideType.car &&
                                slider.carId != null &&
                                slider.carId!.isNotEmpty) {
                              context.router.push(
                                CarDetailsRoute(carId: slider.car?.carId ?? ""),
                              );
                            } else if (slider.type == SlideType.company &&
                                slider.companyId != null &&
                                slider.companyId!.isNotEmpty) {
                              context.router.push(
                                CompanyDetailsRoute(
                                  companyId: slider.companyId!,
                                ),
                              );
                            } else if (slider.type == SlideType.url &&
                                slider.url != null &&
                                slider.url!.isNotEmpty) {
                              openLinks(
                                appLink: slider.url!,
                                webLink: slider.url!,
                              );
                            }
                            ref
                                .read(appSettingsControllerProvider.notifier)
                                .slider(slider.id!);
                          },
                          child: SizedBox(
                            width: imageWidth ?? 94.w,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: ClipRRect(
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ImageHolder(
                                    image: slider.image,
                                    fit: BoxFit.cover,
                                    // borderRadius: BorderRadius.zero,
                                  ),
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
                  count: data.length,
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
        },
        error: (_, _) => SizedBox.shrink(),
        loading: () => SizedBox(),
      ),
    );
  }
}
