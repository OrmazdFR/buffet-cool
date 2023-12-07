import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/item.dart';

class ItemService {
  static const String baseUrl = "https://api.punkapi.com/v2/beers";

  static Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final json = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
      return json.map((element) => Item.fromJSON(element)).toList();
    }
    return [];
  }

  static Future<void> addItem(Item newItem) async {
    final response = await http.post(
      Uri.parse("$baseUrl/addItem"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(newItem.toJSON()),
    );

    if (response.statusCode == 200) {
      // Logique en cas de succès
    } else {
      // Logique en cas d'échec
    }
  }

  static Future<void> deleteItem(int itemId) async {
    final response = await http.delete(Uri.parse("$baseUrl/deleteItem/$itemId"));

    if (response.statusCode == 200) {
      // Logique en cas de succès
    } else {
      // Logique en cas d'échec
    }
  }

  static Future<void> updateItem(Item modifiedItem) async {
    final response = await http.put(
      Uri.parse("$baseUrl/updateItem/${modifiedItem.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(modifiedItem.toJSON()),
    );

    if (response.statusCode == 200) {
      // Logique en cas de succès
    } else {
      // Logique en cas d'échec
    }
  }
}
