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
        textTheme: GoogleFonts.robotoTextTheme(), // استخدام خط Roboto كبديل
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
      home: MainScreen(),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final String price;

  Product({required this.name, required this.imageUrl, required this.price});
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
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 16.0, // Horizontal space between cards
              mainAxisSpacing: 16.0, // Vertical space between cards
              childAspectRatio: 0.75, // Aspect ratio of the cards
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ProductCard(product: products[index]);
              },
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias, // Important for rounded corners on image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(strokeWidth: 2)),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 36), // Full width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                )
              ),
              onPressed: () {
                // Navigate to product detail page
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)));
                /* ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on ${product.name}')),
                );*/
              },
              child: Text('View Details', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
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
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Hero(
                tag: product.imageUrl, // Unique tag for Hero animation
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.contain, // Use contain to see the whole image
                    height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.price,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey[800]),
            ),
            SizedBox(height: 16),
            Text(
              'Description', // Placeholder for description section title
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Discover the amazing features of ${product.name}. This product combines cutting-edge technology with elegant design, offering an unparalleled user experience. Whether for work or play, ${product.name} is built to perform. Explore its capabilities and see how it can enhance your daily life. More details on specific components and software integrations will be provided below.', // Enhanced placeholder description
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700], height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              'Specifications', 
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Placeholder for Specifications - you can use a ListView or Column of Text widgets
            Text('Processor: High-Performance Chipset', style: Theme.of(context).textTheme.bodyMedium),
            Text('RAM: 8GB/16GB Options', style: Theme.of(context).textTheme.bodyMedium),
            Text('Storage: 256GB/512GB/1TB SSD', style: Theme.of(context).textTheme.bodyMedium),
            Text('Display: Retina XDR Display', style: Theme.of(context).textTheme.bodyMedium),
            Text('Battery: All-day battery life', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 20),
            Text(
              'Reviews & Ratings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Placeholder for Reviews
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star_half, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Text('4.5 (1,234 ratings)', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            SizedBox(height: 8),
            Text('No reviews yet. Be the first to review ${product.name}!', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey[600])),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50), // Full width button, taller
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              onPressed: () {
                // Add to cart functionality to be implemented
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart (not really!)')),
                );
              },
              child: Text('Add to Cart', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            OutlinedButton(
               style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.blue, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)
              ),
              onPressed: () {
                // Add to wishlist or other secondary action
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added ${product.name} to wishlist (not really!)')),
                );
              },
              child: Text('Add to Wishlist', style: TextStyle(color: Colors.blue)),
            )
          ],
        ),
      ),
    );
  }
}

// Placeholder Tab Page for Today
class TodayTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Today Page - Coming Soon!'),
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
  List<Product> _allProducts = [ // Duplicating product list for now
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
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/ipad-air-finish-select-gallery-202211-blue-wifi_FMT_WHH',
      price: 'From \$599',
    ),
    Product(
      name: 'AirPods Pro (2nd generation)',
      imageUrl: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83_AV4',
      price: 'From \$249',
    ),
  ];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        Expanded(
          child: _filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    _searchController.text.isEmpty
                        ? 'Search for your favorite Apple products.'
                        : 'No products found for "${_searchController.text}".',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
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

// Main Screen with Bottom Navigation Bar
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ShopTabPage(),
    TodayTabPage(),
    SearchTabPage(),
  ];
  final List<String> _pageTitles = [
    'Shop',
    'Today',
    'Search',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentIndex]),
        centerTitle: true, // Apple-like centered title
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Theme.of(context).primaryColor, // Or Colors.blue for Apple's blue
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article), // Icon for "Today" or "Feed"
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
