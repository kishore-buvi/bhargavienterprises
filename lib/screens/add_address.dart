// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: AddressScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
//
// class AddressScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE8F9E4), // light green
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Back button and title
//             Positioned(
//               top: 10,
//               left: 10,
//               right: 10,
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Icon(CupertinoIcons.back, size: 24),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Text(
//                         'Address',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 24), // Spacer for symmetry
//                 ],
//               ),
//             ),
//
//             // Add Address Button
//             Positioned(
//               bottom: 20,
//               left: 10,
//               right: 10,
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add your navigation or function here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber[300], // yellow color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: Text(
//                     'Add address',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                     ),
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
