class VoucherModel {
  final String id;
  final String title;
  final int minAmount;
  final int maxAmount;
  final bool disablePurchase;
  final List<Discount> discounts;
  final List<String> redeemSteps;

  VoucherModel({
    required this.id,
    required this.title,
    required this.minAmount,
    required this.maxAmount,
    required this.disablePurchase,
    required this.discounts,
    required this.redeemSteps,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      title: json['title'],
      minAmount: json['minAmount'],
      maxAmount: json['maxAmount'],
      disablePurchase: json['disablePurchase'],
      discounts: (json['discounts'] as List)
          .map((e) => Discount.fromJson(e))
          .toList(),
      redeemSteps: List<String>.from(json['redeemSteps']),
    );
  }
}

class Discount {
  final String method;
  final int percent;

  Discount({required this.method, required this.percent});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(method: json['method'], percent: json['percent']);
  }
}
