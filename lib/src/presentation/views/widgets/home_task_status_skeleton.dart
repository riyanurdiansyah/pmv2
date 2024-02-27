import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/common/app_common.dart';

class HomeTaskStatusSkeleton extends StatelessWidget {
  const HomeTaskStatusSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: AppConstanta.sizes.defaultPadding),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade400,
        child: Column(
          children: List.generate(
            3,
            (index) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppConstanta.colors.colorPrimaryDark,
                        border: Border.all(
                          width: 3.5,
                          color: AppConstanta.colors.colorPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (index != 2)
                      Container(
                        color: Colors.grey.shade100,
                        width: 10,
                        height: 50,
                        child: LayoutBuilder(
                          builder: (context, constraint) => Flex(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.vertical,
                            children: List.generate(
                              (constraint.constrainHeight() / 15).floor(),
                              (index) => SizedBox(
                                width: 6,
                                height: 6,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 10,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: 200,
                      height: 20,
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
