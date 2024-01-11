import 'package:flutter/material.dart';
import '../../services/item.service.dart';
import 'menu_list.widget.dart';
import '../../dtos/item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  TextEditingController itemNameController = TextEditingController();
  bool? selectedAvailability;
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Menu'),
      ),
      body: FutureBuilder(
        future: ItemService().getItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erreur de plat !"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("Pas de plats disponibles."),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Plats',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 20),
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
                        // Show the pop-up for adding a new item
                        _showAddItemDialog(context);
                      },
                      child: const Text('Ajouter un plat'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: MenuList(
                  items: snapshot.data!,
                  onDelete: (index) {
                    setState(() {
                      snapshot.data!.removeAt(index);
                    });
                  },
                  onEdit: () {
                    setState(() {});
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Function to show the pop-up for adding a new item
  Future<void> _showAddItemDialog(BuildContext context) async {
    itemNameController.text = ''; // Clear the text field
    selectedAvailability = null; // Reset the selected availability

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un plat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: itemNameController,
                decoration: const InputDecoration(labelText: 'Nom du plat'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<bool>(
                value: selectedAvailability,
                onChanged: (bool? value) {
                  setState(() {
                    selectedAvailability = value;
                  });
                },
                items: const [
                  DropdownMenuItem<bool>(
                    value: true,
                    child: Text('Disponible'),
                  ),
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text('Indisponible'),
                  ),
                ],
                decoration: const InputDecoration(labelText: 'Disponibilité'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Check if both name and availability are entered
                if (itemNameController.text.isNotEmpty && selectedAvailability != null) {
                  // Create a new Item object
                  Item newItem = Item(
                    name: itemNameController.text,
                    availability: selectedAvailability!,
                  );

                  // Save the new item
                  ItemService().addItem(newItem).then((_) {
                    // Update the local list with the new item
                    setState(() {
                      items.add(newItem);
                    });

                    Navigator.of(context).pop(); // Close the pop-up
                  });
                }
              },
              child: const Text('Sauvegarder'),
            ),
          ],
        );
      },
    );
  }
}