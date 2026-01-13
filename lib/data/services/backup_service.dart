import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;

class BackupService {
  Future<String> get _dbPath async {
    final dbFolder = await getApplicationDocumentsDirectory();
    return p.join(dbFolder.path, 'ecash_v1.sqlite');
  }

  Future<void> exportDatabase() async {
    final path = await _dbPath;
    final file = File(path);

    if (await file.exists()) {
      final now = DateTime.now();
      // Format: ecash_backup_YYYYMMDD_HHMM.sqlite
      // We don't have intl accessible here easily without passing it, so manual format or basic string
      final timestamp = "${now.year}${now.month.toString().padLeft(2,'0')}${now.day.toString().padLeft(2,'0')}_${now.hour}${now.minute}";
      final backupName = "ecash_backup_$timestamp.sqlite";
      
      // Share expects XFile
      await Share.shareXFiles(
        [XFile(path, name: backupName)],
        text: 'ECash Backup Data ($timestamp)',
      );
    } else {
      throw Exception("Database file not found!");
    }
  }

  Future<bool> importDatabase() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Android often has issues with custom extensions
      );

      if (result != null && result.files.single.path != null) {
        final selectedPath = result.files.single.path!;
        final dbPath = await _dbPath;
        
        // Basic validation: Check if file ends with .sqlite or looks like a DB
        // (Optional but good practice)
        
        // Overwrite existing DB
        final selectedFile = File(selectedPath);
        await selectedFile.copy(dbPath);
        
        return true; // Success
      }
      return false; // Canceled
    } catch (e) {
      throw Exception("Failed to import database: $e");
    }
  }
}
