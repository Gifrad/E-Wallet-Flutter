class DataPlanModel {
  final int? id;
  final String? name;
  final String? price;
  final String? operatorCardId;

  DataPlanModel({
    this.id,
    this.name,
    this.price,
    this.operatorCardId,
  });

  factory DataPlanModel.fromJson(Map<String, dynamic> json) => DataPlanModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        operatorCardId: json['operator_card_id'],
      );
}
