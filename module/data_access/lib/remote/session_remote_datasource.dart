import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionRemoteDatasource {
  Future<Response> refreshToken();

  Future<Response> checkVersion(int platform);

  Future interceptToken(Dio dio);

  Future interceptTokenKNGlobal(Dio dio);
}

class SessionRemoteDatasourceImpl implements SessionRemoteDatasource {
  late Dio dio;

  SessionRemoteDatasourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }

  @override
  Future<Response> refreshToken() async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('${dotenv.get("CONSUMER_KEY_PM")}:${dotenv.get("CONSUMER_SECRET_PM")}'))}';

    final response = await dio.post(
      dotenv.get("REFRESH_TOKEN_URL"),
      data: {
        "grant_type": "client_credentials",
      },
      options: Options(headers: {
        "Authorization": basicAuth,
        "Content-Type": "application/x-www-form-urlencoded",
      }),
    );
    return response;
  }

  @override
  Future interceptToken(Dio dio) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          options,
          handler,
        ) async {
          options.headers.addAll({
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${prefs.getString("token")}",
          });
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.statusCode != 200) {
            try {
              final responseToken = await refreshToken();
              String newToken = responseToken.data["access_token"] ?? "";
              dio.options.headers["Authorization"] = "Bearer $newToken";
              prefs.setString("token", newToken);
              return handler.resolve(await dio.fetch(response.requestOptions));
            } catch (e) {
              return handler.next(response);
            }
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode != 200) {
            try {
              final responseToken = await refreshToken();
              String newToken = responseToken.data["access_token"] ?? "";

              dio.options.headers["Authorization"] = "Bearer $newToken";
              prefs.setString("token", newToken);
              return handler.resolve(await dio.fetch(error.requestOptions));
            } catch (e) {
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future interceptTokenKNGlobal(Dio dio) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          options,
          handler,
        ) async {
          options.headers.addAll({
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${prefs.getString("tokenKNGlobal")}",
          });
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.statusCode != 200) {
            final responseToken = await refreshToken();

            String newToken = responseToken.data["access_token"] ?? "";

            dio.options.headers["Authorization"] = "Bearer $newToken";
            prefs.setString("tokenKNGlobal", newToken);
            return handler.resolve(await dio.fetch(response.requestOptions));
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode != 200) {
            final responseToken = await refreshToken();
            String newToken = responseToken.data["access_token"] ?? "";

            dio.options.headers["Authorization"] = "Bearer $newToken";
            prefs.setString("tokenKNGlobal", newToken);
            return handler.resolve(await dio.fetch(error.requestOptions));
          }
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<Response> checkVersion(int platform) async {
    await interceptToken(dio);
    final response = await dio.post(
      "${dotenv.get("BASE_URL")}${dotenv.get("CONFIG_APP_URL")}",
      data: {"platform": platform},
    );
    return response;
  }
}
