import 'package:get/get.dart';
import '../data/models/voucher_model.dart';
import '../data/repository/voucher_repository.dart';

class VoucherController extends GetxController {
  final VoucherRepository repository;

  VoucherController(this.repository);

  Rx<VoucherModel?> voucher = Rx<VoucherModel?>(null);
  RxInt amount = 100.obs;
  RxInt quantity = 1.obs;
  RxString selectedMethod = "UPI".obs;

  @override
  void onInit() {
    super.onInit();
    loadVoucher();
  }

  void loadVoucher() async {
    voucher.value = await repository.fetchVoucher();
  }

  int get discountPercent {
    return voucher.value!.discounts
        .firstWhere((e) => e.method == selectedMethod.value)
        .percent;
  }

  double get discountAmount => amount.value * discountPercent / 100;

  double get youPay => (amount.value - discountAmount) * quantity.value;

  double get savings => discountAmount * quantity.value;

  bool get isValidAmount {
    final v = voucher.value!;
    return amount.value >= v.minAmount && amount.value <= v.maxAmount;
  }

  bool get isPayEnabled {
    if (voucher.value == null) return false;
    if (voucher.value!.disablePurchase) return false;
    return isValidAmount;
  }

  void changeAmount(String val) {
    amount.value = int.tryParse(val) ?? 0;
  }

  void changePaymentMethod(String method) {
    selectedMethod.value = method;
  }

  void incrementQty() => quantity.value++;
  void decrementQty() {
    if (quantity.value > 1) quantity.value--;
  }
}
