import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const ErrorScreen({super.key, required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded, size: 80, color: Colors.red[400]),
              const SizedBox(height: 24),
              Text(
                "Oops! Ada Kesalahan",
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Tenang, data kamu aman kok. Terjadi sedikit gangguan teknis. Coba refresh lagi ya.",
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Only show error details in debug mode essentially (or if we want to show it)
              // For release, we keep it clean. But maybe a small text for debugging.
              Text(
                error.toString().substring(0, error.toString().length > 100 ? 100 : error.toString().length), 
                style: TextStyle(fontFamily: 'RobotoMono', fontSize: 10, color: Colors.grey[300]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006D5B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Refresh Aplikasi", style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
