import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../providers/database_provider.dart';
import '../../../data/local/database.dart';

final transactionControllerProvider = AsyncNotifierProvider.autoDispose<TransactionControllerNotifier, void>(TransactionControllerNotifier.new);

class TransactionControllerNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> deleteTransaction(TransactionEntry transaction) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final db = ref.read(databaseProvider);

      // 1. Delete Transaction
      await (db.delete(db.transactions)..where((t) => t.id.equals(transaction.id))).go();

      // 2. Update Monthly Summary (Subtract amount)
      final startOfMonth = DateTime(transaction.date.year, transaction.date.month, 1);
      final summary = await (db.select(db.monthlySummaries)
            ..where((tbl) => tbl.month.equals(startOfMonth)))
          .getSingleOrNull();

      if (summary != null) {
        if (transaction.isExpense) {
          final newTotal = summary.totalExpenses - transaction.amount;
          await (db.update(db.monthlySummaries)..where((tbl) => tbl.id.equals(summary.id)))
              .write(MonthlySummariesCompanion(totalExpenses: Value(newTotal)));
        } else {
          final newTotal = summary.totalIncome - transaction.amount;
          await (db.update(db.monthlySummaries)..where((tbl) => tbl.id.equals(summary.id)))
              .write(MonthlySummariesCompanion(totalIncome: Value(newTotal)));
        }
      }
    });
  }
}
