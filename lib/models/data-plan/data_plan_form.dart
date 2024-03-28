class DataPlanForm {
  final int? dataPlanId;
  final String? pin;
  final String? phoneNumber;

  DataPlanForm({
    this.dataPlanId,
    this.pin,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'data_plan_id': dataPlanId.toString(),
      'phone_number': phoneNumber,
      'pin': pin,
    };
  }
}
