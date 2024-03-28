import 'package:bank_sha/models/payment/payment_method_model.dart';
import 'package:bank_sha/models/transaction/transaction_type_model.dart';

class TransactionModel {
  final int? id;
  final String? userId;
  final String? transactionTypeId;
  final String? paymentMenthodId;
  final int? productId;
  final String? amount;
  final String? transactionCode;
  final String? description;
  final String? status;
  final DateTime? createdAt;
  final PaymentMethodModel? paymentMethod;
  final TransactionTypeModel? transactionTypeModel;

  TransactionModel({
    this.id,
    this.userId,
    this.transactionTypeId,
    this.paymentMenthodId,
    this.productId,
    this.amount,
    this.transactionCode,
    this.description,
    this.status,
    this.createdAt,
    this.paymentMethod,
    this.transactionTypeModel,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        userId: json['user_id'],
        transactionTypeId: json['transaction_type_id'],
        paymentMenthodId: json['payment_method_id'],
        productId: json['product'] == null ? null : json['product_id'],
        amount: json['amount'],
        transactionCode: json['transaction_code'],
        description: json['description'],
        status: json['status'],
        createdAt: DateTime.tryParse(json['created_at']),
        paymentMethod: json['paymentMethod'] == null
            ? null
            : PaymentMethodModel.fromJson(json['paymentMethod']),
        transactionTypeModel: json['transactionType'] == null
            ? null
            : TransactionTypeModel.fromJson(json['transactionType']),
      );
}
