import 'package:bhargavi_oil_masala/screens/interface.dart';
import 'package:bhargavi_oil_masala/screens/my_profile.dart';
import 'package:bhargavi_oil_masala/screens/profile.dart';
import 'package:bhargavi_oil_masala/screens/rating_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bhargavi_oil_masala/firebase_options.dart';
import 'package:bhargavi_oil_masala/screens/getstart_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: HomePage()));
}

class BhargaviApp extends StatefulWidget {
  @override
  State<BhargaviApp> createState() => _BhargaviAppState();
}

class _BhargaviAppState extends State<BhargaviApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OilCategoryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class OilCategoryScreen extends StatefulWidget {
  @override
  State<OilCategoryScreen> createState() => _OilCategoryScreenState();
}

class _OilCategoryScreenState extends State<OilCategoryScreen> {
  int _selectedIndex = 0;

  List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.person,
    Icons.shopping_cart,
  ];

  final List<String> carouselImages = [
    'assets/images/istockphoto-958887938-612x612.jpg',
    'assets/images/istockphoto-958887938-612x612.jpg',
    'assets/images/istockphoto-958887938-612x612.jpg',
  ];

  final List<Map<String, String>> products = [
    {
      'name': 'Cold Pressed Virgin Groundnut Oil',
      'price': '₹320',
      'image': 'assets/images/istockphoto-958887938-612x612.jpg',
      'discount': '10%',
    },
    {
      'name': 'Cold Pressed Virgin Groundnut Oil',
      'price': '₹320',
      'image': 'assets/images/istockphoto-958887938-612x612.jpg',
      'discount': '10%',
    },
    {
      'name': 'Gram Masala',
      'price': '₹230',
      'image': 'assets/images/istockphoto-958887938-612x612.jpg',
      'discount': '10%',
    },
    {
      'name': 'Gram Masala',
      'price': '₹230',
      'image': 'assets/images/istockphoto-958887938-612x612.jpg',
      'discount': '10%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4FFF3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/logo.png'), // Add image path here
            ),
            SizedBox(width: 8),
            Text(
              'Bhargavi Enterprises',
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            _buildTag('OIL', Colors.orange[100]!),
            SizedBox(width: 8),
            _buildTag('Marathi', Colors.yellow[100]!),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.filter_list),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            CarouselSlider(
              options: CarouselOptions(
                height: 160.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: carouselImages.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(product);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildCurvedBottomBar() {
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF256029),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: icons
                  .asMap()
                  .entries
                  .map((entry) {
                int index = entry.key;
                IconData icon = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    child: Icon(
                      icon,
                      color: index == _selectedIndex
                          ? Colors.transparent
                          : Colors.amber,
                      size: 28,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          AnimatedAlign(
            alignment: _getAlignment(),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icons[_selectedIndex],
                  color: Colors.amber,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Alignment _getAlignment() {
    switch (_selectedIndex) {
      case 0:
        return Alignment(-0.9, 1.0);
      case 1:
        return Alignment(-0.3, 1.0);
      case 2:
        return Alignment(0.3, 1.0);
      case 3:
        return Alignment(0.9, 1.0);
      default:
        return Alignment(-0.9, 1.0);
    }
  }


  Widget _buildTag(String text, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OilDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    product['image']!,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite_border),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product['discount']!,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    product['price']!,
                    style: TextStyle(
                      color: Colors.orange[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class OilDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  OilDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF256029),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image with round container
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(product['image']!),
                  ),
                  SizedBox(height: 16),
                  Text(
                    product['name']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Icon(Icons.star_half, color: Colors.orange, size: 18),
                      Icon(Icons.star_border, color: Colors.orange, size: 18),
                      SizedBox(width: 8),
                      Text("3.5 Rating"),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    product['price']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${product['discount']} Offer",
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _iconFeature(Icons.local_shipping, "Fast delivery"),
                      _iconFeature(Icons.eco, "100% Natural"),
                      _iconFeature(Icons.verified, "Quality Assurance"),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      minimumSize: Size(200, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("ADD TO CART"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Buy now",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // Product details
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  _productDetailRow("Brand", "Bhargavi"),
                  _productDetailRow("Type", "Pure Cold Pressed Groundnut Oil"),
                  _productDetailRow("Container Type", "Plastic Bottle, Dispenser, Tin"),
                  _productDetailRow("Ingredients", "Groundnut Oil"),
                  _productDetailRow("Shelf Life", "12 Months"),
                ],
              ),
            ),

            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _iconFeature(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _productDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(title, style: TextStyle(color: Colors.black54)),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

// Paste this at the end of your Dart file (or create a separate one)
class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  final List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.person,
    Icons.shopping_cart,
  ];

  Alignment _getAlignment() {
    switch (_selectedIndex) {
      case 0:
        return Alignment(-1.0, 1.0);
      case 1:
        return Alignment(-0.33, 1.0);
      case 2:
        return Alignment(0.33, 1.0);
      case 3:
        return Alignment(1.0, 1.0);
      default:
        return Alignment(-1.0, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipPath(
            clipper: CurvedNavClipper(),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF256029),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: icons.asMap().entries.map((entry) {
                  int index = entry.key;
                  IconData icon = entry.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        color: index == _selectedIndex
                            ? Colors.transparent
                            : Colors.amber,
                        size: 28,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          AnimatedAlign(
            alignment: _getAlignment(),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icons[_selectedIndex],
                  color: Colors.amber,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double centerWidth = size.width / 2;
    double radius = 40;

    final path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height - 20)
      ..quadraticBezierTo(
        size.width * 0.05, size.height,
        size.width * 0.15, size.height,
      )
      ..lineTo(centerWidth - radius - 10, size.height)
      ..quadraticBezierTo(
        centerWidth - radius, size.height,
        centerWidth - radius + 10, size.height - 10,
      )
      ..arcToPoint(
        Offset(centerWidth + radius - 10, size.height - 10),
        radius: Radius.circular(40),
        clockwise: false,
      )
      ..quadraticBezierTo(
        centerWidth + radius, size.height,
        centerWidth + radius + 10, size.height,
      )
      ..lineTo(size.width * 0.85, size.height)
      ..quadraticBezierTo(
        size.width * 0.95, size.height,
        size.width, size.height - 20,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
