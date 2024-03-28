import 'dart:convert';

import 'package:bank_sha/models/data-plan/data_plan_form.dart';
import 'package:bank_sha/models/transaction/top_up_form_model.dart';
import 'package:bank_sha/models/transaction/transaction_model.dart';
import 'package:bank_sha/models/transaction/transfer_form_model.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/shared_value.dart';
import 'package:http/http.dart' as http;

import '../../models/operator-card/operator_card_model.dart';

class TransactionService {
  Future<String> topUp(TopupFormModel data) async {
    try {
      String token = await getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/top-ups'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        final String redirectUrl;
        redirectUrl = jsonDecode(res.body)['redirect_url'];
        return redirectUrl;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transfer(TransferFormModel data) async {
    try {
      String token = await getToken();

      final res = await http.post(
        Uri.parse('$baseUrl/transfers'),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OperatorCardModel>> getOperatorCards() async {
    try {
      final token = await getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/operator-cards',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<OperatorCardModel>.from(
          jsonDecode(res.body)['data'].map(
            (operatorCard) => OperatorCardModel.fromJson(operatorCard),
          ),
        ).toList();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dataPlan(DataPlanForm data) async {
    try {
      final token = await getToken();

      final res = await http.post(
        Uri.parse(
          '$baseUrl/data-plans',
        ),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        return jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransaction() async {
    try {
      final token = await getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/transactions',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TransactionModel>.from(
          jsonDecode(res.body)['data'].map(
            (transaction) => TransactionModel.fromJson(transaction),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
