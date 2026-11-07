import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'favourite_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();


  final List<Map<String, dynamic>> products = [
    {
      "name": "Fresh Peach",
      "price": "4.00",
      "image": "https://draxe.com/wp-content/uploads/2016/08/DrAxePeachThumbnail.jpg",
      "rating": 4.6,
      "reviews": 120,
      "nutrition": "Rich in Vitamin A, Vitamin C, potassium and fiber.",
      "description": "Fresh peaches that are juicy and sweet, perfect for snacks and desserts."
    },
    {
      "name": "Avocado",
      "price": "5.20",
      "image": "https://m.media-amazon.com/images/I/61BrLo55FrL._AC_UF1000,1000_QL80_.jpg",
      "rating": 4.8,
      "reviews": 200,
      "nutrition": "High in healthy fats, fiber, and potassium.",
      "description": "Creamy avocados great for salads, sandwiches, and guacamole."
    },
    {
      "name": "Pineapple",
      "price": "3.80",
      "image": "https://m.media-amazon.com/images/I/81XA2GQIPOL._AC_UF894,1000_QL80_.jpg",
      "rating": 4.5,
      "reviews": 155,
      "nutrition": "Contains Vitamin C, antioxidants, manganese, and enzymes.",
      "description": "Sweet and tangy pineapples that boost digestion and immunity."
    },
    {"name": "Black Grapes", "price": "\$2.90", "image": "https://mydiagnostics.in/cdn/shop/articles/img-1745906823139_1200x.jpg?v=1754893048"},
    {"name": "Banana", "price": "\$2.90", "image": "https://m.media-amazon.com/images/I/51ebZJ+DR4L._AC_UF1000,1000_QL80_.jpg"},
    {"name": "Tomato", "price": "\$1.90", "image": "https://bio-basket.com/cdn/shop/files/organic-cherry-tomato-1000x1000.webp?v=1697542743"},
    {"name": "Onion", "price": "\$2.50", "image": "https://samsgardenstore.com/cdn/shop/files/OnionRedSeeds_Desi_b8496f89-a62d-44e5-9481-5c60b24ca696.webp?v=1726217577"},
    {"name": "Carrot", "price": "\$2.00", "image": "https://exat8rt6fi5.exactdn.com/wp-content/uploads/2022/05/carrot-01.jpg?strip=all"},
    {"name": "sprite 500ml", "price": "\$0.45", "image": "https://m.media-amazon.com/images/I/71doy6em4jL._AC_UF894,1000_QL80_.jpg"},
    {"name": "Fanta 1litre", "price": "\$1.00", "image": "https://5.imimg.com/data5/SELLER/Default/2023/1/UK/XU/PO/69519039/1-5l-fanta-carbonated-drink-500x500.png"},
    {"name": "Baby Gift Box", "price": "\$10.00", "image": "https://m.media-amazon.com/images/I/81I6Op0JhjL.jpg"},
    {"name": "Baby Cradle", "price": "\$45.50", "image": "https://www.menmoms.in/cdn/shop/files/Sweet-Love-Baby-Cradle-2a.jpg?v=1746254132"},
    {"name": "Groundnut oil", "price": "\$1.50", "image": "https://freshmilloils.com/cdn/shop/files/Untitleddesign.zip-13.jpg?v=1735904207"},
    {"name": "Sunflower Oil", "price": "\$2.00", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqSNsbNVTTAB0ujCpv5xXKBI1mAamqeyBw2Q&s"},
    {"name": "Broom stick", "price": "\$1.50", "image": "https://www.milton.in/cdn/shop/files/ZERO_DUST_BROOM_1.jpg?v=1740552795&width=1000"},
    {"name": "Dustbin", "price": "\$6.50", "image": "https://oprsteel.com/cdn/shop/files/8.jpg?v=1748514912&width=1946"},
  ];

  final List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> favouriteItems = [];

  int _selectedIndex = 0;

  double _parsePrice(String priceStr) {
    try {
      return double.parse(priceStr.replaceAll('\$', '').trim());
    } catch (e) {
      return 0.0;
    }
  }

  void addToCartFromProduct(Map<String, dynamic> product) {
    final name = product['name'];
    final image = product['image'];
    final double price = _parsePrice(product['price']);

    final int index = cartItems.indexWhere((e) => e['name'] == name);

    setState(() {
      if (index >= 0) {
        cartItems[index]['qty']++;
      } else {
        cartItems.add({
          'name': name,
          'price': price,
          'image': image,
          'qty': 1,
          'unit': '1 pcs',
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name added to cart')),
    );
  }

  /// Show product popup dialog with image, name, price and Add to cart button.
  void showProductPopup(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(product['image'], height: 140, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 12),
                  Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(product['price'], style: const TextStyle(color: Colors.green, fontSize: 16)),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          addToCartFromProduct(product);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("Add to cart"),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Close"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Search -> find first matching product, scroll to it and show popup
  void scrollToProduct(String query) {
    if (query.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter search text")));
      return;
    }

    final index = products.indexWhere((p) => p['name'].toString().toLowerCase().contains(query.toLowerCase()));
    if (index >= 0) {
      final product = products[index];
      // show popup
      showProductPopup(product);

      // also scroll grid so the item is visible
      double rowHeight = 220.0;
      int rowIndex = index ~/ 2;
      _scrollController.animateTo(
        rowIndex * rowHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item not found")));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: "Search keywords...",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Colors.grey),
                        onPressed: () => scrollToProduct(_searchController.text),
                      ),
                    ),
                    onSubmitted: (value) => scrollToProduct(value),
                  ),
                ),
              ),

              // Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "https://olivesfordinner.com/wp-content/uploads/2024/01/Produce-guide-fruits-and-vegetables-1.jpg",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Categories header + see all
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryPage())),
                        child: const Icon(Icons.arrow_forward_ios, size: 18)),
                  ],
                ),
              ),

              // horizontal categories row
              SizedBox(
                height: 95,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryTile(Icons.eco, "Vegetables"),
                    CategoryTile(Icons.local_florist, "Fruits"),
                    CategoryTile(Icons.local_drink, "Beverages"),
                    CategoryTile(Icons.store, "Grocery"),
                    CategoryTile(Icons.cookie, "Edible Oil"),
                    CategoryTile(Icons.cleaning_services, "Household"),
                    CategoryTile(Icons.child_care, "Babycare"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Featured products header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Featured Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),

              const SizedBox(height: 10),

              // Product grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return productCard(p);
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // bottom nav
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FavouritePage(favourites: favouriteItems)));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage(cartItems: cartItems)));
          } else if (index == 0) {
            // scroll to top
            _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Profile"),
        ],
      ),
    );
  }

  Widget productCard(Map<String, dynamic> product) {
    final bool isFav = favouriteItems.any((e) => e['name'] == product['name']);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.network(product['image'], height: 80),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFav) {
                        favouriteItems.removeWhere((item) => item['name'] == product['name']);
                      } else {
                        favouriteItems.add(product);
                      }
                    });
                  },
                  child: Icon(Icons.favorite, color: isFav ? Colors.red : Colors.grey),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Center(child: Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold))),
          Center(child: Text(product['price'], style: const TextStyle(color: Colors.green, fontSize: 16))),
          const SizedBox(height: 10),

          Center(
            child: ElevatedButton(
              onPressed: () => addToCartFromProduct(product),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text("Add to cart"),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small category tile used in horizontal list
class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryTile(this.icon, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.green.shade50,
            child: Icon(icon, size: 28, color: Colors.green),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
