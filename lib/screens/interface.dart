import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhargavi Enterprises',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedToggle = 'OIL';
  int _current = 0;

  final List<String> imageList = [
    'assets/images/logimage.png',
    'assets/images/organicoilselect.png',
    'assets/images/images.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xDFF1FAE7),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.local_florist, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Bhargavi Enterprises',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      ToggleButtons(
                        isSelected: [selectedToggle == 'OIL', selectedToggle == 'Masala'],
                        onPressed: (int index) {
                          setState(() {
                            selectedToggle = index == 0 ? 'OIL' : 'Masala';
                          });
                        },
                        borderRadius: BorderRadius.circular(30),
                        selectedColor: Colors.white,
                        fillColor: Colors.green,
                        color: Colors.black,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('OIL'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('Masala'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Search Bar with Filter Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.tune, color: Colors.amber[700], size: 28),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Filter clicked')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Carousel Slider
                const SizedBox(height: 10),
                CarouselSlider(
                  options: CarouselOptions(
                    height: constraints.maxHeight * 0.4,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: imageList.map((item) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(item),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // Indicator Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.asMap().entries.map((entry) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key ? Colors.orange : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
