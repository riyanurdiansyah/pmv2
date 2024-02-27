import 'package:business_logic/business_logic.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/utils/common/app_common.dart';
import 'package:pman/src/utils/config/app_route_name.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      final SessionRemoteDatasource sessionRemoteDatasource =
          SessionRemoteDatasourceImpl();
      await SessionRepositoryImpl(
              sessionRemoteDatasource: sessionRemoteDatasource)
          .isLoggedIn()
          .then((route) {
        if (route != null) {
          context.goNamed(route);
        } else {
          context.goNamed(AppRouteName.home);
        }
      });
    });
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    animation = CurvedAnimation(
        parent: animationController!, curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: FadeTransition(
                  opacity: animation!,
                  child: Image.asset(
                    AppConstantaImages.logo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
