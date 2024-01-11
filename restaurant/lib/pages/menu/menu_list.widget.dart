import 'package:flutter/material.dart';
import '../../dtos/item.dart';
import 'menu_cell.widget.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key, required this.items, required this.onDelete, required this.onEdit});

  final List<Item> items;
  final Function(int) onDelete;
  final Function() onEdit;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return MenuCell(
              item: items[index],
              type: index % 2,
              onDelete: () => onDelete(index),
              onEdit: onEdit,
          );
        }

    );
  }
}
