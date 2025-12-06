// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/accessible_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("What would you like to do?", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: BigButton(
                text: "Connect With Others",
                icon: Icons.people_outline,
                color: Colors.deepPurple,
                onPressed: () => Navigator.pushNamed(context, '/connect'),
              ),
            ),
            Expanded(
              child: BigButton(
                text: "Your Conversations",
                icon: Icons.chat_bubble_outline,
                color: Colors.teal,
                onPressed: () => Navigator.pushNamed(context, '/conversations'),
              ),
            ),
            Expanded(
              child: BigButton(
                text: "Your Profile",
                icon: Icons.person_outline,
                color: Colors.orange[800]!,
                onPressed: () => Navigator.pushNamed(context, '/profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}