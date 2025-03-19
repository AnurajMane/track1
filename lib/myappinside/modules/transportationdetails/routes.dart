import 'package:flutter/material.dart';



class routes extends StatelessWidget {
  const routes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Routes'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh functionality can be added here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Refreshing data...')),
              );
            },
          ),
        ],
      ),
      body: const VehicleList(),
    );
  }
}

class VehicleList extends StatelessWidget {
  const VehicleList({super.key});

  // Simulate fetching data from a server
  Future<List<RouteInfo>> fetchRoutes() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Mock JSON data
    final mockData = [
      {
        'vehicleNumber': 'Bus 111',
        'routeName': 'Route1',
        'address': [
          '1st St',
          '2nd St',
        ],
      },
      {
        'vehicleNumber': 'Bus 222',
        'routeName': 'Route2',
        'address': [
          '1st St',
          '2nd St',
        ],
      },
      {
        'vehicleNumber': 'Bus 333',
        'routeName': 'Route3',
        'address': [
          '1st St',
          '2nd St',
        ],
      },
      {
        'vehicleNumber': 'Bus 444',
        'routeName': 'Route4',
        'address': [
          '1st St',
          '2nd St',
        ],
      },
    ];

    // Parse JSON data into a list of RouteInfo objects
    return mockData.map((json) => RouteInfo.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RouteInfo>>(
      future: fetchRoutes(), // Fetch data from the server
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while fetching data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show an error message if something went wrong
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Show a message if no data is available
          return const Center(child: Text('No routes available'));
        } else {
          // Display the list of routes
          final routes = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              return RouteCard(routeInfo: routes[index]);
            },
          );
        }
      },
    );
  }
}

class RouteCard extends StatelessWidget {
  final RouteInfo routeInfo;

  const RouteCard({super.key, required this.routeInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleCardTap(context), // Add navigation logic here
      borderRadius: BorderRadius.circular(10), // Match the card's border radius
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              _buildAddress(context),
              const SizedBox(height: 16),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  // Navigation logic for card tap
  void _handleCardTap(BuildContext context) {
    // Navigate to the details screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RouteDetailsScreen(routeInfo: routeInfo),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routeInfo.vehicleNumber,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              routeInfo.routeName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Icon(Icons.directions_bus, color: Theme.of(context).colorScheme.secondary),
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: routeInfo.address
          .map((line) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          line.trim(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.gps_fixed,
            label: 'Live Tracking',
            onTap: () => _handleLiveTracking(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.play_circle_filled,
            label: 'Route Playback',
            onTap: () => _handleRoutePlayback(context),
          ),
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
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.tealAccent[400]),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLiveTracking(BuildContext context) {
    // Navigate to the live tracking screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LiveTrackingScreen()),
    );
  }

  void _handleRoutePlayback(BuildContext context) {
    // Navigate to the route playback screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RoutePlaybackScreen()),
    );
  }
}

class RouteInfo {
  final String vehicleNumber;
  final String routeName;
  final List<String> address;

  RouteInfo({
    required this.vehicleNumber,
    required this.routeName,
    required this.address,
  });

  // Factory constructor to parse JSON data
  factory RouteInfo.fromJson(Map<String, dynamic> json) {
    return RouteInfo(
      vehicleNumber: json['vehicleNumber'],
      routeName: json['routeName'],
      address: List<String>.from(json['address']),
    );
  }
}

class RouteDetailsScreen extends StatelessWidget {
  final RouteInfo routeInfo;

  const RouteDetailsScreen({super.key, required this.routeInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Details: ${routeInfo.routeName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Number: ${routeInfo.vehicleNumber}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Route Name: ${routeInfo.routeName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Address:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...routeInfo.address.map((line) => Text(line)).toList(),
          ],
        ),
      ),
    );
  }
}







class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Tracking'),
      ),
      body: const Center(
        child: Text('Live Tracking Screen'),
      ),
    );
  }
}

class RoutePlaybackScreen extends StatelessWidget {
  const RoutePlaybackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Playback'),
      ),
      body: const Center(
        child: Text('Route Playback Screen'),
      ),
    );
  }
}