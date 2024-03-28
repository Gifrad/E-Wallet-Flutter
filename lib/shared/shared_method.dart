import 'package:another_flushbar/flushbar.dart';
import 'package:bank_sha/models/auth/user_model.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../models/auth/sign_in_form_model.dart';

void customSnackBar(BuildContext context, String message,
    {bool isError = true}) {
  Flushbar(
    message: message,
    flushbarPosition: isError ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    duration: const Duration(seconds: 2),
    backgroundColor: isError ? redColor : blueColor,
  ).show(context);
}

String formatCurrency(
  num number, {
  String symbol = 'Rp ',
}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}

Future<XFile?> selectImage() async {
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  return selectedImage;
}

bool pinValidate(TextEditingController controller) {
  if (controller.text.length != 6) {
    return false;
  }
  return true;
}

bool passportValidate(XFile? selectedImage) {
  if (selectedImage == null) {
    return false;
  }
  return true;
}

bool loginValidate(TextEditingController emailController,
    TextEditingController passwordController) {
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    return false;
  }
  return true;
}

Future<void> storeCredentialToLocal(UserModel user, String? password) async {
  try {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: user.token);
    await storage.write(key: 'email', value: user.email);
    await storage.write(key: 'password', value: password);
  } catch (e) {
    rethrow;
  }
}

Future<void> storePassToLocal(String? password) async {
  try {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'password', value: password);
  } catch (e) {
    rethrow;
  }
}

Future<SignInFormModel> getCredentialFormLocal() async {
  try {
    const storage = FlutterSecureStorage();
    Map<String, String> values = await storage.readAll();

    if (values['email'] == null || values['password'] == null) {
      print('email ${values['email']}');
      print('password ${values['password']}');
      throw 'authenticated';
    } else {
      final SignInFormModel data = SignInFormModel(
        email: values['email'],
        password: values['password'],
      );
      return data;
    }
  } catch (e) {
    rethrow;
  }
}

Future<String> getToken() async {
  String token = '';

  const storage = FlutterSecureStorage();
  String? value = await storage.read(key: 'token');

  if (value != null) {
    token = 'Bearer $value';
  }
  return token;
}

Future<void> clearLocalStorage() async {
  const storage = FlutterSecureStorage();
  await storage.deleteAll();
}

Future<void> clearLocalPassStorage() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: 'password');
}
