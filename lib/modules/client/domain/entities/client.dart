class Client {
  final String? uuid;
  final String name;
  final String document;
  final int statusCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Client({
    this.uuid,
    required this.name,
    required this.document,
    required this.statusCode,
    required this.createdAt,
    required this.updatedAt,
  });
}
