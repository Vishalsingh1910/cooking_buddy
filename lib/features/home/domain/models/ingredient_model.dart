class Ingredient {
  final String id;
  final String name;
  final String category;

  const Ingredient({
    required this.id,
    required this.name,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
