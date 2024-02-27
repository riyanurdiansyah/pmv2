import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

BaseOptions dioBaseOption = BaseOptions(
  baseUrl: dotenv.get("BASE_URL"),
  sendTimeout: const Duration(seconds: 30),
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);

Options dioOption = Options(
  followRedirects: false,
  headers: {
    "Content-Type": "application/json",
    "Accept": "*/*",
  },
  sendTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  validateStatus: (status) {
    return status! < 500;
  },
);
