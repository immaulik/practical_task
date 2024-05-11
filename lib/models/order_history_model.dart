import 'package:practical_task/models/product_model.dart';

class OrderHistoryModel {
  DateTime date = DateTime(0);
  String orderId = "";
  double paidAmount = 0;
  int redeemedRewards = 0;
  String coolerId = "";
  String paymentStatus = "";
  int amountDeductedByRewardPoint = 0;
  double amountDeductedByPaymentGateway = 0;
  List<ProductModel> products = <ProductModel>[];

  OrderHistoryModel();

  OrderHistoryModel.fromJson(dynamic json) {
    date = json['date'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['date'])
        : DateTime(0);
    orderId = json["orderID"] ?? "";
    paidAmount = json["paidAmount"].toDouble() ?? 0;
    redeemedRewards = json["redeemedRewards"] ?? 0;
    coolerId = json["coolerId"] ?? "";
    paymentStatus = json["paymentStatus"] ?? "";
    amountDeductedByRewardPoint = json["amountDeductedByRewardPoint"] ?? 0;
    amountDeductedByPaymentGateway =
        json["amountDeductedByPaymentGateway"].toDouble() ?? 0;
    products = ((json["product"] ?? []) as List<dynamic>)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
