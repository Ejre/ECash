// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MonthlySummariesTable extends MonthlySummaries
    with TableInfo<$MonthlySummariesTable, MonthlySummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlySummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<DateTime> month = GeneratedColumn<DateTime>(
      'month', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _totalSalaryMeta =
      const VerificationMeta('totalSalary');
  @override
  late final GeneratedColumn<double> totalSalary = GeneratedColumn<double>(
      'total_salary', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _initialSavingsMeta =
      const VerificationMeta('initialSavings');
  @override
  late final GeneratedColumn<double> initialSavings = GeneratedColumn<double>(
      'initial_savings', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalIncomeMeta =
      const VerificationMeta('totalIncome');
  @override
  late final GeneratedColumn<double> totalIncome = GeneratedColumn<double>(
      'total_income', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalExpensesMeta =
      const VerificationMeta('totalExpenses');
  @override
  late final GeneratedColumn<double> totalExpenses = GeneratedColumn<double>(
      'total_expenses', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, month, totalSalary, initialSavings, totalIncome, totalExpenses];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_summaries';
  @override
  VerificationContext validateIntegrity(Insertable<MonthlySummary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('total_salary')) {
      context.handle(
          _totalSalaryMeta,
          totalSalary.isAcceptableOrUnknown(
              data['total_salary']!, _totalSalaryMeta));
    }
    if (data.containsKey('initial_savings')) {
      context.handle(
          _initialSavingsMeta,
          initialSavings.isAcceptableOrUnknown(
              data['initial_savings']!, _initialSavingsMeta));
    }
    if (data.containsKey('total_income')) {
      context.handle(
          _totalIncomeMeta,
          totalIncome.isAcceptableOrUnknown(
              data['total_income']!, _totalIncomeMeta));
    }
    if (data.containsKey('total_expenses')) {
      context.handle(
          _totalExpensesMeta,
          totalExpenses.isAcceptableOrUnknown(
              data['total_expenses']!, _totalExpensesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlySummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlySummary(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}month'])!,
      totalSalary: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_salary'])!,
      initialSavings: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}initial_savings'])!,
      totalIncome: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_income'])!,
      totalExpenses: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_expenses'])!,
    );
  }

  @override
  $MonthlySummariesTable createAlias(String alias) {
    return $MonthlySummariesTable(attachedDatabase, alias);
  }
}

class MonthlySummary extends DataClass implements Insertable<MonthlySummary> {
  final int id;
  final DateTime month;
  final double totalSalary;
  final double initialSavings;
  final double totalIncome;
  final double totalExpenses;
  const MonthlySummary(
      {required this.id,
      required this.month,
      required this.totalSalary,
      required this.initialSavings,
      required this.totalIncome,
      required this.totalExpenses});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['month'] = Variable<DateTime>(month);
    map['total_salary'] = Variable<double>(totalSalary);
    map['initial_savings'] = Variable<double>(initialSavings);
    map['total_income'] = Variable<double>(totalIncome);
    map['total_expenses'] = Variable<double>(totalExpenses);
    return map;
  }

  MonthlySummariesCompanion toCompanion(bool nullToAbsent) {
    return MonthlySummariesCompanion(
      id: Value(id),
      month: Value(month),
      totalSalary: Value(totalSalary),
      initialSavings: Value(initialSavings),
      totalIncome: Value(totalIncome),
      totalExpenses: Value(totalExpenses),
    );
  }

  factory MonthlySummary.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlySummary(
      id: serializer.fromJson<int>(json['id']),
      month: serializer.fromJson<DateTime>(json['month']),
      totalSalary: serializer.fromJson<double>(json['totalSalary']),
      initialSavings: serializer.fromJson<double>(json['initialSavings']),
      totalIncome: serializer.fromJson<double>(json['totalIncome']),
      totalExpenses: serializer.fromJson<double>(json['totalExpenses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'month': serializer.toJson<DateTime>(month),
      'totalSalary': serializer.toJson<double>(totalSalary),
      'initialSavings': serializer.toJson<double>(initialSavings),
      'totalIncome': serializer.toJson<double>(totalIncome),
      'totalExpenses': serializer.toJson<double>(totalExpenses),
    };
  }

  MonthlySummary copyWith(
          {int? id,
          DateTime? month,
          double? totalSalary,
          double? initialSavings,
          double? totalIncome,
          double? totalExpenses}) =>
      MonthlySummary(
        id: id ?? this.id,
        month: month ?? this.month,
        totalSalary: totalSalary ?? this.totalSalary,
        initialSavings: initialSavings ?? this.initialSavings,
        totalIncome: totalIncome ?? this.totalIncome,
        totalExpenses: totalExpenses ?? this.totalExpenses,
      );
  MonthlySummary copyWithCompanion(MonthlySummariesCompanion data) {
    return MonthlySummary(
      id: data.id.present ? data.id.value : this.id,
      month: data.month.present ? data.month.value : this.month,
      totalSalary:
          data.totalSalary.present ? data.totalSalary.value : this.totalSalary,
      initialSavings: data.initialSavings.present
          ? data.initialSavings.value
          : this.initialSavings,
      totalIncome:
          data.totalIncome.present ? data.totalIncome.value : this.totalIncome,
      totalExpenses: data.totalExpenses.present
          ? data.totalExpenses.value
          : this.totalExpenses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlySummary(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('totalSalary: $totalSalary, ')
          ..write('initialSavings: $initialSavings, ')
          ..write('totalIncome: $totalIncome, ')
          ..write('totalExpenses: $totalExpenses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, month, totalSalary, initialSavings, totalIncome, totalExpenses);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlySummary &&
          other.id == this.id &&
          other.month == this.month &&
          other.totalSalary == this.totalSalary &&
          other.initialSavings == this.initialSavings &&
          other.totalIncome == this.totalIncome &&
          other.totalExpenses == this.totalExpenses);
}

class MonthlySummariesCompanion extends UpdateCompanion<MonthlySummary> {
  final Value<int> id;
  final Value<DateTime> month;
  final Value<double> totalSalary;
  final Value<double> initialSavings;
  final Value<double> totalIncome;
  final Value<double> totalExpenses;
  const MonthlySummariesCompanion({
    this.id = const Value.absent(),
    this.month = const Value.absent(),
    this.totalSalary = const Value.absent(),
    this.initialSavings = const Value.absent(),
    this.totalIncome = const Value.absent(),
    this.totalExpenses = const Value.absent(),
  });
  MonthlySummariesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime month,
    this.totalSalary = const Value.absent(),
    this.initialSavings = const Value.absent(),
    this.totalIncome = const Value.absent(),
    this.totalExpenses = const Value.absent(),
  }) : month = Value(month);
  static Insertable<MonthlySummary> custom({
    Expression<int>? id,
    Expression<DateTime>? month,
    Expression<double>? totalSalary,
    Expression<double>? initialSavings,
    Expression<double>? totalIncome,
    Expression<double>? totalExpenses,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (month != null) 'month': month,
      if (totalSalary != null) 'total_salary': totalSalary,
      if (initialSavings != null) 'initial_savings': initialSavings,
      if (totalIncome != null) 'total_income': totalIncome,
      if (totalExpenses != null) 'total_expenses': totalExpenses,
    });
  }

  MonthlySummariesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? month,
      Value<double>? totalSalary,
      Value<double>? initialSavings,
      Value<double>? totalIncome,
      Value<double>? totalExpenses}) {
    return MonthlySummariesCompanion(
      id: id ?? this.id,
      month: month ?? this.month,
      totalSalary: totalSalary ?? this.totalSalary,
      initialSavings: initialSavings ?? this.initialSavings,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpenses: totalExpenses ?? this.totalExpenses,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (month.present) {
      map['month'] = Variable<DateTime>(month.value);
    }
    if (totalSalary.present) {
      map['total_salary'] = Variable<double>(totalSalary.value);
    }
    if (initialSavings.present) {
      map['initial_savings'] = Variable<double>(initialSavings.value);
    }
    if (totalIncome.present) {
      map['total_income'] = Variable<double>(totalIncome.value);
    }
    if (totalExpenses.present) {
      map['total_expenses'] = Variable<double>(totalExpenses.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlySummariesCompanion(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('totalSalary: $totalSalary, ')
          ..write('initialSavings: $initialSavings, ')
          ..write('totalIncome: $totalIncome, ')
          ..write('totalExpenses: $totalExpenses')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isExpenseMeta =
      const VerificationMeta('isExpense');
  @override
  late final GeneratedColumn<bool> isExpense = GeneratedColumn<bool>(
      'is_expense', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_expense" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, category, note, date, isExpense];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_expense')) {
      context.handle(_isExpenseMeta,
          isExpense.isAcceptableOrUnknown(data['is_expense']!, _isExpenseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isExpense: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_expense'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionEntry extends DataClass
    implements Insertable<TransactionEntry> {
  final int id;
  final double amount;
  final String category;
  final String? note;
  final DateTime date;
  final bool isExpense;
  const TransactionEntry(
      {required this.id,
      required this.amount,
      required this.category,
      this.note,
      required this.date,
      required this.isExpense});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['date'] = Variable<DateTime>(date);
    map['is_expense'] = Variable<bool>(isExpense);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      amount: Value(amount),
      category: Value(category),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      date: Value(date),
      isExpense: Value(isExpense),
    );
  }

  factory TransactionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionEntry(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      note: serializer.fromJson<String?>(json['note']),
      date: serializer.fromJson<DateTime>(json['date']),
      isExpense: serializer.fromJson<bool>(json['isExpense']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'note': serializer.toJson<String?>(note),
      'date': serializer.toJson<DateTime>(date),
      'isExpense': serializer.toJson<bool>(isExpense),
    };
  }

  TransactionEntry copyWith(
          {int? id,
          double? amount,
          String? category,
          Value<String?> note = const Value.absent(),
          DateTime? date,
          bool? isExpense}) =>
      TransactionEntry(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        note: note.present ? note.value : this.note,
        date: date ?? this.date,
        isExpense: isExpense ?? this.isExpense,
      );
  TransactionEntry copyWithCompanion(TransactionsCompanion data) {
    return TransactionEntry(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      note: data.note.present ? data.note.value : this.note,
      date: data.date.present ? data.date.value : this.date,
      isExpense: data.isExpense.present ? data.isExpense.value : this.isExpense,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionEntry(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('date: $date, ')
          ..write('isExpense: $isExpense')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, category, note, date, isExpense);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionEntry &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.note == this.note &&
          other.date == this.date &&
          other.isExpense == this.isExpense);
}

class TransactionsCompanion extends UpdateCompanion<TransactionEntry> {
  final Value<int> id;
  final Value<double> amount;
  final Value<String> category;
  final Value<String?> note;
  final Value<DateTime> date;
  final Value<bool> isExpense;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.note = const Value.absent(),
    this.date = const Value.absent(),
    this.isExpense = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    required String category,
    this.note = const Value.absent(),
    required DateTime date,
    this.isExpense = const Value.absent(),
  })  : amount = Value(amount),
        category = Value(category),
        date = Value(date);
  static Insertable<TransactionEntry> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? note,
    Expression<DateTime>? date,
    Expression<bool>? isExpense,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (note != null) 'note': note,
      if (date != null) 'date': date,
      if (isExpense != null) 'is_expense': isExpense,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<double>? amount,
      Value<String>? category,
      Value<String?>? note,
      Value<DateTime>? date,
      Value<bool>? isExpense}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      note: note ?? this.note,
      date: date ?? this.date,
      isExpense: isExpense ?? this.isExpense,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isExpense.present) {
      map['is_expense'] = Variable<bool>(isExpense.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('date: $date, ')
          ..write('isExpense: $isExpense')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MonthlySummariesTable monthlySummaries =
      $MonthlySummariesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [monthlySummaries, transactions];
}

typedef $$MonthlySummariesTableCreateCompanionBuilder
    = MonthlySummariesCompanion Function({
  Value<int> id,
  required DateTime month,
  Value<double> totalSalary,
  Value<double> initialSavings,
  Value<double> totalIncome,
  Value<double> totalExpenses,
});
typedef $$MonthlySummariesTableUpdateCompanionBuilder
    = MonthlySummariesCompanion Function({
  Value<int> id,
  Value<DateTime> month,
  Value<double> totalSalary,
  Value<double> initialSavings,
  Value<double> totalIncome,
  Value<double> totalExpenses,
});

class $$MonthlySummariesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonthlySummariesTable,
    MonthlySummary,
    $$MonthlySummariesTableFilterComposer,
    $$MonthlySummariesTableOrderingComposer,
    $$MonthlySummariesTableCreateCompanionBuilder,
    $$MonthlySummariesTableUpdateCompanionBuilder> {
  $$MonthlySummariesTableTableManager(
      _$AppDatabase db, $MonthlySummariesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MonthlySummariesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MonthlySummariesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> month = const Value.absent(),
            Value<double> totalSalary = const Value.absent(),
            Value<double> initialSavings = const Value.absent(),
            Value<double> totalIncome = const Value.absent(),
            Value<double> totalExpenses = const Value.absent(),
          }) =>
              MonthlySummariesCompanion(
            id: id,
            month: month,
            totalSalary: totalSalary,
            initialSavings: initialSavings,
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime month,
            Value<double> totalSalary = const Value.absent(),
            Value<double> initialSavings = const Value.absent(),
            Value<double> totalIncome = const Value.absent(),
            Value<double> totalExpenses = const Value.absent(),
          }) =>
              MonthlySummariesCompanion.insert(
            id: id,
            month: month,
            totalSalary: totalSalary,
            initialSavings: initialSavings,
            totalIncome: totalIncome,
            totalExpenses: totalExpenses,
          ),
        ));
}

class $$MonthlySummariesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MonthlySummariesTable> {
  $$MonthlySummariesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get month => $state.composableBuilder(
      column: $state.table.month,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalSalary => $state.composableBuilder(
      column: $state.table.totalSalary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get initialSavings => $state.composableBuilder(
      column: $state.table.initialSavings,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalIncome => $state.composableBuilder(
      column: $state.table.totalIncome,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get totalExpenses => $state.composableBuilder(
      column: $state.table.totalExpenses,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MonthlySummariesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MonthlySummariesTable> {
  $$MonthlySummariesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get month => $state.composableBuilder(
      column: $state.table.month,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalSalary => $state.composableBuilder(
      column: $state.table.totalSalary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get initialSavings => $state.composableBuilder(
      column: $state.table.initialSavings,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalIncome => $state.composableBuilder(
      column: $state.table.totalIncome,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get totalExpenses => $state.composableBuilder(
      column: $state.table.totalExpenses,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  required double amount,
  required String category,
  Value<String?> note,
  required DateTime date,
  Value<bool> isExpense,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<double> amount,
  Value<String> category,
  Value<String?> note,
  Value<DateTime> date,
  Value<bool> isExpense,
});

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    TransactionEntry,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TransactionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TransactionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isExpense = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            amount: amount,
            category: category,
            note: note,
            date: date,
            isExpense: isExpense,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double amount,
            required String category,
            Value<String?> note = const Value.absent(),
            required DateTime date,
            Value<bool> isExpense = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            amount: amount,
            category: category,
            note: note,
            date: date,
            isExpense: isExpense,
          ),
        ));
}

class $$TransactionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isExpense => $state.composableBuilder(
      column: $state.table.isExpense,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TransactionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isExpense => $state.composableBuilder(
      column: $state.table.isExpense,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MonthlySummariesTableTableManager get monthlySummaries =>
      $$MonthlySummariesTableTableManager(_db, _db.monthlySummaries);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
