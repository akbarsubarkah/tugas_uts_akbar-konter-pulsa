import 'dart:math';
import '../models/product.dart';
import '../models/transaction.dart';

class TransactionStore {
  static final List<TransactionItem> _items = [];

  static List<TransactionItem> all() => List.unmodifiable(_items);

  static TransactionItem add({
    required String phone,
    required Product product,
    required String status,
    String? message,
  }) {
    final item = TransactionItem(
      id: _randomId(),
      phone: phone,
      product: product,
      time: DateTime.now(),
      status: status,
      message: message,
    );
    _items.insert(0, item);
    return item;
  }

  static int todayTotal() {
    final now = DateTime.now();
    return _items
        .where((t) => t.status == 'success' && _isSameDay(t.time, now))
        .fold(0, (sum, t) => sum + t.product.price);
  }

  static int todayCount() {
    final now = DateTime.now();
    return _items.where((t) => _isSameDay(t.time, now)).length;
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String _randomId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random();
    return List.generate(8, (_) => chars[rnd.nextInt(chars.length)]).join();
  }
}
