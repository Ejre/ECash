import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/database_provider.dart';
import '../../widgets/transaction_tile.dart';
import '../../../data/local/database.dart';
import 'package:drift/drift.dart' as drift;
import 'transaction_controller.dart';
import '../add_expense/add_expense_screen.dart';
import '../stats/statistics_screen.dart';

final transactionHistoryProvider = StreamProvider.autoDispose<List<TransactionEntry>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.transactions)
        ..orderBy([(t) => drift.OrderingTerm(expression: t.date, mode: drift.OrderingMode.desc)]))
      .watch();
});

class TransactionHistoryScreen extends ConsumerWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(transactionHistoryProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Transaksi'),
          centerTitle: true,
          bottom: TabBar(
            labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            labelColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(text: "Riwayat"),
              Tab(text: "Statistik"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: LIST
            historyAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(Icons.history, size: 64, color: Colors.grey[700]),
                         const SizedBox(height: 16),
                         Text("Belum ada riwayat", style: GoogleFonts.outfit(color: Colors.grey[500], fontSize: 16)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: transactions.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                     final transaction = transactions[index];
                     return Dismissible(
                       key: Key(transaction.id.toString()),
                       direction: DismissDirection.endToStart,
                       background: Container(
                         alignment: Alignment.centerRight,
                         padding: const EdgeInsets.only(right: 20),
                         color: Colors.red,
                         child: const Icon(Icons.delete, color: Colors.white),
                       ),
                       confirmDismiss: (direction) async {
                         return await showDialog(
                           context: context,
                           builder: (context) => AlertDialog(
                             title: const Text("Hapus Transaksi?"),
                             content: const Text("Saldo bulan ini akan disesuaikan."),
                             actions: [
                               TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text("Batal")),
                               TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text("Hapus", style: TextStyle(color: Colors.red))),
                             ],
                           ),
                         );
                       },
                       onDismissed: (direction) {
                         ref.read(transactionControllerProvider.notifier).deleteTransaction(transaction);
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Transaksi dihapus")));
                       },
                       child: InkWell(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => AddExpenseScreen(transactionToEdit: transaction)),
                           );
                         },
                         child: TransactionTile(transaction: transaction),
                       ),
                     );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text('Error: $err')),
            ),
            
            // TAB 2: STATISTICS
            const StatisticsScreen(),
          ],
        ),
      ),
    );
  }
}
