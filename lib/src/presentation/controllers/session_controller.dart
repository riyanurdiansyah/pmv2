// import 'package:get/get.dart';
// import 'package:pman/src/data/remote/session_remote_datasource.dart';
// import 'package:pman/src/domain/usecases/session_usecase.dart';
// import 'package:pman/src/utils/session/session_repository.dart';

// class SessionController extends GetxController {
//   final Rx<String> token = "".obs;

//   Future<bool> refreshToken() async {
//     final SessionRemoteDatasource sessionRemoteDatasource =
//         SessionRemoteDatasourceImpl();
//     final SessionRepository sessionRepository =
//         SessionRepositoryImpl(sessionRemoteDatasource: sessionRemoteDatasource);

//     final newToken = await SessionUseCaseRefreshToken(sessionRepository).call();
//     token.value = newToken;

//     if (newToken.isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
// }
