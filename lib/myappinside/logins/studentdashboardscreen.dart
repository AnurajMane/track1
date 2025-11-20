/*import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart'; // For QR code scanning

class studentdashboardscreen extends StatefulWidget {
  const studentdashboardscreen({Key? key}) : super(key: key);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<studentdashboardscreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isScanning = false; // To control QR code scanner visibility
  String? _boardingTime; // Time when the student boards the bus
  String? _droppingTime; // Time when the student drops off the bus
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR'); // Key for QR scanner
  QRViewController? _qrController; // Controller for QR scanner

  // Open QR code scanner
  void _openQRScanner() {
    setState(() {
      _isScanning = true;
    });
  }

  // Handle QR code scan result
  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      // Stop scanning after a successful scan
      _qrController?.dispose();
      setState(() {
        _isScanning = false;
      });

      // Extract bus ID from the QR code
      final busId = scanData.code;

      // Check if it's the first scan (boarding) or second scan (dropping)
      if (_boardingTime == null) {
        // First scan: Record boarding time
        setState(() {
          _boardingTime = DateTime.now().toIso8601String();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Boarding recorded!')),
        );
      } else if (_droppingTime == null) {
        // Second scan: Record dropping time and save attendance
        setState(() {
          _droppingTime = DateTime.now().toIso8601String();
        });

        // Save attendance to the database
        await _saveAttendance(busId!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dropping recorded! Attendance saved.')),
        );
      }
    });
  }

  // Save attendance to the database
  Future<void> _saveAttendance(String busId) async {
    if (_boardingTime != null && _droppingTime != null) {
      await _supabase.from('attendance').upsert({
        'student_id': _supabase.auth.currentUser?.id, // Student's ID
        'bus_id': busId, // Bus ID from the QR code
        'boarding_time': _boardingTime,
        'dropping_time': _droppingTime,
        'date': DateTime.now().toIso8601String().split('T')[0], // Date in YYYY-MM-DD format
      });

      // Reset boarding and dropping times
      setState(() {
        _boardingTime = null;
        _droppingTime = null;
      });
    }
  }

  @override
  void dispose() {
    _qrController?.dispose(); // Dispose of the QR controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
      ),
      body: _isScanning
          ? QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR Code Scanner Button
            Center(
              child: ElevatedButton(
                onPressed: _openQRScanner,
                child: const Text('Scan QR Code'),
              ),
            ),
            const SizedBox(height: 20),

            // Attendance Status
            Text(
              'Attendance Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            if (_boardingTime != null)
              ListTile(
                title: const Text('Boarding Time'),
                subtitle: Text(_boardingTime!),
                leading: const Icon(Icons.directions_bus),
              ),
            if (_droppingTime != null)
              ListTile(
                title: const Text('Dropping Time'),
                subtitle: Text(_droppingTime!),
                leading: const Icon(Icons.directions_bus),
              ),
            if (_boardingTime == null && _droppingTime == null)
              const Text('No attendance recorded today.'),
          ],
        ),
      ),
    );
  }
}*/