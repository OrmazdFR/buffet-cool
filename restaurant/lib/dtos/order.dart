class Order {
  String? ref;
  bool completed;
  List<OrderItem> items;

  Order({this.ref, required this.completed, required this.items});

  factory Order.fromJSON(Map<String, dynamic> json) {
    return Order(
      ref: json['ref'],
      completed: json['completed'],
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => OrderItem.fromJSON(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'ref': ref,
      'completed': completed,
      'orderItems': items.map((item) => item.toJSON()).toList(),
    };
  }
}

class OrderItem {
  String name;
  int qty;

  OrderItem({required this.name, required this.qty});

  factory OrderItem.fromJSON(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'qty': qty,
    };
  }
}
