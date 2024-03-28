class TopupFormModel {
  final String? amount;
  final String? pin;
  final String? paymentMethodeCode;

  TopupFormModel({
    this.amount,
    this.pin,
    this.paymentMethodeCode,
  });

  TopupFormModel copyWith({
    String? amount,
    String? pin,
    String? paymentMethodeCode,
  }) =>
      TopupFormModel(
        amount: amount ?? this.amount,
        pin: pin ?? this.pin,
        paymentMethodeCode: paymentMethodeCode ?? this.paymentMethodeCode,
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'pin': pin,
        'payment_method_code': paymentMethodeCode,
      };
}
