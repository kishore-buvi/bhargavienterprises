import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MasalaScreen extends StatefulWidget {
  @override
  _MasalaScreenState createState() => _MasalaScreenState();
}

class _MasalaScreenState extends State<MasalaScreen> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    final ref = FirebaseStorage.instance.ref('products/masalas');
    final result = await ref.listAll();

    final urls = await Future.wait(
      result.items.map((item) => item.getDownloadURL()),
    );

    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authentic Masalas")),
      body: imageUrls.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: imageUrls.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrls[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
