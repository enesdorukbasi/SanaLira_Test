import 'dart:convert';

BankJsonModel bankJsonModelFromJson(String str) =>
    BankJsonModel.fromJson(json.decode(str));

String bankJsonModelToJson(BankJsonModel data) => json.encode(data.toJson());

class BankJsonModel {
  BankJsonModel({
    this.bankName,
    this.bankIban,
    this.bankAccountName,
    this.descriptionNo,
  });

  String? bankName;
  String? bankIban;
  String? bankAccountName;
  String? descriptionNo;

  factory BankJsonModel.fromJson(Map<String, dynamic> json) => BankJsonModel(
        bankName: json["bankName"],
        bankIban: json["bankIban"],
        bankAccountName: json["bankAccountName"],
        descriptionNo: json["descriptionNo"],
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "bankIban": bankIban,
        "bankAccountName": bankAccountName,
        "descriptionNo": descriptionNo,
      };
}
