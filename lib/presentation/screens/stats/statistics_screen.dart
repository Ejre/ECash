import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import '../history/transaction_history_screen.dart';
import '../../../../data/local/database.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionHistoryProvider);

    return transactionsAsync.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return Center(
            child: Text("Belum ada data", style: TextStyle(fontFamily: 'Outfit',color: Colors.grey)),
          );
        }

        // 1. Group by Category
        final categoryTotals = <String, double>{};
        double totalExpenses = 0;

        for (var tx in transactions) {
          // Assuming all transactions in this list are expenses (since we only add expenses)
          // If we had income, we'd filter here.
          categoryTotals.update(tx.category, (value) => value + tx.amount, ifAbsent: () => tx.amount);
          totalExpenses += tx.amount;
        }

        // 2. Prepare Chart Data
        final sections = categoryTotals.entries.map((entry) {
          final percentage = (entry.value / totalExpenses) * 100;
          return PieChartSectionData(
            color: _getColorForCategory(entry.key),
            value: entry.value,
            title: '${percentage.toStringAsFixed(0)}%',
            radius: 60, // Thicker radius
            titleStyle: TextStyle(fontFamily: 'Outfit',
              fontSize: 14, 
              fontWeight: FontWeight.bold, 
              color: Colors.white,
            ),
          );
        }).toList();

        final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text("Total Pengeluaran", style: TextStyle(fontFamily: 'Outfit',color: Colors.grey)),
              const SizedBox(height: 8),
              Text(
                currencyFormat.format(totalExpenses),
                style: TextStyle(fontFamily: 'Outfit',fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Legend List
              ...categoryTotals.entries.map((entry) {
                 final percentage = (entry.value / totalExpenses) * 100;
                 return Padding(
                   padding: const EdgeInsets.only(bottom: 12),
                   child: Row(
                     children: [
                       Container(
                         width: 16, 
                         height: 16, 
                         decoration: BoxDecoration(
                           color: _getColorForCategory(entry.key),
                           shape: BoxShape.circle,
                         ),
                       ),
                       const SizedBox(width: 12),
                       Expanded(
                         child: Text(entry.key, style: TextStyle(fontFamily: 'Outfit',fontSize: 16)),
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text(currencyFormat.format(entry.value), style: TextStyle(fontFamily: 'Outfit',fontWeight: FontWeight.bold)),
                           Text('${percentage.toStringAsFixed(1)}%', style: TextStyle(fontFamily: 'Outfit',fontSize: 12, color: Colors.grey)),
                         ],
                       ),
                     ],
                   ),
                 );
              }).toList(),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, st) => Center(child: Text("Error: $err")),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Makan': return Colors.orange;
      case 'Transport': return Colors.blue;
      case 'Belanja': return Colors.purple;
      case 'Hiburan': return Colors.pink;
      case 'Tagihan': return Colors.red;
      case 'Lainnya': return Colors.grey;
      default: return Colors.teal;
    }
  }
}
