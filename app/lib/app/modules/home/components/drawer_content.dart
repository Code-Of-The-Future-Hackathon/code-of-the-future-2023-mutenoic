import 'package:app/app/modules/home/components/content/anon_content.dart';
import 'package:app/app/modules/home/components/content/user_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Material(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top + 15),
            const Text(
              "Hackathon",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const UserContent();
                  } else {
                    return const AnonContent();
                  }
                },
              ),
            ),
            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }
}
