import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navbar_provider.dart';
import '../fav.dart';
import '../account.dart';
import '../home/home.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);

    return BottomNavigationBar(
      currentIndex: navBarProvider.currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: const Color(0xFFFF9D00),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Account',
        ),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    final navBarProvider = Provider.of<NavBarProvider>(context, listen: false);
    navBarProvider.changeIndex(index);

    final routes = <Map<String, dynamic>>[
      {'page': const FavPage(), 'name': '/fav'},
      {'page': const HomePage(), 'name': '/home'},
      {'page': const AccountPage(), 'name': '/account'},
    ];

    if (ModalRoute.of(context)?.settings.name != routes[index]['name']) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => routes[index]['page'] as Widget,
          settings: RouteSettings(name: routes[index]['name'] as String),
        ),
        (route) {
          if (index == 1) return route.isFirst;
          return route.settings.name == '/home' || route.isFirst;
        },
      );
    }
  }
}
/*class CustomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    final routes = <Map<String, dynamic>>[
      {'page': const FavPage(), 'name': '/fav'},
      {'page': const HomePage(), 'name': '/home'},
      {'page': const AccountPage(), 'name': '/account'},
    ];

    // ตรวจสอบว่าหน้าปัจจุบันเป็นหน้าที่ต้องการเปิดหรือไม่
  if (ModalRoute.of(context)?.settings.name != routes[index]['name']) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => routes[index]['page'] as Widget,
        settings: RouteSettings(name: routes[index]['name'] as String),
      ),
      (route) {
        // ถ้ากำลังเปิดหน้า Home ให้ล้าง stack ทั้งหมด
        if (index == 1) return route.isFirst;
        // ถ้าเปิดหน้าอื่น ให้เก็บ HomePage ไว้ด้านล่าง
        return route.settings.name == '/home' || route.isFirst;
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: const Color(0xFFFF9D00),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Account',
        ),
      ],
    );
  }
}*/