import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'screens/login.dart';
import 'screens/home.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  MyApp({super.key}); 


  @override
  Widget build(BuildContext context) {
      final userState = FirebaseAuth.instance.currentUser;
  bool isLoggedIn = false;
  if (userState!=null){
    isLoggedIn =true;
  }
    return MaterialApp(
      title: 'NotiTU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 166, 35, 39),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: isLoggedIn ? const Home() : const LoginPage(),
    );
  }
}
