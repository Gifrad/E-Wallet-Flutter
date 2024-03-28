import 'dart:convert';

import 'package:bank_sha/models/auth/user_model.dart';
import 'package:bank_sha/models/user/edit_user_form.dart';
import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/shared_value.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<bool> updateUser(EditUserForm user) async {
    try {
      final token = await getToken();

      final res = await http.put(
        Uri.parse(
          '$baseUrl/users',
        ),
        body: user.toJson(),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode != 200) {
        throw json.decode(res.body)['message'];
      } else {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getRecentUser() async {
    try {
      final token = await getToken();
      final res = await http.get(
          Uri.parse(
            '$baseUrl/transfer-histories',
          ),
          headers: {
            'Authorization': token,
          });

      if (res.statusCode == 200) {
        List<UserModel> user = List<UserModel>.from(
          jsonDecode(res.body)['data'].map(
            (user) => UserModel.fromJson(user),
          ),
        );
        return user;
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUserByUsername(String username) async {
    try {
      final token = await getToken();
      final res = await http.get(
        Uri.parse(
          '$baseUrl/users/$username',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        List<UserModel> user = List<UserModel>.from(
          jsonDecode(res.body).map(
            (user) => UserModel.fromJson(user),
          ),
        );
        return user;
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
