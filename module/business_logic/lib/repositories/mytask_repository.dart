import 'package:dartz/dartz.dart';
import 'package:data_access/data_access.dart';

abstract class MyTaskRepository {
  Future<Either<String, Map<String, dynamic>>> getTasks({
    required Map<String, dynamic> request,
  });

  Future<int> getTasksCount({
    required Map<String, dynamic> request,
  });

  Future<Map<String, dynamic>> getTaskStatus({
    required Map<String, dynamic> request,
  });

  Future<Either<String, Map<String, dynamic>>> updateTask({
    required Map<String, dynamic> request,
  });

  Future<Either<String, Map<String, dynamic>>> getTaskDate({
    required Map<String, dynamic> request,
  });
}

class MyTaskRepositoryImpl implements MyTaskRepository {
  final MyTaskRemoteDatasource myTaskRemoteDatasource;

  final MyTaskLocalDatasource myTaskLocalDatasource;

  MyTaskRepositoryImpl({
    required this.myTaskRemoteDatasource,
    required this.myTaskLocalDatasource,
  });

  @override
  Future<Either<String, Map<String, dynamic>>> getTasks({
    required Map<String, dynamic> request,
  }) async {
    try {
      final response = await myTaskRemoteDatasource.getTasks(request: request);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }

  @override
  Future<Map<String, dynamic>> getTaskStatus({
    required Map<String, dynamic> request,
  }) async {
    try {
      final response =
          await myTaskRemoteDatasource.getTaskStatus(request: request);
      return response.data;
    } catch (e) {
      return {};
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> updateTask(
      {required Map<String, dynamic> request}) async {
    try {
      final response =
          await myTaskRemoteDatasource.updateTask(request: request);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getTaskDate(
      {required Map<String, dynamic> request}) async {
    try {
      final response =
          await myTaskRemoteDatasource.getTasksDate(request: request);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }

  @override
  Future<int> getTasksCount({required Map<String, dynamic> request}) async {
    try {
      final response =
          await myTaskRemoteDatasource.getTasksCount(request: request);
      return (response.data["objData"]["totalRow"] as int);
    } catch (e) {
      return 0;
    }
  }
}
