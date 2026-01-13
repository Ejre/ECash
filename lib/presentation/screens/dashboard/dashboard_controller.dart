import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/database.dart';
import '../../../data/repositories/dashboard_repository.dart';
import '../../providers/database_provider.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref.watch(databaseProvider));
});

final dashboardSummaryProvider = StreamProvider<MonthlySummary?>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.watchCurrentMonthSummary();
});

final dashboardRecentTransactionsProvider = StreamProvider<List<TransactionEntry>>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return repo.watchRecentTransactions();
});
