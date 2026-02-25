📱 Voucher Purchase Screen – Flutter Assignment
🚀 Overview

This project implements a Voucher Purchase Screen based on the provided UI screenshots.
The focus is on clean architecture, proper state management, JSON parsing, and reactive UI updates.

State management is implemented using GetX, and the project follows a feature-based architecture with proper separation of concerns.

🏗 Architecture

This project follows a feature-based architecture:

lib/
 ├── core/
 ├── features/
 │    └── voucher/
 │         ├── data/
 │         │     ├── models/
 │         │     └── repository/
 │         ├── controller/
 │         └── presentation/
 │               ├── screens/
 │               └── widgets/
 └── main.dart

Repository → Handles data fetching (mock JSON).

Controller (GetX) → Contains all business logic and state.

UI (Presentation Layer) → Reacts to observable state using Obx().

🧠 State Management & State Flow
✅ State Management Used:

GetX

✅ State Flow:

Repository fetches voucher JSON → Controller parses and holds business logic in reactive (Rx) variables → UI listens to state changes using Obx() and rebuilds automatically.

Business logic is strictly placed inside the Controller and not inside UI widgets.

💳 Pay Button Enable/Disable Logic

The Pay button is enabled only when:

disablePurchase == false

Entered amount is within minAmount and maxAmount

Voucher data is successfully loaded

Logic implemented inside Controller:

bool get isPayEnabled {
  if (voucher.value == null) return false;
  if (voucher.value!.disablePurchase) return false;
  return amount.value >= voucher.value!.minAmount &&
         amount.value <= voucher.value!.maxAmount;
}

In UI:

onPressed: controller.isPayEnabled ? () {} : null

If conditions fail, the button becomes automatically disabled.

📊 Business Logic Implemented

discountAmount = amount * percent / 100

youPay = (amount - discountAmount) * quantity

savings = discountAmount * quantity

Quantity stepper updates total dynamically

Payment method selection updates discount reactively

All calculations are handled inside the Controller.

🎯 Features Implemented

Refer & Earn header

Amount input with ₹ prefix and max limit

Reactive YOU PAY & SAVINGS card

Payment method selector (UPI / Card)

Quantity stepper

Sticky bottom Pay button

Redeem steps section

Proper validation logic

▶️ How to Run
flutter pub get
flutter run
📌 Evaluation Checklist Covered

✔ Architecture & Folder Structure
✔ Proper Model Creation & JSON Parsing
✔ Correct State Flow (Repository → State → UI)
✔ Pay Button Enable/Disable Logic
✔ Clean Code & Separation of Business Logic