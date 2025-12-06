import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/database_service.dart';
import '../models/app_user.dart';
import '../widgets/accessible_widgets.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});
  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _nameCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _jobCtrl = TextEditingController();

  String _ageGroup = 'Senior';
  final List<String> _selectedHobbies = [];
  bool _isLoading = false;

  final List<String> _hobbyOptions = [
    'Gardening', 'Technology', 'Reading', 'Knitting', 'History', 
    'Music', 'Cooking', 'Hiking', 'Gaming', 'Travel', 'Art',
  ];

  void _saveProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No authenticated user!");
      return;
    }

    final name = _nameCtrl.text.trim();
    final location = _locationCtrl.text.trim();
    final job = _jobCtrl.text.trim();

    if (name.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Name and Location required.", style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    AppUser newUser = AppUser(
      uid: user.uid,
      email: user.email ?? 'N/A',
      name: name,
      ageGroup: _ageGroup,
      location: location,
      hobbies: _selectedHobbies,
      interests: _selectedHobbies,
      pastJobs: job,
    );

    try {
      await DatabaseService().createUserProfile(newUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Profile saved!", style: TextStyle(fontSize: 20)),
              backgroundColor: Colors.green),
        );
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Error saving profile: $e", style: const TextStyle(fontSize: 20)),
            backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Up Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tell us about yourself", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            BigTextField(label: "Full Name", controller: _nameCtrl),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: BigButton(
                  text: "Senior (65+)",
                  icon: Icons.elderly,
                  color: _ageGroup == 'Senior' ? Colors.deepPurple : Colors.grey[400]!,
                  onPressed: () => setState(() => _ageGroup = 'Senior'),
                )),
                const SizedBox(width: 10),
                Expanded(child: BigButton(
                  text: "Youth (<25)",
                  icon: Icons.face_2,
                  color: _ageGroup == 'Youth' ? Colors.deepPurple : Colors.grey[400]!,
                  onPressed: () => setState(() => _ageGroup = 'Youth'),
                )),
              ],
            ),
            BigTextField(label: "Location", controller: _locationCtrl),
            BigTextField(label: "Past Jobs", controller: _jobCtrl, maxLines: 3),
            const SizedBox(height: 20),
            const Text("Select interests", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _hobbyOptions.map((hobby) {
                final isSelected = _selectedHobbies.contains(hobby);
                return ActionChip(
                  label: Text(hobby, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  backgroundColor: isSelected ? Colors.teal : Colors.grey[300],
                  onPressed: () {
                    setState(() {
                      isSelected ? _selectedHobbies.remove(hobby) : _selectedHobbies.add(hobby);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.green))
                : BigButton(text: "Finish Setup", icon: Icons.check_circle, onPressed: _saveProfile, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
