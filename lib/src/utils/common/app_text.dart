import 'package:flutter/material.dart';

class AppText {
  static Text labelNormal(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontFamily: "OpenSauceSans",
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static Text labelW400(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
    FontStyle? fontStyle,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: TextStyle(
          fontFamily: "OpenSauceSans",
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static Text labelW500(String title, double fontSize, Color colors,
      {String? familiy,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines,
      FontStyle? fontStyle,
      double? height,
      bool? softWarp,
      double? letterSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontFamily: "OpenSauceSans",
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: colors,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: height ?? 1.0,
      ),
    );
  }

  static Text labelW600(String title, double fontSize, Color colors,
      {String? familiy,
      TextAlign? textAlign,
      TextOverflow? overflow,
      int? maxLines,
      double? height,
      FontStyle? fontStyle,
      double? letterSpacing}) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: TextStyle(
          fontFamily: "OpenSauceSans",
          letterSpacing: letterSpacing,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: colors,
          fontStyle: fontStyle ?? FontStyle.normal,
          height: height ?? 1.0),
    );
  }

  static Text labelW700(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontFamily: "OpenSauceSans",
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }

  static Text labelBold(
    String title,
    double fontSize,
    Color colors, {
    String? familiy,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
  }) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        fontFamily: "OpenSauceSans",
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: colors,
        height: height ?? 1.0,
      ),
    );
  }
}
