import 'package:dartz/dartz.dart';
import 'package:data_access/data_access.dart';

abstract class ApprovalRepository {
  Future<List<dynamic>> getProjectLeader(Map<String, dynamic> data);

  Future<Either<String, Map<String, dynamic>>> getApprovalTaskByLead(
      String leadNIK);

  Future<List<dynamic>> getDevSourceByTeamName(String teamName);

  Future<List<dynamic>> getListAppCategoryLOV(String search);

  Future<Either<String, Map<String, dynamic>>> getTaskEffortCategory(
      Map<String, dynamic> data);

  Future<Either<String, bool>> approvedTask(List<Map<String, dynamic>> data);
}

class ApprovalRepositoryImpl implements ApprovalRepository {
  final ApprovalRemoteDatasource approvalRemoteDatasource;

  ApprovalRepositoryImpl({
    required this.approvalRemoteDatasource,
  });

  @override
  Future<List<dynamic>> getProjectLeader(Map<String, dynamic> data) async {
    try {
      final response = await approvalRemoteDatasource.getProjectLeader(data);
      return response.data["objData"] ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getApprovalTaskByLead(
      String leadNIK) async {
    try {
      final response =
          await approvalRemoteDatasource.getApprovalTaskByLead(leadNIK);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }

  @override
  Future<List<dynamic>> getDevSourceByTeamName(String teamName) async {
    try {
      final response =
          await approvalRemoteDatasource.getDevSourceByTeamName(teamName);
      return response.data["objData"] ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<dynamic>> getListAppCategoryLOV(String search) async {
    try {
      final response =
          await approvalRemoteDatasource.getListAppCategoryLOV(search);
      return response.data["objData"] ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getTaskEffortCategory(
      Map<String, dynamic> data) async {
    try {
      final response =
          await approvalRemoteDatasource.getTaskEffortCategory(data);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }

  @override
  Future<Either<String, bool>> approvedTask(
      List<Map<String, dynamic>> data) async {
    try {
      await approvalRemoteDatasource.approvedTask(data);
      return const Right(true);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }
}
