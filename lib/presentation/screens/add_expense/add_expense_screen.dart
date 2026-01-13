import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/currency_input_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'add_expense_controller.dart';
import '../../../data/local/database.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  final TransactionEntry? transactionToEdit;

  const AddExpenseScreen({super.key, this.transactionToEdit});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  late String _selectedCategory;
  late DateTime _selectedDate;
  bool _isExpense = true;
  
  final List<String> _expenseCategories = ['Makan', 'Transport', 'Belanja', 'Hiburan', 'Tagihan', 'Lainnya'];
  final List<String> _incomeCategories = ['Gaji', 'Bonus', 'Tunjangan', 'Hadiah', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    final tx = widget.transactionToEdit;
    _amountController = TextEditingController(text: tx != null ? tx.amount.toInt().toString() : '');
    _noteController = TextEditingController(text: tx?.note ?? '');
    _isExpense = tx?.isExpense ?? true;
    _selectedCategory = tx?.category ?? (_isExpense ? 'Makan' : 'Gaji');
    _selectedDate = tx?.date ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addExpenseControllerProvider);
    final currentCategories = _isExpense ? _expenseCategories : _incomeCategories;

    ref.listen<AsyncValue<void>>(addExpenseControllerProvider, (prev, next) {
      if (next is AsyncData && (prev?.isLoading ?? false)) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isExpense ? "Pengeluaran disimpan!" : "Pemasukan disimpan!")));
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${next.error}")));
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isExpense ? "Catat Pengeluaran" : "Catat Pemasukan"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // TOGGLE TYPE
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() { 
                        _isExpense = true;
                        if (!_expenseCategories.contains(_selectedCategory)) _selectedCategory = _expenseCategories.first;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isExpense ? Colors.redAccent : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text("Pengeluaran", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                         _isExpense = false;
                         if (!_incomeCategories.contains(_selectedCategory)) _selectedCategory = _incomeCategories.first;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !_isExpense ? Colors.green : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text("Pemasukan", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text("Nominal (Rp)", style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70)), // Brighter
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyInputFormatter()],
              style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: _isExpense ? Colors.redAccent : Colors.greenAccent), 
              decoration: InputDecoration(
                hintText: "0",
                hintStyle: GoogleFonts.outfit(color: Colors.grey[600]), // Hint distinct but visible
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixText: _isExpense ? "- " : "+ ",
                prefixStyle: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: _isExpense ? Colors.redAccent : Colors.greenAccent),
              ),
              cursorColor: Theme.of(context).colorScheme.primary, 
              autofocus: true,
            ),
            const Divider(color: Colors.white24), // Visible divider
            const SizedBox(height: 24),
 
            Text("Kategori", style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: currentCategories.map((category) {
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedCategory = category);
                  },
                  selectedColor: _isExpense ? Theme.of(context).colorScheme.primary : Colors.green,
                  backgroundColor: Colors.transparent, // Transparent background for unselected
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? Colors.transparent : Colors.grey[400]!, // Much Brighter border
                      width: 1.5,
                    ),
                  ),
                  labelStyle: GoogleFonts.outfit(
                    color: isSelected ? Colors.white : Colors.white70, // White / White70 for unselected (very bright)
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            Text("Catatan (Opsional)", style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              style: GoogleFonts.outfit(color: Colors.white), // Input white
              decoration: InputDecoration(
                hintText: "Contoh: Nasi Padang",
                hintStyle: GoogleFonts.outfit(color: Colors.grey[500]),
                filled: true,
                fillColor: Theme.of(context).cardTheme.color, // Card color background for input
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),

            Text("Tanggal", style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Theme.of(context).colorScheme.primary,
                          onPrimary: Colors.white,
                          onSurface: Colors.black, // Calendar text black on dialog
                          surface: Colors.white, // Calendar bg white
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  }
                );
                if (picked != null) setState(() => _selectedDate = picked);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24), // Brighter border
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20, color: Colors.white70),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy').format(_selectedDate),
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isLoading ? null : () {
                   if (_amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Isi nominal dulu ya bos!")));
                      return;
                   }
                   
                   final amount = double.tryParse(_amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                   if (amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nominal gak boleh nol.")));
                      return;
                   }

                   if (widget.transactionToEdit != null) {
                     ref.read(addExpenseControllerProvider.notifier).editExpense(
                       id: widget.transactionToEdit!.id,
                       oldAmount: widget.transactionToEdit!.amount,
                       newAmount: double.tryParse(_amountController.text.replaceAll('.', '')) ?? 0,
                       category: _selectedCategory,
                       note: _noteController.text,
                       date: _selectedDate,
                       isExpense: _isExpense,
                     );
                   } else {
                     ref.read(addExpenseControllerProvider.notifier).saveExpense(
                       amount: double.tryParse(_amountController.text.replaceAll('.', '')) ?? 0,
                       category: _selectedCategory,
                       note: _noteController.text,
                       date: _selectedDate,
                       isExpense: _isExpense,
                     );
                   }
                },
                child: state.isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(widget.transactionToEdit != null ? "Update Transaksi" : "Simpan"),
              ),
            )

          ],
        ),
      ),
    ),
    );
  }
}
