import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'settings_controller.dart';
import '../setup/setup_screen.dart'; // For redirect after reset
import '../display/root_wrapper.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _salaryController = TextEditingController();
  final _savingsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load initial data
    ref.read(currentBudgetProvider.future).then((summary) {
      if (summary != null && mounted) {
        _salaryController.text = summary.totalSalary.toInt().toString();
        // Calculate and show Current Balance
        final currentBalance = summary.initialSavings + summary.totalIncome - summary.totalExpenses;
        _savingsController.text = currentBalance.toInt().toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsControllerProvider);
    
    ref.listen<AsyncValue<void>>(settingsControllerProvider, (prev, next) {
        if (next is AsyncData && (prev?.isLoading ?? false)) {
             // Success
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pengaturan disimpan!")));
        } else if (next is AsyncError) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${next.error}")));
        }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.of(context).padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit Anggaran Bulan Ini", style: TextStyle(fontFamily: 'Outfit',fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
            const SizedBox(height: 24),
            
            Text("Gaji Bulanan (Rp)", style: TextStyle(fontFamily: 'Outfit',color: Colors.white70, fontWeight: FontWeight.w500)),
            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontWeight: FontWeight.w800),
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).cardTheme.color,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
             Text("Target Tabungan (Rp)", style: TextStyle(fontFamily: 'Outfit',color: Colors.white70, fontWeight: FontWeight.w500)),
            TextField(
              controller: _savingsController,
              keyboardType: TextInputType.number,
                 style: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontWeight: FontWeight.w800),
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).cardTheme.color,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isLoading ? null : () async {
                   final salary = double.tryParse(_salaryController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                   final targetBalance = double.tryParse(_savingsController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                   
                   await ref.read(settingsControllerProvider.notifier).updateBudget(salary: salary, targetBalance: targetBalance);
                },
                child: state.isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Update Anggaran"),
              ),
            ),
            
            const SizedBox(height: 48),
            const Divider(color: Colors.white24),
            const SizedBox(height: 24),
            
            Text("Zona Bahaya", style: TextStyle(fontFamily: 'Outfit',fontSize: 18, fontWeight: FontWeight.w800, color: Colors.redAccent)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12),
                color: Colors.red.withOpacity(0.1),
              ),
              child: Column(
                children: [
                   Text(
                     "Reset Data akan menghapus semua riwayat transaksi dan pengaturan anggaran bulan ini.", 
                     style: TextStyle(fontFamily: 'Outfit',color: Colors.white70),
                     textAlign: TextAlign.center,
                   ),
                   const SizedBox(height: 16),
                   const SizedBox(height: 16),
                   SizedBox(
                     width: double.infinity,
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.red,
                         foregroundColor: Colors.white,
                       ),
                       onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context, 
                            builder: (c) => AlertDialog(
                              title: const Text("Yakin Reset Data?"),
                              content: const Text("Tindakan ini tidak bisa dibatalkan."),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
                                TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Reset", style: TextStyle(color: Colors.red))),
                              ],
                            )
                          );
                          
                          if (confirm == true) {
                             await ref.read(settingsControllerProvider.notifier).resetAllData();
                             if (context.mounted) {
                               // Navigate to Setup Screen (clear stack)
                               Navigator.of(context).pushAndRemoveUntil(
                                 MaterialPageRoute(builder: (c) => const SetupScreen()),
                                 (route) => false,
                               );
                             }
                          }
                       }, 
                       child: const Text("Reset Semua Data"),
                     ),
                   )
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            Text("Manajemen Data", style: TextStyle(fontFamily: 'Outfit',fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.download_rounded, color: Colors.blueAccent),
                    title: Text("Backup Data", style: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontWeight: FontWeight.w600)),
                    subtitle: Text("Simpan data ke file (Drive/WA)", style: TextStyle(fontFamily: 'Outfit',color: Colors.white54, fontSize: 12)),
                    onTap: () async {
                       try {
                         await ref.read(settingsControllerProvider.notifier).exportData();
                       } catch (e) {
                         if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal backup: $e")));
                         }
                       }
                    },
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  ListTile(
                    leading: const Icon(Icons.upload_rounded, color: Colors.orangeAccent),
                    title: Text("Restore Data", style: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontWeight: FontWeight.w600)),
                    subtitle: Text("Kembalikan data dari file backup", style: TextStyle(fontFamily: 'Outfit',color: Colors.white54, fontSize: 12)),
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context, 
                        builder: (c) => AlertDialog(
                          title: const Text("Restore Data?"),
                          content: const Text("Data saat ini akan DIHAPUS dan diganti dengan data dari file backup. Lanjutkan?"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Batal")),
                            TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Restore", style: TextStyle(color: Colors.red))),
                          ],
                        )
                      );

                      if (confirm == true) {
                         try {
                           final success = await ref.read(settingsControllerProvider.notifier).importData();
                           if (success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Restore Berhasil! Restart aplikasi jika data belum muncul.")));
                               Navigator.of(context).pushAndRemoveUntil(
                                   MaterialPageRoute(builder: (c) => const RootWrapper()), 
                                   (route) => false,
                                 );
                           }
                         } catch (e) {
                            if (context.mounted) {
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal restore: $e")));
                            }
                         }
                      }
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 48),
            Center(
               child: Text("Ver 1.0.0", style: TextStyle(fontFamily: 'Outfit',color: Colors.grey[700])),
            )
          ],
        ),
      ),
    );
  }
}
