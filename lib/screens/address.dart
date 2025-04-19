// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(MaterialApp(home: AddLocationPage()));
// }
//
// class AddLocationPage extends StatefulWidget {
//   @override
//   _AddLocationPageState createState() => _AddLocationPageState();
// }
//
// class _AddLocationPageState extends State<AddLocationPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController houseController = TextEditingController();
//   final TextEditingController apartmentController = TextEditingController();
//   final TextEditingController landmarkController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController pinCodeController = TextEditingController();
//
//   String selectedType = 'Work';
//   String? selectedDistrict;
//   String? selectedState = 'Tamil Nadu';
//
//   List<String> tamilNaduDistricts = [
//     "Ariyalur", "Chengalpattu", "Chennai", "Coimbatore", "Cuddalore",
//     "Dharmapuri", "Dindigul", "Erode", "Kallakurichi", "Kancheepuram",
//     "Karur", "Krishnagiri", "Madurai", "Mayiladuthurai", "Nagapattinam",
//     "Namakkal", "Nilgiris", "Perambalur", "Pudukkottai", "Ramanathapuram",
//     "Ranipet", "Salem", "Sivaganga", "Tenkasi", "Thanjavur", "Theni",
//     "Thoothukudi", "Tiruchirappalli", "Tirunelveli", "Tirupathur",
//     "Tiruppur", "Tiruvallur", "Tiruvannamalai", "Tiruvarur", "Vellore",
//     "Viluppuram", "Virudhunagar"
//   ];
//
//   List<String> tamilNaduStates = ["Tamil Nadu"];
//
//   bool isFormFilled() {
//     return houseController.text.isNotEmpty &&
//         apartmentController.text.isNotEmpty &&
//         landmarkController.text.isNotEmpty &&
//         cityController.text.isNotEmpty &&
//         pinCodeController.text.length == 6 &&
//         selectedDistrict != null &&
//         selectedState != null;
//   }
//
//   void checkForm() {
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     houseController.addListener(checkForm);
//     apartmentController.addListener(checkForm);
//     landmarkController.addListener(checkForm);
//     cityController.addListener(checkForm);
//     pinCodeController.addListener(checkForm);
//   }
//
//   @override
//   void dispose() {
//     houseController.dispose();
//     apartmentController.dispose();
//     landmarkController.dispose();
//     cityController.dispose();
//     pinCodeController.dispose();
//     super.dispose();
//   }
//
//   Widget buildTypeButton(String type) {
//     final bool isSelected = selectedType == type;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedType = type;
//           });
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           margin: EdgeInsets.symmetric(horizontal: 5),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Center(
//             child: Text(
//               type,
//               style: TextStyle(
//                 color: isSelected ? Colors.black : Colors.grey.shade700,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("$label*", style: TextStyle(fontWeight: FontWeight.w500)),
//         SizedBox(height: 5),
//         TextFormField(
//           controller: controller,
//           keyboardType: label == "Pin Code" ? TextInputType.number : TextInputType.text,
//           inputFormatters: label == "Pin Code"
//               ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)]
//               : [],
//           decoration: InputDecoration(
//             hintText: label,
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) return 'Required';
//             if (label == "Pin Code" && value.length != 6) return 'Must be 6 digits';
//             return null;
//           },
//         ),
//         SizedBox(height: 15),
//       ],
//     );
//   }
//
//   Widget buildDropdownField(String label, String? selectedValue, List<String> options, Function(String?) onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("$label*", style: TextStyle(fontWeight: FontWeight.w500)),
//         SizedBox(height: 5),
//         DropdownButtonFormField<String>(
//           value: selectedValue,
//           items: options.map((item) {
//             return DropdownMenuItem<String>(value: item, child: Text(item));
//           }).toList(),
//           onChanged: (value) {
//             onChanged(value);
//             checkForm();
//           },
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//           ),
//           validator: (value) => value == null || value.isEmpty ? 'Required' : null,
//         ),
//         SizedBox(height: 15),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE3F2D3),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Icon(Icons.arrow_back_ios, color: Colors.black),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           "Add location",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Opacity(
//                       opacity: 0,
//                       child: Icon(Icons.arrow_back_ios),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     buildTypeButton('Work'),
//                     buildTypeButton('House'),
//                     buildTypeButton('Other'),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 buildTextField("House /plot no", houseController),
//                 buildTextField("Apartment (or) Road", apartmentController),
//                 buildTextField("Land mark", landmarkController),
//                 buildTextField("City", cityController),
//                 buildTextField("Pin Code", pinCodeController),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: buildDropdownField(
//                           "District", selectedDistrict, tamilNaduDistricts,
//                               (value) => setState(() => selectedDistrict = value)),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: buildDropdownField(
//                           "State", selectedState, tamilNaduStates,
//                               (value) => setState(() => selectedState = value)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: isFormFilled()
//                         ? Colors.yellow
//                         : Colors.grey.shade300,
//                     foregroundColor: Colors.black,
//                     minimumSize: Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: isFormFilled()
//                       ? () {
//                     if (_formKey.currentState!.validate()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Address Saved!')),
//                       );
//                     }
//                   }
//                       : null,
//                   child: Text(
//                     "Save address",
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
