import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserContent extends StatelessWidget {
  const UserContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.sensors),
          title: const Text('Sensors'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.cloud),
          title: const Text('Weather'),
          onTap: () {},
        ),
        const Spacer(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
