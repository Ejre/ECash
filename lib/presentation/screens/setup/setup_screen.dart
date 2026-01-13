import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/currency_input_formatter.dart';
import 'setup_controller.dart';
import '../display/root_wrapper.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _salaryController = TextEditingController();
  final _savingsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _salaryController.dispose();
    _savingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupControllerProvider);

    // Listen for success
    ref.listen(setupControllerProvider, (previous, next) {
      if (!next.isLoading && !next.hasError && next is AsyncData && previous?.isLoading == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Setup Berhasil! Semangat nabung!')),
        );
        // Explicitly navigate to Dashboard to ensure user doesn't get stuck
        // We use pushAndRemoveUntil to clear the back stack so user can't go back to setup
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const RootWrapper()), 
          (route) => false,
        );
      } else if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error: ${next.error}')),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Icon(Icons.account_balance_wallet_rounded, size: 80, color: Theme.of(context).colorScheme.primary),
                   const SizedBox(height: 24),
                   Text(
                     'Halo, Bos!',
                     style: TextStyle(fontFamily: 'Outfit', // Use GoogleFonts
                       fontSize: 28, // Explicit size
                       fontWeight: FontWeight.bold,
                       color: Colors.white, // Explicit White
                     ),
                     textAlign: TextAlign.center,
                   ),
                   const SizedBox(height: 8),
                   Text(
                     'Yuk atur keuangan bulan ini biar nggak boncos.',
                     style: TextStyle(fontFamily: 'Outfit',
                       fontSize: 16,
                       color: Colors.white.withOpacity(0.9), // High visibility
                     ),
                     textAlign: TextAlign.center,
                   ),
                   const SizedBox(height: 48),
                   
                    TextFormField(
                      controller: _salaryController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyInputFormatter()],
                      style: TextStyle(fontFamily: 'Outfit',fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Total Gaji Bulan Ini',
                        labelStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white70),
                        prefixText: 'Rp ',
                        prefixStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontWeight: FontWeight.bold),
                        hintText: '0',
                        hintStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Gaji wajib diisi ya';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _savingsController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyInputFormatter()],
                      style: TextStyle(fontFamily: 'Outfit',fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Tabungan Awal (Opsional)',
                        labelStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white70),
                        prefixText: 'Rp ',
                        prefixStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white, fontWeight: FontWeight.bold),
                        hintText: '0',
                        hintStyle: TextStyle(fontFamily: 'Outfit',color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                   const SizedBox(height: 48),
                   
                   SizedBox(
                     height: 56,
                     child: ElevatedButton(
                        onPressed: state.isLoading ? null : () {
                          if (_formKey.currentState!.validate()) {
                            // Sanitize input: remove dots (thousands separator)
                            final salaryStr = _salaryController.text.replaceAll('.', '');
                            final savingsStr = _savingsController.text.replaceAll('.', '');

                            final salary = double.tryParse(salaryStr) ?? 0;
                            final savings = double.tryParse(savingsStr) ?? 0;
                            
                            ref.read(setupControllerProvider.notifier).submitConfig(
                              salary: salary,
                              savings: savings,
                            );
                          }
                        },
                       child: state.isLoading 
                         ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                         : const Text('Mulai Atur Keuangan'),
                     ),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
