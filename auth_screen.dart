import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/accessible_widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _signup() async {
    setState(() => _isLoading = true);
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
      print("Signed up user UID: ${cred.user!.uid}");

      if (mounted) Navigator.of(context).pushReplacementNamed('/survey');
    } on FirebaseAuthException catch (e) {
      String message = 'Signup failed: ${e.message}';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(message, style: const TextStyle(fontSize: 20)),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailCtrl.text.trim(), password: _passCtrl.text.trim());
      if (mounted) Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed. Please check credentials.';
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Invalid email or password.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(message, style: const TextStyle(fontSize: 20)),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _goToSignup() => Navigator.of(context).pushReplacementNamed('/survey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Generations Connect",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text("Login or sign up to connect.",
                style: TextStyle(fontSize: 24, color: Colors.grey)),
            const SizedBox(height: 40),
            BigTextField(label: "Email Address", controller: _emailCtrl),
            BigTextField(label: "Password", controller: _passCtrl, isPassword: true),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator(color: Colors.blue)
                : Column(
                    children: [
                      BigButton(text: "Log In", icon: Icons.login, onPressed: _login),
                      const SizedBox(height: 10),
                      BigButton(
                          text: "Sign Up", icon: Icons.person_add, onPressed: _signup),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
