import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title});
  final String title;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Oui',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
      ),
    );
  }
}


