import 'package:flutter/material.dart';
import 'package:restaurant/dtos/item.dart';

class MenuCell extends StatefulWidget {
  const MenuCell({Key? key, required this.item, required this.type}) : super(key: key);

  final int type;
  final Item item;

  @override
  State<MenuCell> createState() => _MenuCellState();
}

class _MenuCellState extends State<MenuCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: widget.type == 0 ? Colors.white : Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(widget.item.name, style: const TextStyle(color: Colors.blue)),
          ),
          IconButton(
            icon: const Icon(Icons.create_rounded),
            onPressed: () {
              // TODO: Appeler ItemService.update(id)
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO: Appeler ItemService.delete(id)
            },
          ),
        ],
      ),
    );
  }
}
