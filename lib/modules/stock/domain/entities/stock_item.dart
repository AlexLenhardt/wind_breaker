class StockItem {
  final String? id;
  final String code;
  final String name;
  final String description;
  final String timberCode;
  final int? quantity;

  StockItem({
    this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.timberCode,
    this.quantity,
  });
}
