import 'package:data_access/data_access.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/dio_config.dart';

abstract class ExecutionRemoteDatasource {
  Future<Response> getExecutionProject({required Map<String, dynamic> body});

  Future<Response> getProjectObjectiveMilestoneDetail(
      {required Map<String, dynamic> body});

  Future<Response> getInitialProject({required Map<String, dynamic> body});

  Future<Response> getLogTaskStatus({required Map<String, dynamic> body});

  Future<Response> getResourceLOV({required Map<String, dynamic> body});

  Future<Response> getAppCategoryLOV({required Map<String, dynamic> body});

  Future<Response> assignTask({required Map<String, dynamic> body});
}

class ExecutionRemoteDatasourceImpl implements ExecutionRemoteDatasource {
  late Dio dio;

  SessionRemoteDatasource sessionRemoteDatasource =
      SessionRemoteDatasourceImpl();

  ExecutionRemoteDatasourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio(dioBaseOption);
  }

  @override
  Future<Response> getExecutionProject(
      {required Map<String, dynamic> body}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    return await dio.post(dotenv.get("EXECUTION_PROJECT_URL"), data: body);
  }

  @override
  Future<Response> getProjectObjectiveMilestoneDetail(
      {required Map<String, dynamic> body}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    return await dio.post(dotenv.get("PROJECT_OBJECTIVE_DETAIL_URL"),
        data: body);
  }

  @override
  Future<Response> getInitialProject(
      {required Map<String, dynamic> body}) async {
    await sessionRemoteDatasource.interceptToken(dio);

    return await dio.post(dotenv.get("INITIAL_PROJECT_URL"), data: body);
  }

  @override
  Future<Response> getLogTaskStatus(
      {required Map<String, dynamic> body}) async {
    await sessionRemoteDatasource.interceptToken(dio);

    return await dio.post(dotenv.get("LOG_TASK_STATUS_URL"), data: body);
  }

  @override
  Future<Response> getResourceLOV({required Map<String, dynamic> body}) async {
    // Dio dioLocal = Dio(dioBaseOptionLocal);
    // await sessionRemoteDatasource.interceptToken(dio);
    final response = await dio.post(dotenv.get("RESOURCE_LOV_URL"),
        data: body, options: dioOption);
    return response;
  }

  @override
  Future<Response> getAppCategoryLOV(
      {required Map<String, dynamic> body}) async {
    // Dio dioLocal = Dio(dioBaseOptionLocal);
    await sessionRemoteDatasource.interceptToken(dio);

    return await dio.post(dotenv.get("APP_CATEGORY_LOV_URL"),
        data: body, options: dioOption);
  }

  @override
  Future<Response> assignTask({required Map<String, dynamic> body}) async {
    // Dio dioLocal = Dio(dioBaseOptionLocal);
    await sessionRemoteDatasource.interceptToken(dio);

    final response = await dio.post(dotenv.get("ASSIGN_TASK_URL"),
        data: body, options: dioOption);
    return response;
  }
}
