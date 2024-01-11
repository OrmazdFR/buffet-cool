import 'package:flutter/material.dart';
import '../menu/menu.widget.dart';
import '../order/order_page.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Accueil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Bienvenue !",
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MenuPage()),
                          );
                        },
                        child: const Text('Menu'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OrderPage()),
                          );
                        },
                        child: const Text('Commandes'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}