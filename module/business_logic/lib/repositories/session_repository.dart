import 'dart:io';

import 'package:data_access/data_access.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionRepository {
  Future<String?> isLoggedIn();

  Future<String?> checkVersion();

  Future<String> refreshToken();
}

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDatasource sessionRemoteDatasource;

  SessionRepositoryImpl({
    required this.sessionRemoteDatasource,
  });

  @override
  Future<String?> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString("user");
    if (user != null) {
      final role = prefs.getString("role");
      if (role != null) {
        return null;
      } else {
        return "role";
      }
    } else {
      return "signin";
    }
  }

  @override
  Future<String> refreshToken() async {
    try {
      final response = await sessionRemoteDatasource.refreshToken();
      return response.data["access_token"] ?? "";
    } catch (e) {
      return "";
    }
  }

  @override
  Future<String?> checkVersion() async {
    bool debugMode = bool.parse(dotenv.get("DEBUG_MODE"));
    try {
      int platform = 0;
      if (Platform.isIOS) {
        platform = 1;
      }
      final response = await sessionRemoteDatasource.checkVersion(platform);
      int? version = debugMode
          ? (response.data["objData"]["versionDev"] ?? 0)
          : (response.data["objData"]["version"] ?? 0);
      String? link = debugMode
          ? response.data["objData"]["linkDev"]
          : response.data["objData"]["link"];
      if ((version ?? 0) > int.parse(dotenv.get("VERSION"))) {
        return link;
      }

      return null;
    } catch (e) {
      return "Please contact developer for link download";
    }
  }
}
