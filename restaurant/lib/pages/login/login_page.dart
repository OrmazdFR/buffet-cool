import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../register/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Connexion"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Formulaire de connexion",
            style: TextStyle(fontSize: 18.0)),
            const SizedBox(height: 10),
            SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)), labelText: 'Email'),
                  onChanged: (str) { email = str; },
                )
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)), labelText: 'Password'),
                  onChanged: (str) { password = str; },
                  obscureText: true,
                )
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (email.isNotEmpty && password.isNotEmpty) {
                  try {
                    UserCredential userCredential =
                    await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    print('User logged in: ${userCredential.user!.uid}');

                    // Navigate to the menu page after successful login
                    if (context.mounted) {
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                               (context) => const HomePage()));
                    }
                  } on FirebaseAuthException catch (e) {
                    print('Error logging in: $e');

                    // Show a pop-up with the Firebase error message
                    if(context.mounted) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Error'),
                            content: Text(
                                e.message ?? 'An error occurred during login.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                }
              },
              child: const Text('Connexion'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Pas encore inscrit ?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const RegisterPage()));
                    }
                  ,child: const Text("S'inscrire"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
