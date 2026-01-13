import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard/dashboard_controller.dart';
import '../dashboard/dashboard_screen.dart';
import '../setup/setup_screen.dart';

class RootWrapper extends ConsumerWidget {
  const RootWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine screen based on whether we have data for this month
    final summaryAsync = ref.watch(dashboardSummaryProvider);

    return summaryAsync.when(
      data: (summary) {
        if (summary != null) {
          return const DashboardScreen();
        } else {
          return const SetupScreen();
        }
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error init: $e'))),
    );
  }
}
