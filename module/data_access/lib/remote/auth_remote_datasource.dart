import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/dio_config.dart';
import 'session_remote_datasource.dart';

abstract class AuthRemoteDatasource {
  Future<Response> signIn({required Map<String, dynamic> request});

  Future<Response> signOut({required Map<String, dynamic> request});

  Future<Response> register({required Map<String, dynamic> request});

  Future<Response> menus({required Map<String, dynamic> request});

  Future<Response> storeToken({required Map<String, dynamic> request});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  late Dio dio;
  SessionRemoteDatasource sessionRemoteDatasource =
      SessionRemoteDatasourceImpl();

  AuthRemoteDatasourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio(dioBaseOption);
  }

  @override
  Future<Response> signIn({required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response = await dio.post(dotenv.get("LOGIN_URL"),
        data: request, options: dioOption);
    return response;
  }

  @override
  Future<Response> register({required Map<String, dynamic> request}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> signOut({required Map<String, dynamic> request}) {
    throw UnimplementedError();
  }

  @override
  Future<Response> menus({required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response = await dio.post(dotenv.get("MENUS_URL"),
        data: request, options: dioOption);
    return response;
  }

  @override
  Future<Response> storeToken({required Map<String, dynamic> request}) async {
    await sessionRemoteDatasource.interceptToken(dio);
    final response = await dio.post(dotenv.get("STORE_TOKEN_URL"),
        data: request, options: dioOption);
    return response;
  }
}
