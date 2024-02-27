import 'package:flutter/material.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionPage extends StatelessWidget {
  const VersionPage({super.key, required this.link});

  final String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 35,
          horizontal: 16,
        ),
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: () {
            launchUrl(Uri.parse(link));
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(
                width: 0.6,
                color: colorPrimaryDark,
              ),
            ),
          ),
          child: AppText.labelW600(
            "Update...",
            16,
            colorPrimaryDark,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppConstantaImages.version,
              width: 150,
            ),
            AppText.labelW600(
              "Silahkan update versi app mu",
              14,
              Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
