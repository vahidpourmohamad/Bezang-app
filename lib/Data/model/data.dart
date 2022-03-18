import 'package:bestbuy/Data/model/category.dart';
import 'package:bestbuy/Data/model/product.dart';

class AppDatas {
  static List<Product> productList = [
    Product(
        id: 1,
        name: 'گوشت گوساله',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/images/test/1P.png',
        category: "پروتئین ها"),
    Product(
        id: 2,
        name: 'گوشت گوسفند',
        price: 120000,
        isliked: false,
        image: 'assets/images/test/2P.png',
        category: "پروتئین ها"),
    Product(
        id: 3,
        name: 'گوشت برزیلی',
        price: 90000,
        isliked: false,
        image: 'assets/images/test/3P.png',
        category: "پروتئین ها"),
    Product(
        id: 4,
        name: 'دوغ',
        price: 12000,
        isliked: false,
        image: 'assets/images/test/4.png',
        category: "نوشیدنی"),
    Product(
        id: 5,
        name: 'مرغ',
        price: 35000,
        isliked: false,
        image: 'assets/images/test/5.png',
        category: "پروتئین ها"),
  ];
  static List<Product> cartList = [
    Product(
        id: 1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/images/small_tilt_shoe_1.png',
        category: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 97',
        price: 190.00,
        isliked: false,
        image: 'assets/images/small_tilt_shoe_2.png',
        category: "Trending Now"),
    Product(
        id: 1,
        name: 'Nike Air Max 92607',
        price: 220.00,
        isliked: false,
        image: 'assets/images/small_tilt_shoe_3.png',
        category: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/images/small_tilt_shoe_1.png',
        category: "Trending Now"),
    // Product(
    //     id:1,
    //     name: 'Nike Air Max 97',
    //     price: 190.00,
    //     isliked: false,
    //     image: 'assets/images/small_tilt_shoe_2.png',
    //     category: "Trending Now"),
  ];
  static List<Category> categoryList = [
    Category(id: 1, name: "لباس", image: 'assets/images/test/cloth.png'),
    Category(id: 2, name: "گوشت", image: 'assets/images/test/meat.png'),
    Category(id: 3, name: "غلات", image: 'assets/images/test/grain.png'),


  ];
  static List<String> showThumbnailList = [
    "assets/images/shoe_thumb_5.png",
    "assets/images/shoe_thumb_1.png",
    "assets/images/shoe_thumb_4.png",
    "assets/images/shoe_thumb_3.png",
  ];
  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
