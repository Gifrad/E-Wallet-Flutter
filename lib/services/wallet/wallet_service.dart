import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../shared/shared_method.dart';
import '../../shared/shared_value.dart';

class WalletService {
  Future<void> updatePin(String oldPin, String newPin) async {
    try {
      final token = await getToken();

      final res = await http.put(
        Uri.parse(
          '$baseUrl/wallets',
        ),
        body: {
          'previous_pin': oldPin,
          'new_pin': newPin,
        },
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode != 200) {
        throw json.decode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
