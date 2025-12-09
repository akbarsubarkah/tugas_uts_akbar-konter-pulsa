class Product {
  final String operatorName;
  final String name;
  final String type; // 'pulsa' atau 'data'
  final int price;

  const Product({
    required this.operatorName,
    required this.name,
    required this.type,
    required this.price,
  });
}
