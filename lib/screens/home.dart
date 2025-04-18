import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuquest/widgets/navbar.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _notificationCount = 5; // example count

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTapNav(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: navBar(noti: _notificationCount),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: List.generate(
          2,
          (_) => const Center(child: SizedBox.shrink()), // empty content
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapNav,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF8000),
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),

        ],
      ),
    );
  }
}
