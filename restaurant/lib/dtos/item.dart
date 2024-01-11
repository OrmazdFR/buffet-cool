class Item {
  String? ref;
  String name;
  bool availability;

  Item({this.ref, required this.name, required this.availability});

  factory Item.fromJSON(Map<String, dynamic> json) {
    return Item(
      ref: json['ref'],
      name: json['name'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'ref': ref,
      'name': name,
      'availability': availability,
    };
  }
}