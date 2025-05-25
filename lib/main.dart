import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart'; // Import Provider

// Cart Model
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice => _items.fold(0, (total, current) {
    // Remove "\\$" and parse to double for price calculation
    final priceString = current.product.price
        .replaceAll('From ', '')
        .replaceAll('\\\$', '');
    return total + (double.tryParse(priceString) ?? 0) * current.quantity;
  });

  void add(Product product) {
    final existingItemIndex = _items.indexWhere(
      (item) => item.product.name == product.name,
    );
    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void remove(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }

  void decrement(Product product) {
    final existingItemIndex = _items.indexWhere(
      (item) => item.product.name == product.name,
    );
    if (existingItemIndex != -1) {
      if (_items[existingItemIndex].quantity > 1) {
        _items[existingItemIndex].quantity--;
      } else {
        _items.removeAt(existingItemIndex);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: AppleStoreCloneApp(),
    ),
  );
}

class AppleStoreCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Apple Store Clone',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme, // Apply to existing theme
        ).copyWith(
          // You can further customize specific text styles here if needed
          bodyMedium: TextStyle(color: Colors.grey[800]),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600, // Slightly less bold
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(secondary: Colors.blueAccent),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: BorderSide(color: Colors.blue, width: 1.5),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      home: MainScreen(),
      routes: {
        '/cart': (context) => CartPage(), // Add CartPage route
      },
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final String price;
  final String description; // Added description
  final List<String> specifications; // Added specifications

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.description =
        'This is a great Apple product. Experience the best of technology and design.',
    this.specifications = const [
      'Processor: Apple Silicon',
      'Display: Retina XDR',
      'Storage: Up to 2TB',
      'Connectivity: Wi-Fi 6E, Bluetooth 5.3',
    ],
  });
}

// New Tab Page for Shop
class ShopTabPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'iPhone 15 Pro',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-blue-titanium',
      price: 'From \$999',
    ),
    Product(
      name: 'MacBook Air M2',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp-spacegray-select-202206_GEO_EMEA_LANG_EN',
      price: 'From \$1099',
    ),
    Product(
      name: 'Apple Watch Series 9',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/watch-s9-select-202309_GEO_EMEA_LANG_EN',
      price: 'From \$399',
    ),
    Product(
      name: 'iPad Pro',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-pro-13-select-wifi-spacegray-202210',
      price: 'From \$799',
      description:
          'The ultimate iPad experience. Supercharged by the M2 chip. Stunning Liquid Retina XDR display.',
      specifications: [
        'Apple M2 Chip',
        'Liquid Retina XDR Display',
        'ProMotion Technology',
        'Thunderbolt / USB 4',
      ],
    ),
    Product(
      name: 'AirPods Max',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airpods-max-select-skyblue-202011',
      price: 'From \$549',
      description:
          'A perfect balance of exhilarating high-fidelity audio and the effortless magic of AirPods.',
      specifications: [
        'High-Fidelity Audio',
        'Active Noise Cancellation',
        'Spatial Audio',
        'Knit-mesh Canopy',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 16.0),
            child: Text(
              "What\'s New",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.70, // Adjusted for more content
            ),
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return ProductCard(product: products[index]);
            }, childCount: products.length),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 30),
        ), // Add some bottom padding
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children
          children: <Widget>[
            Expanded(
              flex: 3, // Give more space to image
              child: Hero(
                tag:
                    product
                        .imageUrl, // Ensure this tag is unique per product for Hero animation
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.blueGrey,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15, // Slightly adjusted
                      color: Colors.black87,
                    ),
                    maxLines: 1, // Ensure it fits well
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.price,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 10.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ), // Smaller padding for button in card
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false).add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green[600],
                    ),
                  );
                },
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Detail Page
class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Hero(
                tag: product.imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.35,
                    placeholder:
                        (context, url) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.blueGrey,
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.price,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
                height: 1.6,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Specifications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  product.specifications
                      .map(
                        (spec) => Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            '• $spec',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 24),
            // Placeholder for Reviews - Can be expanded later
            Text(
              'Reviews & Ratings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 22),
                Icon(Icons.star, color: Colors.amber, size: 22),
                Icon(Icons.star, color: Colors.amber, size: 22),
                Icon(Icons.star, color: Colors.amber, size: 22),
                Icon(Icons.star_half, color: Colors.amber, size: 22),
                SizedBox(width: 10),
                Text(
                  '4.5 (1,234 ratings)',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'No user reviews yet for this specific model. Check back later!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart!'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green[600],
                    behavior: SnackBarBehavior.floating, // More modern look
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
              child: Text('Add to Cart'),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added ${product.name} to wishlist (feature coming soon!)',
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.orange[600],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
              },
              child: Text('Add to Wishlist'),
            ),
            SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}

// Cart Page
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart (${cart.items.fold<int>(0, (sum, item) => sum + item.quantity)})',
        ),
      ),
      body:
          cart.items.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Your cart is empty.',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Looks like you haven't added anything yet.",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed:
                          () => Navigator.popUntil(
                            context,
                            ModalRoute.withName('/'),
                          ),
                      child: Text('Continue Shopping'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        final itemPrice =
                            double.tryParse(
                              item.product.price
                                  .replaceAll('From ', '')
                                  .replaceAll('\\\$', ''),
                            ) ??
                            0;
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: item.product.imageUrl,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) => Icon(
                                          Icons.error,
                                          color: Colors.grey[400],
                                        ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '\$${itemPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.redAccent,
                                            size: 22,
                                          ),
                                          onPressed:
                                              () =>
                                                  cart.decrement(item.product),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.green,
                                            size: 22,
                                          ),
                                          onPressed:
                                              () => cart.add(item.product),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '\$${(itemPrice * item.quantity).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '\$${cart.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              'Free', // Placeholder
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 24, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '\$${cart.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:
                              cart.items.isEmpty
                                  ? null
                                  : () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Checkout initiated (feature coming soon!)',
                                        ),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.orange[600],
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                          child: Text('Proceed to Checkout'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                        SizedBox(height: 8),
                        if (cart.items.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              cart.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cart cleared!'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Clear Cart',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ShopTabPage(),
    TodayTabPage(),
    SearchTabPage(), // Corrected: SearchTabPage is defined
  ];
  final List<String> _pageTitles = ['Apple Store', 'Today', 'Search'];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItemCount = Provider.of<CartModel>(
      context,
    ).items.fold<int>(0, (sum, item) => sum + item.quantity);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentIndex]),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center, // Center the badge on the icon
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 28,
                ), // Slightly larger icon
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(
                      cartItemCount > 9 ? 3 : 4,
                    ), // Adjust padding for 2 digits
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle, // Circular badge
                    ),
                    constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$cartItemCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11, // Slightly larger font for badge
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 8), // Add some spacing to the right of the cart icon
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor:
            Colors.grey[600], // Slightly darker unselected color
        selectedFontSize: 12, // Ensure selected label is visible
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront), // Different icon when active
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            activeIcon: Icon(Icons.article),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

// Today Tab Page - Enhanced Placeholder
class TodayTabPage extends StatelessWidget {
  final List<Map<String, String>> todayItems = [
    {
      'title': 'New Release: The Future is Here',
      'subtitle': 'Discover the latest groundbreaking technology from Apple.',
      'imageUrl':
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFjYm9va3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'category': 'INNOVATION SPOTLIGHT',
    },
    {
      'title': 'Creative Workshop: Master Procreate',
      'subtitle': 'Join our experts and learn to create stunning art on iPad.',
      'imageUrl':
          'https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dGVjaG5vbG9neXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'category': 'TODAY AT APPLE',
    },
    {
      'title': 'Behind the Design: Vision Pro',
      'subtitle': 'An inside look at the craftsmanship of spatial computing.',
      'imageUrl':
          'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YXBwbGUlMjB3YXRjaHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=1000&q=80', // Placeholder, ideally Vision Pro image
      'category': 'DESIGN STORY',
    },
    {
      'title': 'Pro Tips for Cinematic Mode',
      'subtitle': 'Capture stunning videos with depth of field on your iPhone.',
      'imageUrl':
          'https://images.unsplash.com/photo-1510127034890-ba27508e9f1c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGlwaG9uZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'category': 'QUICK TIP',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 12.0,
        right: 12.0,
        bottom: 24.0,
      ), // Adjusted padding
      itemCount: todayItems.length + 1, // +1 for the header
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 20.0, top: 8.0),
            child: Text(
              "Today",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          );
        }
        final item = todayItems[index - 1];
        return Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(bottom: 24.0),
          elevation: 5.0,
          shadowColor: Colors.grey.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ), // More rounded
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250, // Increased height for better visual
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: item['imageUrl']!,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueGrey,
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                          size: 60,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0), // Increased padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['category']!,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600, // Bolder category
                        fontSize: 13,
                        letterSpacing: 0.5, // Added letter spacing
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['title']!,
                      style: TextStyle(
                        fontSize: 24, // Larger title
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2, // Line height
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item['subtitle']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Search Tab Page
class SearchTabPage extends StatefulWidget {
  @override
  _SearchTabPageState createState() => _SearchTabPageState();
}

class _SearchTabPageState extends State<SearchTabPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [
    // Duplicating product list for now
    Product(
      name: 'iPhone 15 Pro',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-blue-titanium',
      price: 'From \$999',
    ),
    Product(
      name: 'MacBook Air M2',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp-spacegray-select-202206_GEO_EMEA_LANG_EN',
      price: 'From \$1099',
    ),
    Product(
      name: 'Apple Watch Series 9',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/watch-s9-select-202309_GEO_EMEA_LANG_EN',
      price: 'From \$399',
    ),
    Product(
      name: 'iPad Air',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-blue-wifi_FMT_WHH',
      price: 'From \$599',
    ),
    Product(
      name: 'AirPods Pro (2nd generation)',
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83_AV4',
      price: 'From \$249',
    ),
  ];
  List<Product> _filteredProducts = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _filterProducts();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    if (_searchQuery.isEmpty) {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts =
          _allProducts.where((product) {
            return product.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            "Search",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for products, accessories, and more',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.0,
              ), // Adjust vertical padding
            ),
          ),
        ),
        if (_searchQuery.isNotEmpty && _filteredProducts.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
                  SizedBox(height: 16),
                  Text(
                    'No results for "$_searchQuery"',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Try checking your spelling or use different keywords.',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else if (_searchQuery.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.manage_search_rounded,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Discover Apple Products',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find iPhones, Macs, Watches, and more.',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.70, // Consistent with ShopTabPage
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: _filteredProducts[index]);
              },
            ),
          ),
      ],
    );
  }
}
