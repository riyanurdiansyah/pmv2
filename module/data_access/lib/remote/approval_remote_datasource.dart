import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/dio_config.dart';
import 'session_remote_datasource.dart';

abstract class ApprovalRemoteDatasource {
  Future<Response> getProjectLeader(Map<String, dynamic> data);

  Future<Response> getApprovalTaskByLead(String leadNIK);

  Future<Response> getDevSourceByTeamName(String teamName);

  Future<Response> getListAppCategoryLOV(String search);

  Future<Response> getTaskEffortCategory(Map<String, dynamic> data);

  Future<Response> approvedTask(List<Map<String, dynamic>> data);
}

class ApprovalRemoteDatasourceImpl implements ApprovalRemoteDatasource {
  late Dio dio;

  SessionRemoteDatasource sessionRemoteDatasource =
      SessionRemoteDatasourceImpl();

  ApprovalRemoteDatasourceImpl({Dio? dio, Dio? dioKNGlobal}) {
    this.dio = dio ?? Dio(dioBaseOption);
  }

  @override
  Future<Response> getProjectLeader(Map<String, dynamic> data) async {
    await sessionRemoteDatasource.interceptToken(dio);
    return await dio.post(dotenv.get("PROJECT_LEADER_URL"), data: {
      "userName": data["userName"],
      "bitSuperUser": data["bitSuperUser"],
    });
  }

  @override
  Future<Response> getApprovalTaskByLead(String leadNIK) async {
    await sessionRemoteDatasource.interceptToken(dio);
    return await dio
        .post(dotenv.get("APPROVAL_TASK_LEAD_URL"), data: {"txtNIK": leadNIK});
  }

  @override
  Future<Response> getDevSourceByTeamName(String teamName) async {
    await sessionRemoteDatasource.interceptToken(dio);
    return await dio.post(dotenv.get("APPROVAL_DEV_SOURCE_URL"), data: {
      "teamName": teamName,
    });
  }

  @override
  Future<Response> getListAppCategoryLOV(String search) async {
    await sessionRemoteDatasource.interceptToken(dio);
    return await dio.post(dotenv.get("APPROVAL_CATEGORY_LOV_URL"), data: {
      "txtSearch": search,
    });
  }

  @override
  Future<Response> getTaskEffortCategory(Map<String, dynamic> data) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response = await dio.post(
      dotenv.get("APPROVAL_TASK_EFFORT_CATEGORY_URL"),
      data: data,
    );
    return response;
  }

  @override
  Future<Response> approvedTask(List<Map<String, dynamic>> data) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response = await dio.post(
      dotenv.get("APPROVED_URL"),
      data: data,
    );
    return response;
  }
}
