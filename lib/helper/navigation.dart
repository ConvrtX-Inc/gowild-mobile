import 'package:beamer/beamer.dart';
import 'package:gowild/providers/auth.dart';
import 'package:gowild/ui/screens/auth/login.screen.dart';
import 'package:gowild/ui/screens/main/main.screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      // Return either Widgets or BeamPages if more customization is needed
      '/main': (context, state, data) => const MainScreen(),
      '/auth': (context, state, data) => const LoginScreen(),
    },
  ),
  guards: [
    BeamGuard(
      pathPatterns: ['/'],
      guardNonMatching: false,
      check: (context, location) => false,
      beamToNamed: (origin, target) => '/main',
    ),
    BeamGuard(
      pathPatterns: ['/main', '/main/**'],
      guardNonMatching: false,
      check: (context, location) =>
          ProviderScope.containerOf(context, listen: false)
              .read(authProvider)
              .status,
      beamToNamed: (origin, target) => '/auth',
    ),
    BeamGuard(
      pathPatterns: ['/auth', '/auth/**'],
      guardNonMatching: false,
      check: (context, location) =>
          !ProviderScope.containerOf(context, listen: false)
              .read(authProvider)
              .status,
      beamToNamed: (origin, target) => '/main',
    ),
  ],
);
