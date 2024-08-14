class Products {
  final String productName;
  final List<String> productImagePath;
  bool isFavourite = false;
  final double price;
  final String description;

  Products(
      {required this.productName,
      required this.productImagePath,
      required this.price,
      required this.description});
}

List<Products> products = [
  Products(
      productName: 'SmartPhone',
      productImagePath: [
        'assets/images/mobile1.jpg',
        'assets/images/mobile2.jpg',
        'assets/images/mobile3.jpeg'
      ],
      price: 13000,
      description:
          'Elevate your experience with a stunning 6.7-inch Super AMOLED display, a powerful processor Name for seamless multitasking, and a versatile 108MP triple-camera system for capturing every detail. Stay connected and productive with 5G support and a long-lasting 5000mAh battery.'),
  Products(
      productName: 'Television',
      productImagePath: [
        'assets/images/tv1.jpeg',
        'assets/images/tv2.jpg',
        'assets/images/tv3.jpg'
      ],
      price: 23000,
      description:
          'Immerse yourself in breathtaking visuals with a 55-inch 4K UHD display, enhanced by HDR for vibrant colors and deep contrasts. Enjoy smooth, lag-free streaming with a powerful processor and smart TV capabilities. Transform your living room into a home theater with crystal-clear Dolby Audio.'),
  Products(
      productName: 'Laptop',
      productImagePath: [
        'assets/images/laptop1.jpg',
        'assets/images/laptop2.jpeg',
        'assets/images/laptop3.jpg'
      ],
      price: 130000,
      description:
          'Power through tasks with the latest processor and 16GB RAM, offering seamless multitasking and rapid performance. Enjoy stunning visuals on a 15.6-inch Full HD display, perfect for work or entertainment. Stay productive on the go with all-day battery life and a lightweight, sleek design.'),
  Products(
      productName: 'Speaker',
      productImagePath: [
        'assets/images/speaker1.jpg',
        'assets/images/speaker2.jpg',
        'assets/images/speaker3.jpeg'
      ],
      price: 1300,
      description:
          'Experience rich, immersive sound with powerful bass in a compact design. Enjoy wireless freedom with Bluetooth connectivity and up to 12 hours of playtime on a single charge. Perfect for any setting, from parties to personal listening.'),
];
