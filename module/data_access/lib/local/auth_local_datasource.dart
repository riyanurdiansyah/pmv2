import 'package:flutter/services.dart';

abstract class AuthLocalDatasource {
  Future<String> signIn();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  @override
  Future<String> signIn() async {
    return await rootBundle.loadString("assets/json/user_example.json");
  }
}
