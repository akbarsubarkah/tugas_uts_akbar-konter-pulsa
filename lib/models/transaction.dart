import 'product.dart';

class TransactionItem {
  final String id;
  final String phone;
  final Product product;
  final DateTime time;
  final String status; // 'success' atau 'failed'
  final String? message;

  const TransactionItem({
    required this.id,
    required this.phone,
    required this.product,
    required this.time,
    required this.status,
    this.message,
  });
}
