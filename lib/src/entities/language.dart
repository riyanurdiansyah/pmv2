import 'package:flutter/material.dart';

class LanguageEntity {
  final String name;
  final Locale locale;

  LanguageEntity({
    required this.name,
    required this.locale,
  });

  factory LanguageEntity.emptyObject() => LanguageEntity(
        name: "",
        locale: const Locale(
          "en",
          "US",
        ),
      );
}
