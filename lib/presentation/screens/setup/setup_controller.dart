import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../providers/database_provider.dart';

part 'setup_controller.g.dart';

@riverpod
class SetupController extends _$SetupController {
  @override
  FutureOr<void> build() {
    // no-op state
  }

  Future<void> submitConfig({required double salary, required double savings}) async {
    state = const AsyncLoading();
    try {
      final db = ref.read(databaseProvider);
      final now = DateTime.now();
      // Normalize to first day of month
      final currentMonth = DateTime(now.year, now.month, 1);
      
      await db.setMonthlySalary(currentMonth, salary, savings);
      
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
