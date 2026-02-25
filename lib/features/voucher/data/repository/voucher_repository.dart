import 'dart:convert';
import '../models/voucher_model.dart';

class VoucherRepository {
  Future<VoucherModel> fetchVoucher() async {
    const mockJson = '''
    {
      "id": "zepto-100",
      "title": "Zepto Instant Voucher",
      "minAmount": 50,
      "maxAmount": 10000,
      "disablePurchase": false,
      "discounts": [
        { "method": "UPI", "percent": 4 },
        { "method": "CARD", "percent": 4 }
      ],
      "redeemSteps": [
        "Login to Zepto Platform",
        "Click on My profile / Settings",
        "Go to Zepto Cash & Gift Card",
        "Click on Add Card option"
      ]
    }
    ''';

    return VoucherModel.fromJson(json.decode(mockJson));
  }
}
