import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pman/src/entities/project_leader.dart';
import 'package:pman/src/presentation/controllers/approve_controller.dart';
import 'package:pman/src/presentation/controllers/dashboard_controller.dart';
import 'package:pman/src/presentation/controllers/event_controller.dart';
import 'package:pman/src/presentation/controllers/execution_controller.dart';
import 'package:pman/src/presentation/controllers/execution_detail_controller.dart';
import 'package:pman/src/presentation/controllers/home_controller.dart';
import 'package:pman/src/presentation/controllers/mytask_controller.dart';
import 'package:pman/src/presentation/controllers/profile_controller.dart';
import 'package:pman/src/presentation/controllers/role_controller.dart';
import 'package:pman/src/presentation/controllers/signin_controller.dart';
import 'package:pman/src/presentation/controllers/update_controller.dart';
import 'package:pman/src/presentation/views/addtask_page.dart';
import 'package:pman/src/presentation/views/approve_page.dart';
import 'package:pman/src/presentation/views/dashboard_page.dart';
import 'package:pman/src/presentation/views/event_page.dart';
import 'package:pman/src/presentation/views/home_page.dart';
import 'package:pman/src/presentation/views/my_task_page.dart';
import 'package:pman/src/presentation/views/not_found_page.dart';
import 'package:pman/src/presentation/views/profile_page.dart';
import 'package:pman/src/presentation/views/role_page.dart';
import 'package:pman/src/presentation/views/signin_page.dart';
import 'package:pman/src/presentation/views/splash_page.dart';
import 'package:pman/src/presentation/views/task_status_page.dart';
import 'package:pman/src/presentation/views/update_page.dart';
import 'package:pman/src/presentation/views/version_page.dart';
import 'package:pman/src/presentation/views/widgets/addtask_detail_page.dart';

import '../../entities/execution_project_detail.dart';
import '../../presentation/controllers/notif_controller.dart';
import '../../presentation/views/notif_page.dart';
import '../../presentation/views/task_detail_page.dart';
import 'app_route_name.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage fadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

CustomTransitionPage bottomToUpTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

CustomTransitionPage slideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required bool leftToRight,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(0.75, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeIn)),
      ),
      textDirection: leftToRight ? TextDirection.ltr : TextDirection.rtl,
      child: child,
    ),
  );
}

GoRouter router = GoRouter(
  errorPageBuilder: (context, state) =>
      const NoTransitionPage(child: NotFoundPage()),
  navigatorKey: navigatorKey,
  initialLocation: "/${AppRouteName.splash}",
  debugLogDiagnostics: true,
  //

  routes: [
    GoRoute(
      path: '/${AppRouteName.splash}',
      name: AppRouteName.splash,
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/${AppRouteName.event}',
      name: AppRouteName.event,
      onExit: (context) => Get.delete<EventController>(),
      pageBuilder: (context, state) {
        Get.put(EventController());
        return fadeTransition(
          context: context,
          state: state,
          child: EventPage(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/${AppRouteName.log}',
      name: AppRouteName.log,
      pageBuilder: (context, state) {
        return fadeTransition(
          context: context,
          state: state,
          child: TaskStatusPage(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: '/${AppRouteName.signin}',
      name: AppRouteName.signin,
      onExit: (context) => Get.delete<SigninController>(),
      builder: (context, state) {
        Get.put(SigninController());
        return SigninPage();
      },
    ),
    GoRoute(
      path: '/${AppRouteName.version}',
      name: AppRouteName.version,
      builder: (context, state) {
        Object? extra = state.extra;
        String link = "";

        if (extra != null && extra is Map<String, dynamic>) {
          link = extra["link"];
        }
        return VersionPage(
          link: link,
        );
      },
    ),
    GoRoute(
      path: '/${AppRouteName.role}',
      name: AppRouteName.role,
      onExit: (context) => Get.delete<RoleController>(),
      builder: (context, state) {
        Get.put(RoleController());
        return RolePage();
      },
    ),
    GoRoute(
      parentNavigatorKey: navigatorKey,
      path: "/${AppRouteName.notification}",
      name: AppRouteName.notification,
      onExit: (context) => Get.delete<NotifController>(),
      pageBuilder: (context, state) {
        Get.put(NotifController());
        return slideTransition(
          context: context,
          state: state,
          leftToRight: true,
          child: NotifPage(),
        );
      },
    ),
    GoRoute(
        parentNavigatorKey: navigatorKey,
        path: "/${AppRouteName.executionProject}",
        name: AppRouteName.executionProject,
        onExit: (context) => Get.delete<ExecutionProjectController>(),
        pageBuilder: (context, state) {
          Get.put(ExecutionProjectController());
          return fadeTransition(
            context: context,
            state: state,
            child: AddTaskPage(),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: navigatorKey,
            path: AppRouteName.executionProjectDetail,
            name: AppRouteName.executionProjectDetail,
            onExit: (context) => Get.delete<ExecutionProjectDetailController>(),
            pageBuilder: (context, state) {
              final eC = Get.put(ExecutionProjectDetailController());
              Object? extra = state.extra;
              if (extra != null && extra is Map<String, dynamic>) {
                eC.bodyRequest = extra["request"];
              }
              return fadeTransition(
                context: context,
                state: state,
                child: AddTaskDetailPage(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: navigatorKey,
                path: AppRouteName.taskDetail,
                name: AppRouteName.taskDetail,
                pageBuilder: (context, state) {
                  Object? extra = state.extra;
                  TrProjectObjectiveMilestoneTaskDetail? data;
                  if (extra != null && extra is Map<String, dynamic>) {
                    data = extra["data"];
                  }
                  return bottomToUpTransition(
                    context: context,
                    state: state,
                    child: TaskDetailPage(
                      data: data,
                    ),
                  );
                },
              ),
            ],
          ),
        ]),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      parentNavigatorKey: navigatorKey,
      pageBuilder: ((context, state, child) {
        Get.put(DashboardController());
        return fadeTransition(
          context: context,
          state: state,
          child: DashboardPage(
            widget: child,
            route: state.matchedLocation,
          ),
        );
      }),
      routes: [
        GoRoute(
          path: "/",
          name: AppRouteName.app,
          onExit: (context) {
            Get.delete<HomeController>();
            return true;
          },
          pageBuilder: (context, state) {
            Get.put(HomeController());
            return fadeTransition(
              context: context,
              state: state,
              child: HomePage(),
            );
          },
          routes: [
            GoRoute(
              path: AppRouteName.profile,
              name: AppRouteName.profile,
              onExit: (context) {
                Get.delete<ProfileController>();
                return true;
              },
              pageBuilder: (context, state) {
                Get.put(ProfileController());
                return fadeTransition(
                  context: context,
                  state: state,
                  child: ProfilePage(),
                );
              },
            ),
            // GoRoute(
            //   path: AppRouteName.approvalTask,
            //   name: AppRouteName.approvalTask,
            //   onExit: (context) => Get.delete<ApproveController>(),
            //   pageBuilder: (context, state) {
            //     Get.put(ApproveController());
            //     return fadeTransition(
            //       context: context,
            //       state: state,
            //       child: ApprovePage(),
            //     );
            //   },
            // ),
            GoRoute(
              path: AppRouteName.home,
              name: AppRouteName.home,
              onExit: (context) => Get.delete<HomeController>(),
              pageBuilder: (context, state) {
                Get.put(HomeController());
                return fadeTransition(
                  context: context,
                  state: state,
                  child: HomePage(),
                );
              },
            ),
            GoRoute(
              path: AppRouteName.mytask,
              name: AppRouteName.mytask,
              onExit: (context) => Get.delete<MyTaskController>(),
              pageBuilder: (context, state) {
                Object? extra = state.extra;
                final mC = Get.put(MyTaskController());
                if (extra != null && extra is Map<String, dynamic>) {
                  mC.tcSearch.text = extra["search"] ?? "";
                  mC.onSearchTask(mC.tcSearch.text);
                }
                return fadeTransition(
                  context: context,
                  state: state,
                  child: MyTaskPage(),
                );
              },
            ),
            GoRoute(
              path: AppRouteName.update,
              name: AppRouteName.update,
              onExit: (context) => Get.delete<UpdateController>(),
              pageBuilder: (context, state) {
                Get.put(UpdateController());
                return fadeTransition(
                  context: context,
                  state: state,
                  child: const UpdatePage(),
                );
              },
            ),
            GoRoute(
              path: AppRouteName.approve,
              name: AppRouteName.approve,
              onExit: (context) => Get.delete<ApproveController>(),
              pageBuilder: (context, state) {
                final aC = Get.put(ApproveController());
                Object? extra = state.extra;
                String? txtPicStreamNik;
                String? txtPicStreamName;
                String? txtSearch;
                if (extra != null && extra is Map<String, dynamic>) {
                  txtPicStreamName = extra["txtPicStreamName"];
                  txtPicStreamNik = extra["txtPicStreamNik"];
                  txtSearch = extra["search"];

                  if (txtPicStreamNik != null && txtPicStreamName != null) {
                    aC
                        .onChangeLead(
                      ProjectLeaderObjData(
                        txtPicStreamName: txtPicStreamName,
                        txtPicStreamNik: txtPicStreamNik,
                      ),
                    )
                        .then((value) {
                      aC.tcSearch.text = txtSearch ?? "";
                      aC.onSearchApproval(aC.tcSearch.text);
                    });
                  }
                }
                return fadeTransition(
                  context: context,
                  state: state,
                  child: ApprovePage(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
