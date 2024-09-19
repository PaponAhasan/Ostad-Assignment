class Product {
  // Properties
  final String? id;
  final String? createdAt;
  final String productName;
  final String image;
  final String productCode;
  final String unitPrice;
  final String quantity;
  final String totalPrice;

  // Constructor
  Product({
    this.id,
    this.createdAt,
    required this.productName,
    required this.image,
    required this.productCode,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  });

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'ProductName': productName,
      'Img': image,
      'ProductCode': productCode,
      'UnitPrice': unitPrice,
      'Qty': quantity,
      'TotalPrice': totalPrice,
    };
  }

  // Convert JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      createdAt: json['CreatedDate'],
      productName: json['ProductName'],
      image: json['Img'],
      productCode: json['ProductCode'],
      unitPrice: json['UnitPrice'],
      quantity: json['Qty'],
      totalPrice: json['TotalPrice'],
    );
  }
}
