import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard_controller.dart';
import '../../widgets/overview_card.dart';
import '../../widgets/expense_progress_bar.dart';
import '../../widgets/transaction_tile.dart';
import '../add_expense/add_expense_screen.dart';
import '../history/transaction_history_screen.dart';
import '../settings/settings_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final summaryAsync = ref.watch(dashboardSummaryProvider);
     final transactionsAsync = ref.watch(dashboardRecentTransactionsProvider);

     return Scaffold(
       appBar: AppBar(
         title: const Text('Dashboard'),
         actions: [
           IconButton(
             onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (c) => const SettingsScreen()));
             }, 
             icon: const Icon(Icons.settings),
           ),
         ],
       ),
       body: summaryAsync.when(
         data: (summary) {
           if (summary == null) {
             return const Center(child: Text('Belum ada data bulan ini.'));
           }
           return RefreshIndicator(
             onRefresh: () async {
               ref.invalidate(dashboardSummaryProvider);
               ref.invalidate(dashboardRecentTransactionsProvider);
             },
             child: SingleChildScrollView(
               padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
               physics: const AlwaysScrollableScrollPhysics(),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                    OverviewCard(
                      income: summary.totalIncome, 
                      expenses: summary.totalExpenses,
                      savings: summary.initialSavings,
                    ),
                    const SizedBox(height: 16),
                    ExpenseProgressBar(
                      salary: summary.totalSalary,
                      expenses: summary.totalExpenses,
                    ),
                    const SizedBox(height: 24),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Transaksi Terakhir',
                         style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                       ),
                         TextButton(
                           onPressed: () {
                             // Navigate to History Screen
                             Navigator.push(context, MaterialPageRoute(builder: (c) => const TransactionHistoryScreen()));
                           },
                           child: Text("Lihat Semua", style: TextStyle(fontFamily: 'Outfit',color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w800)),
                         ),
                     ],
                   ),
                    const SizedBox(height: 16),
                    transactionsAsync.when(
                      data: (transactions) {
                        if (transactions.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.receipt_long, size: 48, color: Colors.grey[400]),
                                const SizedBox(height: 8),
                                Text('Belum ada transaksi', style: TextStyle(fontFamily: 'Outfit',color: Colors.grey[400], fontSize: 16, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            return TransactionTile(transaction: transactions[index]);
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, st) => Text('Error loading transactions: $err'),
                    ),
                 ],
               ),
             ),
           );
         },
         error: (err, st) => Center(child: Text('Error: $err')),
         loading: () => const Center(child: CircularProgressIndicator()),
       ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
          // Refresh dashboard after returning (if any change happened)
          // Since we use Riverpod Streams, it might auto-refresh if DB changes are emitted.
          // But 'dashboardSummaryProvider' uses 'watchCurrentMonthSummary' which is a Stream.
          // So it SHOULD update automatically.
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
