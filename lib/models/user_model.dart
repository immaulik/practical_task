import 'dart:convert';

class UserModel {
  bool success = false;
  int userId = 0;
  String firstName = "";
  String lastName = "";
  String primaryEmail = "";
  String profileImageUrl = "";
  String authToken = "";
  String mobileNumber = "";
  int rewardPoint = 0;
  String aliasId = "";
  String saferPayToken = "";
  String saferPayCardDetails = "";
  String birthDate = "";
  String message = "";

  UserModel();

  UserModel.fromJson(dynamic json) {
    success = json["success"] ?? false;
    userId = json["userId"] ?? 0;
    firstName = json["firstName"] ?? "";
    message = json["message"] ?? "";
    lastName = json["lastName"] ?? "";
    primaryEmail = json["primaryEmail"] ?? "";
    profileImageUrl = json["profileImageUrl"] ?? "";
    authToken = json["authToken"] ?? "";
    mobileNumber = json["mobileNumber"] ?? "";
    rewardPoint = json["rewardPoint"] ?? 0;
    aliasId = json["aliasId"] ?? "";
    saferPayToken = json["saferPayToken"] ?? "";
    saferPayCardDetails = json["saferPayCardDetails"] ?? "";
    birthDate = json["birthDate"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "primaryEmail": primaryEmail,
      "profileImageUrl": profileImageUrl,
      "authToken": authToken,
      "mobileNumber": mobileNumber,
      "rewardPoint": rewardPoint,
      "aliasId": aliasId,
      "saferPayToken": saferPayToken,
      "saferPayCardDetails": saferPayCardDetails,
      "birthDate": birthDate
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  factory UserModel.fromString(String str) {
    return UserModel.fromJson(json.decode(str));
  }
}
