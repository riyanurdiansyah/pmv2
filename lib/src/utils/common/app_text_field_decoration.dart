import 'package:flutter/material.dart';

import 'app_common.dart';

InputDecoration textFieldAuthDecoration(
    {required double fontSize, required String hintText, double? radius}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    hintStyle: TextStyle(
        fontWeight: FontWeight.w500, fontSize: fontSize, color: Colors.white),
    hintText: hintText,
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
        ),
        borderRadius: BorderRadius.circular(5)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
        ),
        borderRadius: BorderRadius.circular(5)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: colorPrimary),
        borderRadius: BorderRadius.circular(5)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(radius ?? 6),
    ),
  );
}

InputDecoration textFieldPassDecoration({
  required double fontSize,
  required String hintText,
  double? radius,
  Function()? onTap,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    hintStyle: TextStyle(
        fontWeight: FontWeight.w500, fontSize: fontSize, color: Colors.white),
    hintText: hintText,
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
        ),
        borderRadius: BorderRadius.circular(5)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
        ),
        borderRadius: BorderRadius.circular(5)),
    suffixIcon: IconButton(
        onPressed: onTap, icon: const Icon(Icons.remove_red_eye_rounded)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: colorPrimary),
        borderRadius: BorderRadius.circular(5)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(radius ?? 6),
    ),
  );
}

InputDecoration textFieldApprovalDecoration({
  required double fontSize,
  required String hintText,
  double? radius,
  Widget? prefix,
  Function()? onTap,
}) {
  return InputDecoration(
    hintStyle: TextStyle(
        fontWeight: FontWeight.w500, fontSize: fontSize, color: Colors.black),
    hintText: hintText,
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
        ),
        borderRadius: BorderRadius.circular(5)),
    prefixIcon: prefix,
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade300,
        ),
        borderRadius: BorderRadius.circular(5)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: colorPrimaryDark),
        borderRadius: BorderRadius.circular(5)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(radius ?? 6),
    ),
  );
}
