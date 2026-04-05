// topup_model.dart
class QuickAddAmount {
  final String amount;
  final bool isSelected;

  QuickAddAmount({
    required this.amount,
    this.isSelected = false,
  });
}

class PaymentMethod {
  final String title;
  final String subtitle;
  final bool isRecommended;
  bool isSelected;

  PaymentMethod({
    required this.title,
    required this.subtitle,
    this.isRecommended = false,
    this.isSelected = false,
  });
}