import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/voucher_controller.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VoucherController(Get.find()));

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: controller.isPayEnabled ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size.fromHeight(55),
            ),
            child: Text(
              "Pay ₹${controller.youPay.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final voucher = controller.voucher.value;
        if (voucher == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: RichText(
                      text: TextSpan(
                        text: "Refer & Earn ₹",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: "500",
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(Icons.close),
                ],
              ),
              const SizedBox(height: 20),

              /// Title
              Text(
                voucher.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              /// Amount Field
              ///
              TextField(
                keyboardType: TextInputType.number,
                onChanged: controller.changeAmount,
                decoration: InputDecoration(
                  labelText: "Enter your desired/ bill amount",
                  prefixText: "₹ ",
                  hintText: "Enter amount",
                  suffixText: "Max: ₹${voucher.maxAmount}",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Summary Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text("YOU PAY"),
                        Text(
                          "₹${controller.youPay.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 4,
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                    Column(
                      children: [
                        const Text("SAVINGS"),
                        Text(
                          "₹${controller.savings.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Payment Selector
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: voucher.discounts.map((e) {
                        return Obx(
                          () => Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  controller.changePaymentMethod(e.method),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        controller.selectedMethod.value ==
                                            e.method
                                        ? Colors.purple
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(e.method),
                                    Text(
                                      "${e.percent}% OFF",
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text("Quantity"),
                        Row(
                          children: [
                            IconButton(
                              onPressed: controller.decrementQty,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                              ),
                            ),
                            Obx(
                              () => Text(
                                controller.quantity.value.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: controller.incrementQty,
                              icon: const Icon(Icons.add, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 20),

              /// Redeem Steps
              const Text(
                "HOW TO REDEEM",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              ...voucher.redeemSteps.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    "• $e",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white, // text color
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('About Brand'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Terms & Conditions'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
