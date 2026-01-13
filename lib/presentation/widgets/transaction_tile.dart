import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../data/local/database.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntry transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: transaction.isExpense 
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1) 
                : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.isExpense ? Icons.arrow_upward : Icons.arrow_downward, // Visual indicator
              color: transaction.isExpense ? Theme.of(context).colorScheme.primary : Colors.greenAccent,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (transaction.note != null && transaction.note!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    transaction.note!,
                    style: GoogleFonts.outfit(
                      color: Colors.white, // Full White
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${transaction.isExpense ? '-' : '+'} ${currencyFormat.format(transaction.amount)}",
                style: GoogleFonts.outfit(
                  color: transaction.isExpense ? const Color(0xFFFF8A80) : const Color(0xFF69F0AE), // Red vs Green
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('d MMM').format(transaction.date), // Date
                style: GoogleFonts.outfit(
                  color: Colors.white70, // Sharp White70
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
