import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/utils/common/app_common.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAccent,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/404.svg",
              width: AppConstanta.sizes.width / 1.25,
            ),
            const SizedBox(
              height: 35,
            ),
            AppText.labelW600(
              "Halaman akan segera hadir... \nStay tuned",
              16,
              Colors.white,
              maxLines: 2,
              textAlign: TextAlign.center,
              height: 1.5,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 250,
              height: 45,
              child: ElevatedButton(
                onPressed: () => context.go("/"),
                child: AppText.labelW600(
                  "Kembali ke home",
                  14,
                  colorPrimaryDark,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
