// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() => runApp(EditProfileApp());
//
// class EditProfileApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EditProfileScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class EditProfileScreen extends StatefulWidget {
//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   bool isValid = false;
//
//   void _validateForm() {
//     final valid = _formKey.currentState?.validate() ?? false;
//     setState(() {
//       isValid = valid;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController.addListener(_validateForm);
//     _emailController.addListener(_validateForm);
//     _phoneController.addListener(_validateForm);
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: screenHeight * 0.25,
//               width: double.infinity,
//               color: Colors.green[800],
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 10),
//                   Text(
//                     "Edit Profile",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   CircleAvatar(
//                     backgroundColor: Colors.grey[300],
//                     radius: 30,
//                     child: Text(
//                       "L",
//                       style: TextStyle(
//                         fontSize: 30,
//                         color: Colors.green[800],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 onChanged: _validateForm,
//                 child: Column(
//                   children: [
//                     _buildTextField(
//                       controller: _nameController,
//                       label: "Name*",
//                       hint: "Name",
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Name is required";
//                         }
//                         final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
//                         return nameRegex.hasMatch(value)
//                             ? null
//                             : "Only letters allowed";
//                       },
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(
//                           RegExp(r"[a-zA-Z\s]"),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _emailController,
//                       label: "Email*",
//                       hint: "Email",
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Email is required";
//                         }
//                         final emailRegex =
//                         RegExp(r'^[^@]+@[^@]+\.[^@]+');
//                         return emailRegex.hasMatch(value)
//                             ? null
//                             : "Enter a valid email";
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _phoneController,
//                       label: "Phone Number*",
//                       hint: "Number",
//                       keyboardType: TextInputType.number,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly
//                       ],
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Phone number is required";
//                         }
//                         if (value.length != 10) {
//                           return "Enter a valid 10-digit number";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: isValid
//                             ? () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("Profile Submitted"),
//                             ),
//                           );
//                         }
//                             : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.amber,
//                           foregroundColor: Colors.black,
//                         ),
//                         child: const Text("Submit"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required FormFieldValidator<String> validator,
//     TextInputType keyboardType = TextInputType.text,
//     List<TextInputFormatter>? inputFormatters,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       inputFormatters: inputFormatters,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         contentPadding:
//         const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       validator: validator,
//     );
//   }
// }
