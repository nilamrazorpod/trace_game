import 'package:go_router/go_router.dart';
import 'package:trace_game/routing/router_names.dart';
import 'package:trace_game/routing/screen_not_found.dart';

import '../src/module1/trace_game/landing_page.dart';

class AppRouter {
  late final GoRouter goRouter;

  AppRouter() {
    goRouter = GoRouter(
      initialLocation: '/login',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoute.splash.getPath,
          name: AppRoute.splash.getName,
          builder: (context, state) => const MainScreen(),
        ),
        // GoRoute(
        //   path: AppRoute.login.getPath,
        //   name: AppRoute.login.getName,
        //   builder: (context, state) => const LoginScreen(),
        // ),
        // // Define a ShellRoute for the side menu and dashboard screens
        // ShellRoute(
        //   builder: (context, state, child) {
        //     return ShellLayout(child: child); // Your shell layout widget
        //   },
        //   routes: [
        //     GoRoute(
        //       path: '/mainScreen',
        //       builder: (context, state) => const Dashboard(),
        //     ),
        //     GoRoute(
        //       path: '/requests',
        //       builder: (context, state) => const AddRequest(),
        //     ),
        //     GoRoute(
        //       path: '/editrequest',
        //       builder: (context, state) => const EditRequestScreen(),
        //     ),
        //     GoRoute(
        //       path: '/viewrequest',
        //       builder: (context, state) => const ViewRequestScreen(),
        //     ),
        //     GoRoute(
        //       path: '/location',
        //       builder: (context, state) => const LocationScreen(),
        //     ),
        //     GoRoute(
        //       path: '/kaizenform',
        //       builder: (context, state) => const KaizensTabs(),
        //     ),
        //     GoRoute(
        //       path: '/shivendra',
        //       builder: (context, state) => const KaizenPillarView(),
        //     ),
        //     GoRoute(
        //       path: '/kaizenTheme',
        //       builder: (context, state) => const KaizenThemeView(),
        //     ),
        //     GoRoute(
        //       path: '/kaizenAddPillar',
        //       builder: (context, state) => const AddPillarView(),
        //     ),
        //     GoRoute(
        //       path: '/kaizenAddTheme',
        //       builder: (context, state) => const AddThemeView(),
        //     ),
        //     GoRoute(
        //       path: '/kaizenLoss',
        //       builder: (context, state) => const KaizenLossView(),
        //     ),
        //     GoRoute(
        //       path: '/kaizenAddLoss',
        //       builder: (context, state) => const AddLoss(),
        //     ),
        //   ],
        // ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
}
