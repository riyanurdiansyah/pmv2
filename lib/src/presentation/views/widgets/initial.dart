import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pman/src/features/carousel/app_carousel_option.dart';
import 'package:pman/src/features/carousel/app_carousel_slider.dart';
import 'package:pman/src/presentation/controllers/home_controller.dart';
import 'package:pman/src/presentation/views/widgets/initial_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../../entities/initial_project.dart';
import '../../../utils/common/app_common.dart';

class InitialWidget extends StatelessWidget {
  InitialWidget({super.key});

  final _hC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Obx(() {
              if (_hC.isLoadingInitial.value) {
                return Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: AppCarouselSlider(
                    options: AppCarouselOptions(
                      height: 160,
                      onPageChanged: (index, _) {},
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      aspectRatio: 0.8,
                      viewportFraction: 1,
                    ),
                    items: List.generate(
                      3,
                      (index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade400,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: AppConstanta.sizes.defaultPadding),
                          width: double.infinity,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (_hC.initials.value == InitialProjectEntity.emptyObject() ||
                  _hC.initials.value.objData.isEmpty) {
                return const SizedBox();
              }

              if (_hC.initials.value.txtStackTrace.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.only(top: 14.0),
                  margin: EdgeInsets.symmetric(
                      horizontal: AppConstanta.sizes.defaultPadding),
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _hC.getInitialProject,
                        icon: const Icon(
                          Icons.refresh_rounded,
                        ),
                      ),
                      SizedBox(
                        height: AppConstanta.sizes.defaultPadding,
                      ),
                      AppText.labelW500(
                        AppConstanta.strings.failedLoadData,
                        14,
                        Colors.grey.shade600,
                      ).tr(),
                    ],
                  ),
                );
              }
              return AppCarouselSlider(
                options: AppCarouselOptions(
                  height: 185,
                  onPageChanged: _hC.onSlideInitial,
                  autoPlayInterval: const Duration(seconds: 8),
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 1,
                ),
                items: List.generate(
                  _hC.initials.value.objData.length,
                  (index) => InitialCard(
                    data: _hC.initials.value.objData[index],
                  ),
                ),
              );
            }),
            Obx(() {
              if (_hC.initials.value == InitialProjectEntity.emptyObject() ||
                  _hC.initials.value.txtStackTrace.isNotEmpty ||
                  _hC.initials.value.objData.isEmpty ||
                  _hC.isLoadingInitial.value) {
                return const SizedBox();
              }
              return Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(_hC.initials.value.objData.length, (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          const EdgeInsets.only(top: 10.0, left: 2.0, right: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _hC.indexInitial.value == index
                            ? Border.all(width: 0.2, color: Colors.white)
                            : Border.all(
                                width: 0.6, color: Colors.grey.shade300),
                        color: _hC.indexInitial.value == index
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    );
                  }),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
