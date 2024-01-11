import 'package:flutter/material.dart';
import 'package:restaurant/dtos/item.dart';
import 'package:restaurant/services/item.service.dart';
import 'package:restaurant/pages/menu/menu.widget.dart';

class MenuCell extends StatefulWidget {
  const MenuCell({Key? key, required this.item, required this.type, required this.onDelete, required this.onEdit}) : super(key: key);

  final int type;
  final Item item;
  final VoidCallback onDelete;
  final Function() onEdit;

  @override
  State<MenuCell> createState() => _MenuCellState();
}

class _MenuCellState extends State<MenuCell> {
  TextEditingController itemNameController = TextEditingController();
  bool? selectedAvailability;
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: widget.type == 0 ? Colors.white : Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(widget.item.name, style: widget.item.availability == true ? const TextStyle(color: Colors.green) : const TextStyle(color: Colors.red)),
          ),
          IconButton(
            icon: const Icon(Icons.create_rounded),
            onPressed: () {
              _showEditItemDialog(context);
              widget.onEdit;
            },
            tooltip: "Modifier",
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ItemService().deleteItem(widget.item.ref!);
              widget.onDelete();
            },
            tooltip: "Supprimer",
          ),
        ],
      ),
    );
  }

  Future<void> _showEditItemDialog(BuildContext context) async {
    itemNameController.text = widget.item.name;
    selectedAvailability = widget.item.availability;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modifier le plat'),
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
                if (itemNameController.text.isNotEmpty && selectedAvailability != null) {
                  Item newItem = Item(
                    name: itemNameController.text,
                    availability: selectedAvailability!,
                  );

                  ItemService().updateItem(widget.item.ref!, newItem);
                  Navigator.of(context).pop();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MenuPage()));

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
