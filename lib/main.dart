import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/display/root_wrapper.dart';
import 'presentation/screens/error/error_screen.dart';

void main() {
  // Capture Flutter Framework Errors (Widget rendering, etc.)
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kReleaseMode) {
      // In release, show the friendly error screen instead of the red screen
      runApp(
        MaterialApp(
          home: ErrorScreen(
            error: details.exception,
            onRetry: () {
               main();
            },
          ),
        ),
      );
    } else {
      // In debug, show the console dump and red screen as usual
      FlutterError.dumpErrorToConsole(details);
    }
  };

  // Capture Asynchronous Errors (Futures, Streams)
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kReleaseMode) {
       runApp(
        MaterialApp(
          home: ErrorScreen(
            error: error,
            onRetry: () {
               main();
            },
          ),
        ),
      );
      return true; // Error handled
    }
    return false; // Let it propagate in debug
  };

  runApp(const ProviderScope(child: ECashApp()));
}

class ECashApp extends StatelessWidget {
  const ECashApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Edge-to-Edge Configuration
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      // Auto-adjust icons based on theme is handy, but let's stick to status bar brightness
      statusBarIconBrightness: Brightness.dark, 
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'ECash',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      home: const RootWrapper(), 
    );
  }
}
