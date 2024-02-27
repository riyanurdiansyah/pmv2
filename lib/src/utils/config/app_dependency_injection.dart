import 'package:business_logic/business_logic.dart';
import 'package:data_access/data_access.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void initializeDependencyInjection() {
  //DATASOURCE
  getIt.registerSingleton<AuthRemoteDatasource>(AuthRemoteDatasourceImpl());
  getIt.registerSingleton<MyTaskRemoteDatasource>(MyTaskRemoteDatasourceImpl());
  getIt.registerSingleton<MyTaskLocalDatasource>(MyTaskLocalDatasourceImpl());
  getIt.registerSingleton<SessionRemoteDatasource>(
      SessionRemoteDatasourceImpl());
  getIt.registerSingleton<ApprovalRemoteDatasource>(
      ApprovalRemoteDatasourceImpl());
  getIt.registerSingleton<ExecutionRemoteDatasource>(
      ExecutionRemoteDatasourceImpl());

  //REPOSITORY
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authRemoteDatasource: getIt<AuthRemoteDatasource>()));
  getIt.registerSingleton<MyTaskRepository>(MyTaskRepositoryImpl(
      myTaskRemoteDatasource: getIt<MyTaskRemoteDatasource>(),
      myTaskLocalDatasource: getIt<MyTaskLocalDatasource>()));
  getIt.registerSingleton<SessionRepository>(SessionRepositoryImpl(
      sessionRemoteDatasource: getIt<SessionRemoteDatasource>()));
  getIt.registerSingleton<ApprovalRepository>(ApprovalRepositoryImpl(
      approvalRemoteDatasource: getIt<ApprovalRemoteDatasource>()));
  getIt.registerSingleton<NotifRepository>(NotifRepositoryImpl());

  getIt.registerSingleton<ExecutionRepository>(ExecutionRepositoryImpl(
      executionRemoteDatasource: getIt<ExecutionRemoteDatasource>()));
}
