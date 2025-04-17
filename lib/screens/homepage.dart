import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6f5e6),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 16),
                ClipOval(
                  child: Container(
                    color: Colors.white, // Optional: background behind the logo
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Bhargavi Enterprices",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _CategoryCard(
                    buttonText: 'Original oils',
                    image: 'assets/images/organicoilselect.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(category: 'Oil'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  _CategoryCard(
                    buttonText: 'Home made masala',
                    image: 'assets/images/organicmasalaselect.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(category: 'Masala'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String buttonText, image;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.buttonText,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Make the category cards slightly responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth < 600 ? screenWidth * 0.4 : 160;  // Dynamic width for smaller screens
    double cardHeight = screenWidth < 600 ? 200 : 220;  // Dynamic height for smaller screens

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)], // Green gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFFFC107), // Amber yellow
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Product Screen ------------------------

class ProductScreen extends StatelessWidget {
  final String category;

  const ProductScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6f5e6),
      appBar: AppBar(
        title: Text(category == 'Oil' ? 'Finest Oils' : 'Authentic Masalas'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Product>>(
        future: FirebaseService.fetchProducts(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          final products = snapshot.data!;

          // Responsive grid view: 1 column for small screens, 2 columns for larger screens
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        },
      ),
    );
  }
}

// ------------------- Product Model ------------------------

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double discount;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.discount,
  });

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      discount: (data['discount'] ?? 0).toDouble(),
    );
  }
}

// ------------------- Firebase Service ------------------------

class FirebaseService {
  static Future<List<Product>> fetchProducts(String category) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(category.toLowerCase()) // 'oil' or 'masala'
        .get();

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList();
  }
}

// ------------------- Product Card ------------------------

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text("₹${product.price}", style: const TextStyle(fontSize: 14)),
                const Spacer(),
                if (product.discount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "-${product.discount.toStringAsFixed(0)}%",
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
