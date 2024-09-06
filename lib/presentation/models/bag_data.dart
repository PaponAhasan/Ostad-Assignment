class BagData {
  final String image;
  final String name;
  final String color;
  final String size;
  final double price;
  late int perCount = 0;
  late double perTotalPrice = 0;

  BagData({
    required this.image,
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    this.perCount = 0,
    this.perTotalPrice = 0,
  });
}

List<BagData> bagDataList = [
  BagData(
    image: "images/ic_shirt_black.png",
    name: "Pullover",
    color: "Black",
    size: "M",
    price: 51.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_red.png",
    name: "T-Shirt",
    color: "Gray",
    size: "L",
    price: 30.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_white.png",
    name: "Sport Dress",
    color: "Black",
    size: "M",
    price: 100.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_black.png",
    name: "Pullover",
    color: "Black",
    size: "M",
    price: 51.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_red.png",
    name: "T-Shirt",
    color: "Gray",
    size: "L",
    price: 30.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_white.png",
    name: "Sport Dress",
    color: "Black",
    size: "M",
    price: 100.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_black.png",
    name: "Pullover",
    color: "Black",
    size: "M",
    price: 51.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_red.png",
    name: "T-Shirt",
    color: "Gray",
    size: "L",
    price: 30.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
  BagData(
    image: "images/ic_shirt_white.png",
    name: "Sport Dress",
    color: "Black",
    size: "M",
    price: 100.0,
    perCount: 0,
    perTotalPrice: 0,
  ),
];
