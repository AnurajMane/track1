import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // For state management

class navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(appState.userName, appState.userEmail),
          _buildDrawerItem(
            icon: Icons.favorite,
            title: 'Favorite',
            onTap: () => _navigateTo(context, '/favorite'),
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: 'Friends',
            onTap: () => _navigateTo(context, '/friends'),
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.share,
            title: 'Share',
            onTap: () => _navigateTo(context, '/share'),
          ),
          _buildDrawerItem(
            icon: Icons.notifications,
            title: 'Requests',
            onTap: () => _navigateTo(context, '/requests'),
            trailing: _buildNotificationBadge(0),
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => _navigateTo(context, '/settings'),
          ),
          _buildDrawerItem(
            icon: Icons.lightbulb,
            title: 'Dark Mode',
            onTap: () => appState.toggleDarkMode(),
          ),
          _buildDrawerItem(
            icon: Icons.policy,
            title: 'Policies',
            onTap: () => _navigateTo(context, '/policies'),
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.exit_to_app,
            title: 'Exit',
            onTap: () => _exitApp(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(String userName, String userEmail) {
    return UserAccountsDrawerHeader(
      accountName: Text(userName),
      accountEmail: Text(userEmail),
      currentAccountPicture: CircleAvatar(
        child: ClipOval(
          child: Icon(Icons.person),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF179bd6), Color(0xFF91e5f6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      trailing: trailing,
    );
  }

  Widget _buildNotificationBadge(int count) {
    return ClipOval(
      child: Container(
        color: Colors.redAccent,
        width: 20,
        height: 20,
        child: Center(
          child: Text(
            '$count',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Close the drawer
    Navigator.pushNamed(context, route); // Navigate to the route
  }

  void _exitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pop(context); // Close the drawer
              // Exit the app (works on Android, not iOS)
              SystemNavigator.pop();
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }
}

class AppState with ChangeNotifier {
  bool _isDarkMode = false;
  String _userName = 'Someone'; // Default value
  String _userEmail = 'someone@gmail.com'; // Default value

  bool get isDarkMode => _isDarkMode;
  String get userName => _userName;
  String get userEmail => _userEmail;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Method to update user data
  void setUserData(String name, String email) {
    _userName = name;
    _userEmail = email;
    notifyListeners(); // Notify listeners to update the UI
  }
}