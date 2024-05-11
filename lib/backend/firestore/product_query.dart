import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practical_task/models/product_model.dart';

class ProductQuery {
  CollectionReference<Map<String, dynamic>> productCol =
      FirebaseFirestore.instance.collection("products");

  Future<void> createNotification({required ProductModel model}) async {
    await productCol.add(model.toJson());
  }
}
