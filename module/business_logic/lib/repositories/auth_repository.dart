import 'package:dartz/dartz.dart';
import 'package:data_access/data_access.dart';

abstract class AuthRepository {
  Future<Either<String, Map<String, dynamic>>> signIn(
      {required Map<String, dynamic> request});

  Future<Either<String, Map<String, dynamic>>> menus(
      {required Map<String, dynamic> request});

  Future<Either<String, Map<String, dynamic>>> storeToken(
      {required Map<String, dynamic> request});
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
  });

  @override
  Future<Either<String, Map<String, dynamic>>> signIn(
      {required Map<String, dynamic> request}) async {
    try {
      final response = await authRemoteDatasource.signIn(request: request);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> menus(
      {required Map<String, dynamic> request}) async {
    try {
      final response = await authRemoteDatasource.menus(request: request);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> storeToken(
      {required Map<String, dynamic> request}) async {
    try {
      final response = await authRemoteDatasource.storeToken(request: request);
      return Right(response.data);
    } catch (e) {
      return const Left("Failure connect to server");
    }
  }
}
