// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// void main() {
//   runApp(const ProductReviewApp());
// }
//
// class ProductReviewApp extends StatelessWidget {
//   const ProductReviewApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ProductReviewScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class ProductReviewScreen extends StatefulWidget {
//   const ProductReviewScreen({super.key});
//
//   @override
//   State<ProductReviewScreen> createState() => _ProductReviewScreenState();
// }
//
// class _ProductReviewScreenState extends State<ProductReviewScreen> {
//   double _rating = 0;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _reviewController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//
//   bool _isFormValid = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _titleController.addListener(_checkFormValidity);
//     _reviewController.addListener(_checkFormValidity);
//     _usernameController.addListener(_checkFormValidity);
//     _emailController.addListener(_checkFormValidity);
//   }
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _reviewController.dispose();
//     _usernameController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }
//
//   void _checkFormValidity() {
//     setState(() {
//       _isFormValid = _titleController.text.trim().isNotEmpty &&
//           _reviewController.text.trim().isNotEmpty &&
//           _usernameController.text.trim().isNotEmpty &&
//           _emailController.text.trim().isNotEmpty &&
//           _emailController.text.contains("@gmail.com") &&
//           _rating > 0;
//     });
//   }
//
//   bool _isGmail(String email) {
//     final regex = RegExp(r'^[\w-\.]+@gmail\.com$');
//     return regex.hasMatch(email);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header
//             Container(
//               color: Colors.green[200],
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(Icons.arrow_back_ios_new, size: 20),
//                   ),
//                   const Text(
//                     "product Review",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const Opacity(
//                     opacity: 0.0,
//                     child: Icon(Icons.arrow_back_ios_new),
//                   ),
//                 ],
//               ),
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Cancel and Post
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Cancel"),
//                           ElevatedButton(
//                             onPressed: _isFormValid
//                                 ? () {
//                               if (_formKey.currentState!.validate()) {
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(const SnackBar(
//                                     content:
//                                     Text("Review posted!")));
//                               }
//                             }
//                                 : null,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                               _isFormValid ? Colors.white : Colors.grey,
//                               foregroundColor:
//                               _isFormValid ? Colors.blue : Colors.white,
//                               side: BorderSide(
//                                   color: _isFormValid
//                                       ? Colors.blue
//                                       : Colors.transparent),
//                             ),
//                             child: const Text("Post"),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//
//                       const Text("Score:"),
//                       const SizedBox(height: 8),
//
//                       // Rating
//                       RatingBar.builder(
//                         initialRating: _rating,
//                         minRating: 1,
//                         allowHalfRating: false,
//                         itemCount: 5,
//                         itemSize: 30,
//                         itemPadding:
//                         const EdgeInsets.symmetric(horizontal: 4.0),
//                         itemBuilder: (context, _) => const Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         ),
//                         onRatingUpdate: (rating) {
//                           setState(() {
//                             _rating = rating;
//                           });
//                           _checkFormValidity();
//                         },
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Title
//                       TextFormField(
//                         controller: _titleController,
//                         decoration: const InputDecoration(
//                           hintText: "Title",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Title is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Review
//                       const Text("Review:"),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: _reviewController,
//                         maxLines: 6,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Review is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Username
//                       const Text("*Username:"),
//                       const SizedBox(height: 4),
//                       TextFormField(
//                         controller: _usernameController,
//                         decoration: const InputDecoration(
//                           hintText: "Value",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Username is required';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Email
//                       const Text("*Email:"),
//                       const SizedBox(height: 4),
//                       TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: const InputDecoration(
//                           hintText: "example@gmail.com",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return 'Email is required';
//                           } else if (!_isGmail(value.trim())) {
//                             return 'Enter a valid Gmail address';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
