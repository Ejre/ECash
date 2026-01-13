import 'package:flutter/material.dart';


class ExpenseProgressBar extends StatelessWidget {
  final double salary;
  final double expenses;

  const ExpenseProgressBar({super.key, required this.salary, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Avoid division by zero
    final percentage = salary > 0 ? (expenses / salary).clamp(0.0, 1.0) : 0.0;
    final percentageString = (percentage * 100).toStringAsFixed(1);

    Color progressColor;
    if (percentage < 0.5) {
      progressColor = Colors.green;
    } else if (percentage < 0.8) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.red;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status Pengeluaran", style: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontWeight: FontWeight.w600)),
                Text(
                  "${(percentage * 100).toStringAsFixed(1)}%",
                  style: TextStyle(fontFamily: 'Outfit',
                    color: percentage > 0.8 ? const Color(0xFFE57373) : const Color(0xFF81C784), // Red if > 80%
                    fontWeight: FontWeight.w800, // Bold -> ExtraBold
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Changed from 12 to 8
            // ClipRRect removed
            LinearProgressIndicator(
              value: percentage.clamp(0.0, 1.0), // Clamped value
              minHeight: 12, // Thicker bar
              backgroundColor: Colors.grey[800], // Darker background for bar
              valueColor: AlwaysStoppedAnimation<Color>(
                percentage > 0.8 ? const Color(0xFFE57373) : const Color(0xFF81C784), // Direct color based on percentage
              ),
              borderRadius: BorderRadius.circular(6), // Added border radius
            ),
            const SizedBox(height: 8),
            Text(
              percentage > 0.8 ? "Hati-hati, pengeluaranmu tinggi!" : "Masih aman bos.", // Updated text
              style: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500), // Normal -> Medium
            ),
          ],
        ),
      ),
    );
  }
}
