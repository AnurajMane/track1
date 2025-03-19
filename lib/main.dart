import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'package:track1/navbar.dart';

import 'myappinside/modules/achievementsscreen.dart';
import 'myappinside/modules/classroomscreen.dart';
import 'myappinside/modules/examschedulerscreen.dart';
import 'myappinside/modules/expensesscreen.dart';
import 'myappinside/modules/galleryscreen.dart';
import 'myappinside/modules/homeworkscreen.dart';
import 'myappinside/modules/inquiryscreen.dart';
import 'myappinside/modules/libraryscreen.dart';
import 'myappinside/modules/mycanteenscreen.dart';
import 'myappinside/modules/onlinetestscreen.dart';
import 'myappinside/modules/resultsscreen.dart';
import 'myappinside/modules/storescreen.dart';
import 'myappinside/modules/timetablescreen.dart';
import 'myappinside/modules/voicecallscreen.dart';
import 'myappinside/transportbutton.dart';

import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'loginscreen.dart'; // Import your login screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://zlkdolkoolwgkmcyskyd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpsa2RvbGtvb2x3Z2ttY3lza3lkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIzMDcyODEsImV4cCI6MjA1Nzg4MzI4MX0.6aWq8zt9j06Re7DobVsvziVXjG4VXeY3e4Z3NATaPQo',
  );
  runApp(ChangeNotifierProvider(
    create: (_) => AppState(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My School',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          accentColor: Colors.deepOrange,
        ),
      ),
      home: const SplashScreen(), // Start with the splash screen
    );
  }
}

// Your existing HomePage and other code below...
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ModuleItem> modules = const [
    ModuleItem(
      title: 'Voice Call',
      icon: Icons.call,
      route: voicecallscreen(),
    ),
    ModuleItem(
      title: 'Classrooms',
      icon: Icons.class_,
      route: classroomscreen(),
    ),
    ModuleItem(
      title: 'Gallery',
      icon: Icons.photo,
      route: galleryscreen(),
    ),
    ModuleItem(
      title: 'MyCanteen',
      icon: Icons.restaurant,
      route: mycanteenscreen(),
    ),
    ModuleItem(
      title: 'Inquiry',
      icon: Icons.info,
      route: inquiryscreen(),
    ),
    ModuleItem(
      title: 'Homework',
      icon: Icons.book,
      route: homeworkscreen(),
    ),
    ModuleItem(
      title: 'TimeTable',
      icon: Icons.calendar_month,
      route: timetablescreen(),
    ),
    ModuleItem(
      title: 'Transport',
      icon: Icons.bus_alert,
      route: transportbutton(),
    ),
    ModuleItem(
      title: 'ExamScheduler',
      icon: Icons.schedule,
      route: examschedulerscreen(),
    ),
    ModuleItem(
      title: 'Library',
      icon: Icons.library_books,
      route: libraryscreen(),
    ),
    ModuleItem(
      title: 'Results',
      icon: Icons.receipt_long,
      route: resultsscreen(),
    ),
    ModuleItem(
      title: 'Achievements',
      icon: Icons.star_border,
      route: achievementsscreen(),
    ),
    ModuleItem(
      title: 'Expenses',
      icon: Icons.monetization_on,
      route: expensesscreen(),
    ),
    ModuleItem(
      title: 'Store',
      icon: Icons.store,
      route: storescreen(),
    ),
    ModuleItem(
      title: 'Online Test',
      icon: Icons.computer,
      route: onlinetestscreen(),
    ),
  ];

  final List<ActivityItem> activities = const [
    ActivityItem(title: 'Upcoming Event', date: 'May 25', icon: Icons.event),
    ActivityItem(title: 'Sports Day', date: 'June 1', icon: Icons.sports_soccer),
    ActivityItem(title: 'Parent-Teacher Meeting', date: 'May 30', icon: Icons.people),
  ];

  late TextEditingController _searchController;
  bool _isSearching = false;
  List<ModuleItem> filteredModules = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    filteredModules = modules;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchModules(String query) {
    setState(() {
      filteredModules = modules.where((module) {
        return module.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(),
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search modules...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.orangeAccent),
          ),
          style: const TextStyle(color: Colors.blueAccent),
          onChanged: _searchModules,
        )
            : const Text('My School'),
        actions: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                  filteredModules = modules;
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => _isSearching = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Modules',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.9,
                ),
                itemCount: filteredModules.length,
                itemBuilder: (context, index) => ModuleCard(
                  item: filteredModules[index],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'Activities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: activities.length,
                itemBuilder: (context, index) => ActivityCard(item: activities[index]),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ModuleItem {
  final String title;
  final IconData icon;
  final Widget route;

  const ModuleItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class ModuleCard extends StatelessWidget {
  final ModuleItem item;

  const ModuleCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item.route),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(item.icon, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityItem {
  final String title;
  final String date;
  final IconData icon;

  const ActivityItem({
    required this.title,
    required this.date,
    required this.icon,
  });
}

class ActivityCard extends StatelessWidget {
  final ActivityItem item;

  const ActivityCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.icon, color: Theme.of(context).primaryColor, size: 28),
              const SizedBox(height: 10),
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}