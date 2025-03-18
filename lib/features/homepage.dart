import 'package:drive_or_drunk_app/core/theme/theme_provider.dart';
import 'package:drive_or_drunk_app/models/user_model.dart' as userModel;
import 'package:drive_or_drunk_app/services/firestore_service.dart';
import 'package:drive_or_drunk_app/widgets/custom_stream_builder.dart'
    show CustomStreamBuilder;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final FirestoreService _firestoreService = FirestoreService();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          IconButton(
            icon: Icon(
                context.watch<ThemeProvider>().themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${user?.email ?? 'User'}!',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create a example user on the database
                final user = userModel.User(
                  name: 'John Doe',
                  username: 'johndoe',
                );
                _firestoreService.addUser(user);
              },
              child: const Text('Create User'),
            ),
            CustomStreamBuilder(
              stream: _firestoreService.getUsers(),
              customListTileBuilder: (user) {
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(
                      'Username: ${user.username} Registered Events: ${user.registeredEvents}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _firestoreService.deleteUser(user.id),
                  ),
                );
              },
            ),
            const Divider(
              height: 40,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            CustomStreamBuilder(
              stream: _firestoreService.getEvents(),
              customListTileBuilder: (event) {
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(
                      'Drivers: ${event.drivers.length}, Drunkards: ${event.drunkards.length}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _firestoreService.deleteEvent(event.id),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
