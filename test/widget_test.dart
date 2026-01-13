import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ecash/main.dart';
import 'package:ecash/data/local/database.dart';
import 'package:ecash/presentation/providers/database_provider.dart';

void main() {
  testWidgets('Setup Screen smoke test', (WidgetTester tester) async {
    // Create an in-memory database
    final db = AppDatabase(NativeDatabase.memory());

    // Build our app and trigger a frame, overriding the database provider
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
        child: const ECashApp(),
      ),
    );

    // Verify that the Setup Screen text appears.
    expect(find.text('Halo, Bos!'), findsOneWidget);
    expect(find.text('Total Gaji Bulan Ini'), findsOneWidget);
    
    // Clean up
    await db.close();
  });
}
