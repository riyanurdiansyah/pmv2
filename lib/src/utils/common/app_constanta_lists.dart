import 'package:flutter/material.dart';

import '../../entities/language.dart';

class AppConstantaList {
  List<LanguageEntity> languages = [
    LanguageEntity(
      name: "Indonesia",
      locale: const Locale("id", "ID"),
    ),
    LanguageEntity(
      name: "English",
      locale: const Locale("en", "US"),
    ),
  ];
}
