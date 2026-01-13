import 'package:drift/drift.dart';
import '../local/database.dart';

class DashboardRepository {
  final AppDatabase _db;

  DashboardRepository(this._db);

  Stream<MonthlySummary?> watchCurrentMonthSummary() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    
    return (_db.select(_db.monthlySummaries)
      ..where((tbl) => tbl.month.equals(startOfMonth)))
      .watchSingleOrNull();
  }

  Future<MonthlySummary?> getCurrentMonthSummary() async {
     final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    
    return (_db.select(_db.monthlySummaries)
      ..where((tbl) => tbl.month.equals(startOfMonth)))
      .getSingleOrNull();
  }
  Stream<List<TransactionEntry>> watchRecentTransactions() {
    return (_db.select(_db.transactions)
      ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
      ..limit(5))
      .watch();
  }
}
