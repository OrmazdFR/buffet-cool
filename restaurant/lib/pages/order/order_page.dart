import 'package:flutter/material.dart';
import '../../dtos/order.dart';
import '../../services/order.service.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Commandes'),
      ),
      body: StreamBuilder<List<Order>>(
        stream: OrderService().getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erreur de commande !"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("Pas de commandes disponibles."),
            );
          }

          List<Order> orders = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Commandes',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    Order order = orders[index];
                    return Card(
                      color: order.completed ? Colors.green : Colors.red,
                      child: ListTile(
                        title: Text('Référence de la commande: ${order.ref}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Terminée ? : ${order.completed ? 'Oui' : 'Non'}'),
                            for (var orderItem in order.items)
                              Text('Plat: ${orderItem.name}, Quantité: ${orderItem.qty}'),
                          ],
                        ),
                        trailing: order.completed ? null : IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            OrderService().markAsCompleted(order.ref!);
                            setState(() {});
                          },
                          tooltip: 'Marquer comme terminée',
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}