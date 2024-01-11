import '../dtos/order.dart' as Order;
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Stream<List<Order.Order>> getOrdersStream() {
    return orders.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Order.Order.fromJSON(doc.data() as Map<String, dynamic>)
          ..ref = doc.reference.id;
      }).toList();
    });
  }

  Future<void> markAsCompleted(String orderRef) async {
    try {
      DocumentReference orderDocRef = orders.doc(orderRef);

      await orderDocRef.update({'completed': true});
      print('Order marked as completed: $orderRef');
    } catch (error) {
      print('Error marking order as completed: $error');
    }
  }

  /*
  Future<List<Order.Order>> getOrders() async {
    try {
      Stream<QuerySnapshot> stream = orders.snapshots();
      stream.listen((querySnapshot) {
        print('Received Firestore data: $querySnapshot');
      });
      List<Order.Order> firestoreOrders = [];

      await for (QuerySnapshot querySnapshot in stream) {
        firestoreOrders = querySnapshot.docs.map((doc) {
          //print('Document data: ${doc.data()}');
          return Order.Order.fromJSON(doc.data() as Map<String, dynamic>)
            ..ref = doc.reference.id;
        }).toList();
      }

      print('orders: $firestoreOrders');
      return firestoreOrders;
    } catch (error) {
      print('Error getting real-time orders: $error');
      return [];
    }
  }

  Future<void> addOrder(Order.Order newOrder) {
    Map<String, dynamic> orderMap = newOrder.toJSON();

    return orders
        .add(orderMap)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  Future<void> deleteOrder(String orderRef) async {
    return orders
        .doc(orderRef)
        .delete()
        .then((value) => print("Order Deleted"))
        .catchError((error) => print("Failed to delete order: $error"));
  }

  Future<void> updateOrder(String orderID, Order.Order newOrder) {
    Map<String, dynamic> orderMap = newOrder.toJSON();

    return orders
        .doc(orderID)
        .update(orderMap)
        .then((value) => print("Order Updated"))
        .catchError((error) => print("Failed to update order: $error"));
  }
   */
}
