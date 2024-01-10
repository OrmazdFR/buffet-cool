import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            const Directionality(
                textDirection: TextDirection.ltr,
                child: Text("Connexion", style: TextStyle(fontSize: 18.0))),
            const SizedBox(height: 10),
            SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Email'),
                  onChanged: (str) {
                    email = str;
                  },
                )),
            const SizedBox(height: 10),
            SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Password'),
                  onChanged: (str) {
                    password = str;
                  },
                  obscureText: true,
                )),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (email.isNotEmpty && password.isNotEmpty) {
                    print("Mener vers menu");
                  }
                },
                child: const Text('Connexion')),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text("Pas encore inscrit ?")),
                TextButton(
                    onPressed: () {
                      print('Mener vers inscription');
                    },
                    child: const Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text("S'inscrire"),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
