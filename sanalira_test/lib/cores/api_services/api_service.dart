import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sanalira_test/models/json_models/bank_json_model.dart';

class ApiService {
  String api = "https://api.sanalira.com/";

  Future<List<BankJsonModel>> getBanks() async {
    List<BankJsonModel> banks = [];
    var response = await Dio().get(api + "assignment");
    if (response.statusCode == HttpStatus.ok) {
      final responseDatas = response.data['data'] as List;

      banks = responseDatas.map((e) => BankJsonModel.fromJson(e)).toList();
    }

    return banks;
  }
}
