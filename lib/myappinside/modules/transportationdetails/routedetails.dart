import 'package:flutter/material.dart';

class routedetails extends StatelessWidget {
  final RouteInfo routeInfo;

  const routedetails({super.key, required this.routeInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDriverSection(context),
            const Divider(height: 40),
            _buildAddressSection('Start', routeInfo.startAddress),
            const Divider(height: 40),
            _buildAddressSection('End', routeInfo.endAddress),
            const Divider(height: 40),
            _buildActionSection(context),
            const SizedBox(height: 24),
            _buildAttendanceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(context, 'Driver Name', routeInfo.driverName),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Call', routeInfo.contactNumber),
        const SizedBox(height: 12),
        _buildDetailRow(context, 'Route', 'Sindhu Bhavan Road'),
      ],
    );
  }

  Widget _buildAddressSection(String title, List<String> addressLines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.tealAccent,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: addressLines
              .map((line) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              line.trim(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[300],
              ),
            ),
          ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.amberAccent[400],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          icon: Icons.location_pin,
          label: 'Start Location Sharing',
          onTap: () => _handleLocationSharing(),
        ),
        const SizedBox(height: 16),
        _buildDetailRow(context, 'Total Students', '${routeInfo.totalStudents}'),
        const SizedBox(height: 16),
        _buildActionButton(
          icon: Icons.message,
          label: 'Send Instant Message',
          onTap: () => _handleInstantMessage(),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.tealAccent.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.tealAccent[400]),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Bus Attendance",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.tealAccent[400],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Attendance Chart Placeholder',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  void _handleLocationSharing() {
    // Implement location sharing logic
  }

  void _handleInstantMessage() {
    // Implement instant messaging logic
  }
}

// Updated RouteInfo model
class RouteInfo {
  final String vehicleNumber;
  final String routeName;
  final List<String> address;
  final String driverName;
  final String contactNumber;
  final List<String> startAddress;
  final List<String> endAddress;
  final int totalStudents;

  RouteInfo({
    required this.vehicleNumber,
    required this.routeName,
    required this.address,
    required this.driverName,
    required this.contactNumber,
    required this.startAddress,
    required this.endAddress,
    required this.totalStudents,
  });
}