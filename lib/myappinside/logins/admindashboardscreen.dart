/*import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class admindashboardscreen extends StatefulWidget {
  const admindashboardscreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<admindashboardscreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _busNumberController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();

  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _buses = [];
  bool _isLoading = false;

  // Map variables
  Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(12.9716, 77.5946); // Example: Bangalore coordinates

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _fetchBuses();
  }

  // Fetch users from Supabase
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _supabase.from('users').select('*');
      setState(() {
        _users = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching users: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Fetch buses from Supabase
  Future<void> _fetchBuses() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _supabase.from('buses').select('*');
      setState(() {
        _buses = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching buses: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Add a new user
  Future<void> _addUser() async {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _supabase.from('users').insert({
        'email': email,
        'name': name,
        'role': 'Student', // Default role
      });
      _fetchUsers(); // Refresh the list
      _emailController.clear();
      _nameController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Add a new bus
  Future<void> _addBus() async {
    final busNumber = _busNumberController.text.trim();
    final route = _routeController.text.trim();

    if (busNumber.isEmpty || route.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _supabase.from('buses').insert({
        'bus_number': busNumber,
        'route': route,
      });
      _fetchBuses(); // Refresh the list
      _busNumberController.clear();
      _routeController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Delete a user
  Future<void> _deleteUser(String userId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _supabase.from('users').delete().eq('id', userId);
      _fetchUsers(); // Refresh the list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Delete a bus
  Future<void> _deleteBus(String busId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _supabase.from('buses').delete().eq('id', busId);
      _fetchBuses(); // Refresh the list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _fetchUsers();
              _fetchBuses();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real-Time Bus Tracking Map
            const Text(
              'Real-Time Bus Tracking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: GoogleMap(
                onMapCreated: (controller) => _mapController = controller,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 12,
                ),
                markers: _markers,
              ),
            ),
            const SizedBox(height: 20),

            // User Management Section
            const Text(
              'User Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addUser,
              child: const Text('Add User'),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  title: Text(user['name'] ?? 'No name'),
                  subtitle: Text(user['email'] ?? 'No email'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteUser(user['id']),
                  ),
                );
              },
            ),

            // Bus Management Section
            const SizedBox(height: 20),
            const Text(
              'Bus Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _busNumberController,
              decoration: const InputDecoration(
                labelText: 'Bus Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _routeController,
              decoration: const InputDecoration(
                labelText: 'Route',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addBus,
              child: const Text('Add Bus'),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _buses.length,
              itemBuilder: (context, index) {
                final bus = _buses[index];
                return ListTile(
                  title: Text('Bus ${bus['bus_number'] ?? 'No bus number'}'),
                  subtitle: Text(bus['route'] ?? 'No route'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteBus(bus['id']),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}*/