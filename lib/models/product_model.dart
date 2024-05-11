class ProductModel {
  String productName = "";
  int productId = 0;
  double perProductPrice = 0;
  int productCount = 0;
  String productOtherUrl = "";
  String productLocalName = "";
  String currencyCode = "";
  String currencyName = "";
  String shortName = "";
  String flavourName = "";
  String packagingType = "";

  ProductModel();

  ProductModel.fromJson(dynamic json) {
    productName = json["productName"] ?? "";
    productId = json["productId"] ?? 0;
    perProductPrice = json["perProductPrice"].toDouble() ?? 0;
    productCount = json["productCount"] ?? 0;
    productOtherUrl = json["productOtherUrl"] ?? "";
    productLocalName = json["productLocalName"] ?? "";
    currencyCode = json["currencyCode"] ?? "";
    currencyName = json["currencyName"] ?? "";
    shortName = json["shortName"] ?? "";
    flavourName = json["flavourName"] ?? "";
    packagingType = json["packagingType"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "productName": productName,
      "productId": productId,
      "perProductPrice": perProductPrice,
      "productCount": productCount,
      "productOtherUrl": productOtherUrl,
      "productLocalName": productLocalName,
      "currencyCode": currencyCode,
      "currencyName": currencyName,
      "shortName": shortName,
      "flavourName": flavourName,
      "packagingType": packagingType
    };
  }
}
