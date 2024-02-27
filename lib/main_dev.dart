// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'firebase_options_dev.dart';
// import 'main.dart';
// import 'src/utils/config/app_config.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   final devApp = AppConfig(
//     appName: "Projent DEV",
//     appMode: AppMode.dev,
//   );

//   await dotenv.load(fileName: ".env.dev");
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptionsDev.currentPlatform,
//   );
//   Widget app = await initializeApp(devApp);

//   runApp(
//     EasyLocalization(
//       supportedLocales: const [
//         Locale("en", "US"),
//         Locale("id", "ID"),
//       ],
//       path: "assets/language",
//       fallbackLocale: const Locale("en", "US"),
//       child: app,
//     ),
//   );
// }
