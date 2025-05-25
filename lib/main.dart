import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(AppleStoreCloneApp());
}

class AppleStoreCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Store Clone',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.sfProTextTheme(), // خط يشبه Apple
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: StorePage(),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final String price;

  Product({required this.name, required this.imageUrl, required this.price});
}

class StorePage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'iPhone 15 Pro',
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-blue-titanium',
      price: 'From \$999',
    ),
    Product(
      name: 'MacBook Air M2',
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp-spacegray-select-202206_GEO_EMEA_LANG_EN',
      price: 'From \$1099',
    ),
    Product(
      name: 'Apple Watch Series 9',
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/watch-s9-select-202309_GEO_EMEA_LANG_EN',
      price: 'From \$399',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 0.3,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(strokeWidth: 2),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              title: Text(product.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(product.price),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // مكان التنقل لصفحة التفاصيل
              },
            ),
          );
        },
      ),
    );
  }
}
