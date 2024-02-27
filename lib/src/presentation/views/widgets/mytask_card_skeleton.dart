import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyTaskCardSkeleton extends StatelessWidget {
  const MyTaskCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: List.generate(
          3,
          (index) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade400,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
