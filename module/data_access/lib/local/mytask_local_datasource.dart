import 'package:flutter/services.dart';

abstract class MyTaskLocalDatasource {
  Future<String> getTasks();
}

class MyTaskLocalDatasourceImpl implements MyTaskLocalDatasource {
  @override
  Future<String> getTasks() async {
    return await rootBundle.loadString("assets/json/mytask_example.json");
  }
}
