import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../providers/database_provider.dart';
import '../../../data/local/database.dart';
import '../../../data/services/backup_service.dart';

// Provides current month summary for the settings form pre-fill
final currentBudgetProvider = FutureProvider.autoDispose<MonthlySummary?>((ref) async {
  final db = ref.watch(databaseProvider);
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  
  return (db.select(db.monthlySummaries)..where((tbl) => tbl.month.equals(startOfMonth))).getSingleOrNull();
});

final settingsControllerProvider = AsyncNotifierProvider.autoDispose<SettingsControllerNotifier, void>(SettingsControllerNotifier.new);

class SettingsControllerNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> updateBudget({required double salary, required double targetBalance}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final db = ref.read(databaseProvider);
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);

      // Check if entry exists
      final summary = await (db.select(db.monthlySummaries)
            ..where((tbl) => tbl.month.equals(startOfMonth)))
          .getSingleOrNull();

      if (summary != null) {
        // Calculate required initialSavings to achieve targetBalance
        // Target = InitialSavings + Income - Expenses
        // InitialSavings = Target - Income + Expenses
        final newInitialSavings = targetBalance - (summary.totalIncome - summary.totalExpenses);

        await (db.update(db.monthlySummaries)..where((tbl) => tbl.id.equals(summary.id)))
            .write(MonthlySummariesCompanion(
              totalSalary: Value(salary),
              initialSavings: Value(newInitialSavings),
            ));
      } else {
        // If creating new, we assume Income/Expenses are 0 from this summary perspective (or we should query them if we want to be robust, but usually summary exists if we are editing it)
        // Ideally we should calculate derived Current Balance if transactions exist. 
        // For simplicity/safeguard:
        
        // However, if summary is null, it means no month record. 
        // We will just set initialSavings = targetBalance because Income/Expense are defaults 0 in new record.
        await db.into(db.monthlySummaries).insert(MonthlySummariesCompanion.insert(
          month: startOfMonth,
          totalSalary: Value(salary),
          initialSavings: Value(targetBalance),
          totalExpenses: const Value(0),
          totalIncome: const Value(0), // Explicitly 0
        ));
      }
      
      // Refresh providers
      ref.invalidate(currentBudgetProvider);
    });
  }

  Future<void> resetAllData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final db = ref.read(databaseProvider);
      
      // Transactional delete to ensure consistency
      await db.transaction(() async {
        await db.delete(db.transactions).go();
        await db.delete(db.monthlySummaries).go();
      });
      
      // Need to communicate to the app that we are back to square one.
      // Navigation will handle redirecting to setup screen if needed, 
      // or we can just stay here but all data is 0.
    });
  }

  Future<void> exportData() async {
    // Don't update state to avoid triggering "Settings Saved" listener
    await BackupService().exportDatabase();
  }

  Future<bool> importData() async {
     // Don't update state to avoid triggering "Settings Saved" listener
     final success = await BackupService().importDatabase();
     if (success) {
        // Invalidate everything to force reload from new DB file
        ref.invalidate(databaseProvider);
        ref.invalidate(currentBudgetProvider);
     }
     return success;
  }
}
