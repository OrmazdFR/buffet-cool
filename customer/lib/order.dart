import 'package:flutter/material.dart';
import 'counter_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.round});
  final int round;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class Food {
  String name;

  Food(this.name);
}

class _OrderPageState extends State<OrderPage> {
  //Normalement là on récupère la liste depuis l'API
  final List<Food> foodList = [
    Food('Maki printemps'),
    Food('Nems miam'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Round  $widget.round.toString()'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            const Text( 'Food list',
              textDirection: TextDirection.ltr,
            ),
            for(var food in foodList) Text(food.name), const Counter(value: 0)
          ],
        ),
      ),
    );
  }
}

