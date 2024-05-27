class AddonForDB {
  final String name;
  final double price;

  AddonForDB({
    required this.name,
    required this.price,
  });

  // Convert an AddonForDB object into a Map<String, dynamic> for database operations
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  // Construct an AddonForDB object from a Map<String, dynamic> retrieved from the database
  factory AddonForDB.fromMap(Map<String, dynamic> map) {
    return AddonForDB(
      name: map['name'],
      price: map['price'],
    );
  }
}
