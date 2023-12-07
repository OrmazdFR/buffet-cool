import 'package:flutter/material.dart';
import '../menu/menu.widget.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Connexion !"),
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
            ElevatedButton(onPressed: () {
              if (email.isNotEmpty && password.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const MenuPage()));
              }
            }, child: const Text('Connexion')),
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
