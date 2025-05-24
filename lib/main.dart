import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [
    Product(
      name: "Headphones",
      price: 50.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Keyboard',
      price: 30.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Mouse',
      price: 20.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Monitor',
      price: 150.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Laptop',
      price: 800.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Smartphone',
      price: 600.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Tablet',
      price: 300.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Smartwatch',
      price: 200.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Charger',
      price: 15.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'USB Cable',
      price: 10.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Power Bank',
      price: 25.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Bluetooth Speaker',
      price: 70.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'External Hard Drive',
      price: 100.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Webcam',
      price: 40.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Microphone',
      price: 60.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Graphics Card',
      price: 400.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Motherboard',
      price: 200.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'RAM',
      price: 80.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'SSD',
      price: 120.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'HDD',
      price: 60.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Router',
      price: 50.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Modem',
      price: 40.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Printer',
      price: 150.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Scanner',
      price: 100.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Fax Machine',
      price: 200.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
        
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
