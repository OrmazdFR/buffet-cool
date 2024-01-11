import 'package:flutter/material.dart';
import 'package:restaurant/homepage.widget.dart';
import '../login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Inscription"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Formulaire d'inscription",
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
            ElevatedButton(onPressed: () async {
              if (email.isNotEmpty && password.isNotEmpty) {
                try {
                  UserCredential userCredential =
                      await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  print('User registered: ${userCredential.user!.uid}');

                  if(context.mounted){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                             (context) => const MyHomePage()));
                  }
                } on FirebaseAuthException catch (e) {
                  print('Error registering user: $e');
                  if(context.mounted) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Registration Error'),
                          content: Text(e.message ??
                              'An error occurred during registration.'),
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
            }, child: const Text("S'inscrire")),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Déjà inscrit ?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  }
                  ,child: const Text("Se connecter"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
