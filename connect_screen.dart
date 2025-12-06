// lib/screens/connect_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/database_service.dart';
import '../models/app_user.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text("Find Friends")),
      body: StreamBuilder<AppUser>(
        stream: DatabaseService().getUser(currentUserUid),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) return const Center(child: CircularProgressIndicator());
          final myProfile = userSnapshot.data!;

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseService().getCompatibleUsers(currentUserUid, myProfile.interests),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No new people found right now.", style: TextStyle(fontSize: 24)));
              }

              final matches = snapshot.data!;

              return ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final user = matches[index]['user'] as AppUser;
                  final common = matches[index]['common'] as List;

                  return Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                          Text("${user.ageGroup} • ${user.location}", style: const TextStyle(fontSize: 20, color: Colors.grey)),
                          const SizedBox(height: 10),
                          Text("You both like: ${common.take(3).join(', ')}", style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
                              onPressed: () async {
                                await DatabaseService().sendConnectionRequest(currentUserUid, user.uid);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Sent!")));
                              },
                              child: const Text("Connect", style: TextStyle(fontSize: 22, color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}