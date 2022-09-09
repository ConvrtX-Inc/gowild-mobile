import 'package:beamer/beamer.dart';
import 'package:gowild/providers/auth.dart';
import 'package:gowild/providers/landing_page_provider.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/ui/screens/app/landing-page.screen.dart';
import 'package:gowild/ui/screens/auth/create-new-password.screen.dart';
import 'package:gowild/ui/screens/auth/e-waiver.screen.dart';
import 'package:gowild/ui/screens/auth/login.screen.dart';
import 'package:gowild/ui/screens/auth/register.screen.dart';
import 'package:gowild/ui/screens/auth/reset-password.screen.dart';
import 'package:gowild/ui/screens/auth/verify-phone.screen.dart';
import 'package:gowild/ui/screens/main/main.screen.dart';
import 'package:gowild/ui/screens/profile/faqs.screen.dart';
import 'package:gowild/ui/screens/profile/notification.screen.dart';
import 'package:gowild/ui/screens/profile/tickets.screen.dart';
import 'package:gowild/ui/widgets/map-overlay.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/landing-page': (context, state, data) => const LandingPageScreen(),
      '/main': (context, state, data) => const MainScreen(),
      '/main/map-overlay': (context, state, data) => const BeamPage(
            child: MapOverlayWidget(),
            fullScreenDialog: true,
          ),
      '/main/faqs': (context, state, data) => const FaqsScreen(),
      '/main/tickets': (context, state, data) => const TicketsScreen(),
      '/main/notifications': (context, state, data) =>
          const NotificationScreen(),
      '/auth': (context, state, data) => const LoginScreen(),
      '/auth/register': (context, state, data) => const RegisterScreen(),
      '/auth/register/verify-phone-number': (context, state, data) =>
          const VerifyPhoneScreen(),
      '/auth/reset-password': (context, state, data) =>
          const ResetPasswordScreen(),
      '/auth/reset-password/create-new-password': (context, state, data) =>
          const CreateNewPasswordScreen(),
      '/auth/e-waiver': (context, state, data) => const EWaiverScreen(),
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
      pathPatterns: ['/landing-page'],
      guardNonMatching: true,
      check: (context, location) {
        final result = ProviderScope.containerOf(context, listen: false)
            .read(hasSeenLandingPageProvider)
            .hasSeenLandingPage;
        logger.d('Has seen landing page check: $result');
        return result;
      },
      beamToNamed: (origin, target) => '/landing-page',
    ),
  ],
);
