import 'dart:convert';

import 'package:bank_sha/models/payment/payment_method_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/shared_value.dart';
import 'package:http/http.dart' as http;

class PaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMethod() async {
    try {
      final token = await getToken();

      final res = await http.get(
          Uri.parse(
            '$baseUrl/payment-methods',
          ),
          headers: {
            'Authorization': token,
          });
      if (res.statusCode == 200) {
        List<PaymentMethodModel> data = List<PaymentMethodModel>.from(
            jsonDecode(res.body)
                .map((paymentMethod) =>
                    PaymentMethodModel.fromJson(paymentMethod))
                .toList());
        return data;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
