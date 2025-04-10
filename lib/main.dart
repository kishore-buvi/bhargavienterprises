import 'package:bhargavi_oil_masala/firebase_options.dart';
import 'package:bhargavi_oil_masala/screens/getstart_page.dart';
import 'package:bhargavi_oil_masala/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bhargavi_oil_masala/app.dart';


Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: GetstartPage()));
}