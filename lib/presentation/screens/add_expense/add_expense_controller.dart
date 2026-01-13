import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart'; // Needed for Value
import '../../providers/database_provider.dart';
import '../../../data/local/database.dart';

// Manual definition using AsyncNotifier (Riverpod 2.0+)
final addExpenseControllerProvider = AsyncNotifierProvider.autoDispose<AddExpenseControllerNotifier, void>(AddExpenseControllerNotifier.new);

class AddExpenseControllerNotifier extends AutoDisposeAsyncNotifier<void> {
  
  @override
  FutureOr<void> build() {
    // Initial state is empty/success (void)
    return null;
  }

  Future<void> saveExpense({
    required double amount,
    required String category,
    required String note,
    required DateTime date,
    required bool isExpense, // New parameter
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final db = ref.read(databaseProvider);

      // 1. Insert Transaction
      await db.into(db.transactions).insert(
            TransactionsCompanion.insert(
              amount: amount,
              category: category,
              note: note.isNotEmpty ? Value(note) : const Value.absent(),
              date: date,
              isExpense: Value(isExpense),
            ),
          );

      // 2. Update Monthly Summary
      final startOfMonth = DateTime(date.year, date.month, 1);
      final summary = await (db.select(db.monthlySummaries)
            ..where((tbl) => tbl.month.equals(startOfMonth)))
          .getSingleOrNull();

      if (summary != null) {
        if (isExpense) {
          final newTotal = summary.totalExpenses + amount;
          await (db.update(db.monthlySummaries)..where((tbl) => tbl.id.equals(summary.id)))
              .write(MonthlySummariesCompanion(totalExpenses: Value(newTotal)));
        } else {
          final newTotal = summary.totalIncome + amount;
          await (db.update(db.monthlySummaries)..where((tbl) => tbl.id.equals(summary.id)))
              .write(MonthlySummariesCompanion(totalIncome: Value(newTotal)));
        }
      } else {
         await db.into(db.monthlySummaries).insert(
          MonthlySummariesCompanion.insert(
            month: startOfMonth,
            totalSalary: const Value(0.0),
            totalExpenses: isExpense ? Value(amount) : const Value(0.0),
            totalIncome: isExpense ? const Value(0.0) : Value(amount),
            initialSavings: const Value(0.0),
          ),
        );
      }
    });
  }

  Future<void> editExpense({
    required int id,
    required double oldAmount,
    required double newAmount,
    required String category,
    required String note,
    required DateTime date, 
    required bool isExpense,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final db = ref.read(databaseProvider);

      // 1. Update Transaction
      await (db.update(db.transactions)..where((t) => t.id.equals(id))).write(
        TransactionsCompanion(
          amount: Value(newAmount),
          category: Value(category),
          note: Value(note),
          date: Value(date),
          isExpense: Value(isExpense),
        ),
      );

      // 2. Update Monthly Summary (Simple Logic: Same Month)
      final startOfMonth = DateTime(date.year, date.month, 1);
      final summary = await (db.select(db.monthlySummaries)
            ..where((tbl) => tbl.month.equals(startOfMonth)))
          .getSingleOrNull();

      if (summary != null) {
        if (isExpense) {
          final newTotal = (summary.totalExpenses - oldAmount) + newAmount;
          await (db.update(db.monthlySummaries)..where((tbl) => tbl.id.equals(summary.id)))
              .write(MonthlySummariesCompanion(totalExpenses: Value(newTotal)));
        } else {
          final newTotal = (summary.totalIncome - oldAmount) + newAmount;
          await (db.update(db.monthlySummaries)..where((tbl) => tbl.id.equals(summary.id)))
              .write(MonthlySummariesCompanion(totalIncome: Value(newTotal)));
        }
      }
    });
  }
}
