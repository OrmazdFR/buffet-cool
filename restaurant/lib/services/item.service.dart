import '../dtos/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference items = FirebaseFirestore.instance.collection('items');

  Future<List<Item>> getItems() async {
    try {
      Stream<QuerySnapshot> stream = items.snapshots();
      List<Item> firestoreItems = [];

      await for (QuerySnapshot querySnapshot in stream) {
        firestoreItems = querySnapshot.docs.map((doc) {
          return Item.fromJSON(doc.data() as Map<String, dynamic>)
            ..ref = doc.reference.id;
        }).toList();

        if (firestoreItems.isNotEmpty) {
          return firestoreItems;
        }
      }

      return [];
    } catch (error) {
      print('Error getting real-time items: $error');
      return [];
    }
  }

  Future<void> addItem(Item newItem) {
    Map<String, dynamic> itemMap = newItem.toJSON();

    return items
        .add(itemMap)
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add item: $error"));
  }

  Future<void> deleteItem(String itemRef) async {
    return items
        .doc(itemRef)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateItem(String itemRef, Item newItem) {
    Map<String, dynamic> itemMap = newItem.toJSON();

    return items
        .doc(itemRef)
        .update(itemMap)
        .then((value) => print("Item Updated"))
        .catchError((error) => print("Failed to update item: $error"));
  }

}
