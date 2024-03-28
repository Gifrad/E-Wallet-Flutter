import 'dart:convert';

import 'package:bank_sha/models/tips/tips_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/shared_value.dart';
import 'package:http/http.dart' as http;

class TipsService {
  Future<List<TipsModel>> getTips() async {
    try {
      final token = await getToken();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/tips',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TipsModel>.from(jsonDecode(res.body)['data']
            .map((tips) => TipsModel.formJson(tips))).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
