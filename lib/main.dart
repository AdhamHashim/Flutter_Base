// Import for logging with EasyLocalization (helps debug translation issues)
import 'package:easy_logger/easy_logger.dart';

// Import for initializing Firebase in the app
import 'package:firebase_core/firebase_core.dart';

// Provides constants like kDebugMode / kReleaseMode to detect app mode
import 'package:flutter/foundation.dart';

// Import the EasyLocalization package for managing multiple languages
import 'package:easy_localization/easy_localization.dart';

// Flutter’s main UI framework
import 'package:flutter/material.dart';

// To control system UI features like orientation, status bar, etc.
import 'package:flutter/services.dart';

// Package for simple animations
import 'package:flutter_animate/flutter_animate.dart';

// State management library using BLoC pattern
import 'package:flutter_bloc/flutter_bloc.dart';

// ScreenUtil for responsive UI (adapts sizes to different screens)
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import the root app widget
import 'src/app.dart';

// Import language configuration (supported locales, translations setup)
import 'src/config/language/languages.dart';

// Import global configuration (colors, themes, constants, etc.)
import 'src/config/res/config_imports.dart';

// Helpers (like utility functions, e.g. changeStatusbarColor)
import 'src/core/helpers/helpers.dart';

// Navigation constants (routes, IDs, etc.)
import 'src/core/navigation/Constants/imports_constants.dart';

// Navigation helper (custom go-router like solution)
import 'src/core/navigation/go.dart';

// Page router implementation (to manage transitions, routes, etc.)
import 'src/core/navigation/page_router/implementation/imports_page_router.dart';

// Page router builder (for initializing routing)
import 'src/core/navigation/page_router/imports_page_router_builder.dart';

// Cache service (for storing data locally, e.g. SharedPreferences)
import 'src/core/helpers/cache_service.dart';

// Backend configuration (to set which backend type the app connects to)
import 'src/core/network/backend_configuation.dart';

// Service locator setup (dependency injection)
import 'src/core/shared/functions/setup_service_locators.dart';

// Custom BlocObserver (to log or track bloc events and transitions)
import 'src/core/shared/bloc_observer.dart';

// A widget that shows a custom error screen for unhandled exceptions
import 'src/core/widgets/exeption_view.dart';

// Entry point of the app
void main() async {
  // Change status bar color globally at app start
  Helpers.changeStatusbarColor(statusBarColor: AppColors.main);

  // Attach custom Bloc observer to monitor state transitions
  Bloc.observer = AppBlocObserver();

  // Ensures Flutter engine is initialized before running async code
  WidgetsFlutterBinding.ensureInitialized();

  // Run multiple async initializations in parallel before app starts
  await Future.wait(
    [
      Firebase.initializeApp(), // Initialize Firebase
      EasyLocalization.ensureInitialized(), // Initialize localization
      CacheStorage.init(), // Initialize local cache
      ScreenUtil.ensureScreenSize() // Initialize screen size utils
    ],
  );

  // Lock the app orientation to portrait only
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  // Setup dependency injection (register services, repositories, etc.)
  setUpServiceLocator();

  // Configure backend type (e.g. ASP.NET backend)
  BackendConfiguation.setBackendType(BackendType.asp);

  // Initialize page router with custom transition animations
  PageRouterBuilder().initAppRouter(
    config: PlatformConfig(
      android: CustomPageRouterCreator(
        parentTransition: TransitionType.fade, // Transition type: fade
        parentOptions: const FadeAnimationOptions(
          duration: Duration(milliseconds: 300), // Transition duration
        ),
      ),
    ),
  );

  // Restart animations when hot reload happens (developer experience)
  Animate.restartOnHotReload = true;

  // In release mode → replace Flutter’s red error screen with custom widget
  if (kReleaseMode) {
    ErrorWidget.builder =
        (FlutterErrorDetails details) => const ExceptionView();
  }

  // In debug mode → enable EasyLocalization logs for error + warning
  if (kDebugMode) {
    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
      LevelMessages.warning
    ];
  }

  // Run the actual app wrapped with EasyLocalization widget
  runApp(
    EasyLocalization(
      supportedLocales: Languages.supportLocales,
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('ar'),
      child: const App(), // Root app widget
    ),
  );
}
