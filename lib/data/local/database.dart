import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DataClassName('MonthlySummary')
class MonthlySummaries extends Table {
  IntColumn get id => integer().autoIncrement()();
  // We store the first day of the month (e.g., 2024-05-01 00:00:00)
  DateTimeColumn get month => dateTime().unique()(); 
  RealColumn get totalSalary => real().withDefault(const Constant(0.0))();
  RealColumn get initialSavings => real().withDefault(const Constant(0.0))();
  RealColumn get totalIncome => real().withDefault(const Constant(0.0))(); // Actual realized income
  RealColumn get totalExpenses => real().withDefault(const Constant(0.0))();
}

@DataClassName('TransactionEntry')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
  TextColumn get category => text()(); // 'Makan', 'Transport', etc.
  TextColumn get note => text().nullable()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isExpense => boolean().withDefault(const Constant(true))(); // True = Expense, False = Income
}

@DriftDatabase(tables: [MonthlySummaries, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // Bump version

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // We added totalIncome to MonthlySummaries and isExpense to Transactions
          await m.addColumn(monthlySummaries, monthlySummaries.totalIncome);
          await m.addColumn(transactions, transactions.isExpense);
        }
      },
    );
  }

  // Repositories will interact with these methods
  Future<int> insertMonthlySummary(MonthlySummariesCompanion entry) {
    return into(monthlySummaries).insert(entry);
  }
  
  Future<List<MonthlySummary>> getAllSummaries() => select(monthlySummaries).get();
  
  // Upsert logic for salary (if user re-enters or updates)
  Future<int> setMonthlySalary(DateTime month, double salary, double savings) async {
    // Check if exists
    final existing = await (select(monthlySummaries)..where((tbl) => tbl.month.equals(month))).getSingleOrNull();
    
    if (existing != null) {
      // Update
      await (update(monthlySummaries)..where((tbl) => tbl.id.equals(existing.id))).write(
        MonthlySummariesCompanion(
          totalSalary: Value(salary),
          initialSavings: Value(savings),
        ),
      );
      return existing.id;
    } else {
      // Insert
      return into(monthlySummaries).insert(
        MonthlySummariesCompanion(
          month: Value(month),
          totalSalary: Value(salary),
          initialSavings: Value(savings),
          totalExpenses: const Value(0),
          totalIncome: const Value(0),
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'ecash_v1.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
