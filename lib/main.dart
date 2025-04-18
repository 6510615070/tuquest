import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'screens_v2/login.dart';
import 'screens_v2/providers/fav_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('th', null);
  
  runApp(
    MultiProvider(
      providers: [
        // ใส่ Providers ทั้งหมดที่นี่
        ChangeNotifierProvider(create: (_) => FavProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUQuest',
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
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NotiTU",
              style: GoogleFonts.montserrat(
                fontSize: 75,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFA00000),
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Color(0xFFA00000),
            ),
          ],
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:google_fonts/google_fonts.dart'; 
import 'package:intl/date_symbol_data_local.dart';
import 'screens_v2/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('th', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUQuest', //NotiTU
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 166, 35, 39),
        ),
      ),
      home: const SplashPage(), 
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // เปลี่ยนไปหน้า login หลัง 5 วิ
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9D00), // สีพื้นหลังส้ม
      body: Center(
        child: Text(
          "NotiTU",
          style: GoogleFonts.montserrat(
            fontSize: 75,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFA00000), // สีแดงเข้ม
          ),
        ),
      ),
    );
  }
}*/

  //หน้า splash เดิม
  /*Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000),
              Color(0xFFFF0004),
            ],
          ),
        ),
        child: Center(
          child: Text(
            "TUQuest",
            style: GoogleFonts.montserrat(
              fontSize: 48,
              fontWeight: FontWeight.w800, // ExtraBold
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [
                    Color(0xFFA00000),
                    Color(0xFFEA2520),
                    Color(0xFFFF8000),
                  ],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
            ),
          ),
        ),
      ),
    );
  }*/
