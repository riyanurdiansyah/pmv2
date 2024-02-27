import 'package:dartz/dartz.dart';
import 'package:data_access/data_access.dart';

abstract class ExecutionRepository {
  Future<Either<String, Map<String, dynamic>>> getExecutionProject(
      {required Map<String, dynamic> body});

  Future<Either<String, Map<String, dynamic>>>
      getProjectObjectiveMilestoneDetail({required Map<String, dynamic> body});

  Future<Either<String, Map<String, dynamic>>> getInitialProject(
      {required Map<String, dynamic> body});

  Future<Either<String, Map<String, dynamic>>> getLogTaskStatus(
      {required Map<String, dynamic> body});

  Future<List<dynamic>> getResourceLOV({required Map<String, dynamic> body});

  Future<List<dynamic>> getAppCategoryLOV({required Map<String, dynamic> body});

  Future<Either<String, Map<String, dynamic>>> assignTask(
      {required Map<String, dynamic> body});
}

class ExecutionRepositoryImpl implements ExecutionRepository {
  final ExecutionRemoteDatasource executionRemoteDatasource;

  ExecutionRepositoryImpl({required this.executionRemoteDatasource});

  @override
  Future<Either<String, Map<String, dynamic>>> getExecutionProject(
      {required Map<String, dynamic> body}) async {
    try {
      final response =
          await executionRemoteDatasource.getExecutionProject(body: body);

      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getInitialProject(
      {required Map<String, dynamic> body}) async {
    try {
      final response =
          await executionRemoteDatasource.getInitialProject(body: body);

      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>>
      getProjectObjectiveMilestoneDetail(
          {required Map<String, dynamic> body}) async {
    try {
      final response = await executionRemoteDatasource
          .getProjectObjectiveMilestoneDetail(body: body);

      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getLogTaskStatus(
      {required Map<String, dynamic> body}) async {
    try {
      final response =
          await executionRemoteDatasource.getLogTaskStatus(body: body);

      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<List<dynamic>> getResourceLOV(
      {required Map<String, dynamic> body}) async {
    try {
      final response =
          await executionRemoteDatasource.getResourceLOV(body: body);

      return response.data["objData"] ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List> getAppCategoryLOV({required Map<String, dynamic> body}) async {
    try {
      final response =
          await executionRemoteDatasource.getAppCategoryLOV(body: body);

      return response.data["objData"] ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> assignTask(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await executionRemoteDatasource.assignTask(body: body);

      return Right(response.data);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
