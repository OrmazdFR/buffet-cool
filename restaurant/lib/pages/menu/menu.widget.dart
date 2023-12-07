import 'package:flutter/material.dart';
import '../../services/item.service.dart';
import 'menu_list.widget.dart';


class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Menu !'),
      ),
      body: FutureBuilder(
        future: ItemService.getItems(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(
              child: Text("Erreur d'Item !"),
            );
          }
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return MenuList(items: snapshot.data!);
        },
      ),
    );
  }
}
