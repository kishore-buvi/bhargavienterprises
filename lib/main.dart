import 'package:bhargavi_oil_masala/firebase_options.dart';
import 'package:bhargavi_oil_masala/screens/add_address.dart';
import 'package:bhargavi_oil_masala/screens/address.dart';
import 'package:bhargavi_oil_masala/screens/contact.dart';
import 'package:bhargavi_oil_masala/screens/edit_address.dart';
import 'package:bhargavi_oil_masala/screens/edit_profile.dart';
import 'package:bhargavi_oil_masala/screens/getstart_page.dart';
import 'package:bhargavi_oil_masala/screens/login_page.dart';
import 'package:bhargavi_oil_masala/screens/private%20policy.dart';
import 'package:bhargavi_oil_masala/screens/profile.dart';
import 'package:bhargavi_oil_masala/screens/refund.dart';
import 'package:bhargavi_oil_masala/screens/terms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bhargavi_oil_masala/app.dart';


Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: EditProfileApp()));
}