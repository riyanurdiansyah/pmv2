// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:pman/firebase_options.dart';

// import 'main.dart';
// import 'src/utils/config/app_config.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   final prodApp = AppConfig(
//     appName: "Projent",
//     appMode: AppMode.prod,
//   );

//   await dotenv.load(fileName: ".env.prod");
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   Widget app = await initializeApp(prodApp);

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
