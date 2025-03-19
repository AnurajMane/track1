import 'package:flutter/material.dart';
import 'package:track1/myappinside/modules/transportationdetails/routes.dart';

class transportbutton extends StatelessWidget {
  const transportbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section with gradient background
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF179bd6), Color(0xFF91e5f6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle tap for Vehicles stat card
                            print('Vehicles stat card tapped');
                          },
                          child: _buildStatCard(
                            icon: Icons.directions_bus,
                            count: '0',
                            label: 'Vehicles',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle tap for Routes stat card
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const routes(),
                              ),
                            );
                          },
                          child: _buildStatCard(
                            icon: Icons.route,
                            count: '0',
                            label: 'Routes',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle tap for Drivers stat card
                            print('Drivers stat card tapped');
                          },
                          child: _buildStatCard(
                            icon: Icons.person,
                            count: '0',
                            label: 'Drivers',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle tap for Way Points stat card
                            print('Way Points stat card tapped');
                          },
                          child: _buildStatCard(
                            icon: Icons.location_on,
                            count: '0',
                            label: 'Way Points',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Spacing before the list tiles
            const SizedBox(height: 20),

            // List-like items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuCard(
                    context: context,
                    icon: Icons.email,
                    iconBgColor: Colors.purple,
                    title: 'Send Bulk SMS',
                    onTap: () {
                      // Navigate to Send Bulk SMS screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SendBulkSmsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context: context,
                    icon: Icons.directions_bus,
                    iconBgColor: Colors.teal,
                    title: 'Transportation Details',
                    onTap: () {
                      // Navigate to Transportation Details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const routes(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context: context,
                    icon: Icons.person,
                    iconBgColor: Colors.blue,
                    title: 'Driver Details',
                    onTap: () {
                      // Navigate to Driver Details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DriverDetailsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds each stat card in the top grid
  Widget _buildStatCard({
    required IconData icon,
    required String count,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds each menu item card below the stats
  Widget _buildMenuCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBgColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

/// Dummy screens for navigation
class SendBulkSmsScreen extends StatelessWidget {
  const SendBulkSmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Bulk SMS'),
      ),
      body: const Center(
        child: Text('Send Bulk SMS Screen'),
      ),
    );
  }
}
/*
class TransportationDetailsScreen extends StatelessWidget {
  const TransportationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transportation Details'),
      ),
      body: const Center(
        child: Text('Transportation Details Screen'),
      ),
    );
  }
}
*/
class DriverDetailsScreen extends StatelessWidget {
  const DriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Details'),
      ),
      body: const Center(
        child: Text('Driver Details Screen'),
      ),
    );
  }
}