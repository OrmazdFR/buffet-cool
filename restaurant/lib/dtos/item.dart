class Item {
  int id;
  String name;

  Item(this.id, this.name);

  static Item fromJSON(Map<String, dynamic> json) {
    return Item(json['id'], json['name']);
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
    };
  }
}