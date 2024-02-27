import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/dio_config.dart';
import 'session_remote_datasource.dart';

abstract class MyTaskRemoteDatasource {
  Future<Response> getTasks({required Map<String, dynamic> request});

  Future<Response> getTasksCount({required Map<String, dynamic> request});

  Future<Response> getTaskStatus({required Map<String, dynamic> request});

  Future<Response> updateTask({required Map<String, dynamic> request});

  Future<Response> getTasksDate({required Map<String, dynamic> request});
}

class MyTaskRemoteDatasourceImpl implements MyTaskRemoteDatasource {
  late Dio dio;
  SessionRemoteDatasource sessionRemoteDatasource =
      SessionRemoteDatasourceImpl();

  MyTaskRemoteDatasourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio(dioBaseOption);
  }

  @override
  Future<Response> getTasks({required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response = await dio.post(dotenv.get("MYTASK_URL"), data: request);
    return response;
  }

  @override
  Future<Response> getTaskStatus(
      {required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response =
        await dio.post(dotenv.get("TASK_STATUS_URL"), data: request);
    return response;
  }

  @override
  Future<Response> updateTask({required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response =
        await dio.post(dotenv.get("UPDATE_TASK_URL"), data: request);
    return response;
  }

  @override
  Future<Response> getTasksDate({required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response =
        await dio.post(dotenv.get("PROJECT_TASK_DATE_URL"), data: request);
    return response;
  }

  @override
  Future<Response> getTasksCount(
      {required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response =
        await dio.post(dotenv.get("MYTASK_COUNT_URL"), data: request);
    return response;
  }
}
