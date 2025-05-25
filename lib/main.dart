import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Updated color scheme
        scaffoldBackgroundColor: Colors.white, // Set background color
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
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
      imageUrl: 'https://images.unsplash.com/photo-1512499617640-c2f9992f0d8b',
    ),
    Product(
      name: 'Keyboard',
      price: 30.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Mouse',
      price: 20.0,
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3',
    ),
    Product(
      name: 'Monitor',
      price: 150.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Laptop',
      price: 800.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Smartphone',
      price: 600.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Tablet',
      price: 300.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Smartwatch',
      price: 200.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Charger',
      price: 15.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'USB Cable',
      price: 10.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Power Bank',
      price: 25.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Bluetooth Speaker',
      price: 70.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'External Hard Drive',
      price: 100.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Webcam',
      price: 40.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Microphone',
      price: 60.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Graphics Card',
      price: 400.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Motherboard',
      price: 200.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'RAM',
      price: 80.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'SSD',
      price: 120.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'HDD',
      price: 60.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Router',
      price: 50.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Modem',
      price: 40.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Printer',
      price: 150.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Scanner',
      price: 100.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
    Product(
      name: 'Fax Machine',
      price: 200.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
    ),
  ];

  List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("electronics Store"),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CartScreen(cart: cart),
                    ),
                  );
                },
              ),
              if (cart.isEmpty)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    cart.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Image.network(product.imageUrl, height: 100, fit: BoxFit.cover),
                SizedBox(height: 8),
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${product.price} USD',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Spacer(),
                ElevatedButton.icon(
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text('Add to cart'),
                  onPressed: () => addToCart(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Product> cart;

  const CartScreen({required this.cart, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cart'),
        trailing: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
      child: SafeArea(
        child:
            cart.isEmpty
                ? Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final product = cart[index];
                    return CupertinoListTile(
                      leading: Image.network(
                        product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text(
                        '${product.price} USD',
                        style: TextStyle(color: CupertinoColors.systemGrey),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          // Add remove logic here
                        },
                        child: Icon(
                          CupertinoIcons.delete,
                          color: CupertinoColors.destructiveRed,
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
