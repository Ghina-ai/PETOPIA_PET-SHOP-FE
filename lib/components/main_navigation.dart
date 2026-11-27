import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../pages/homepage.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;
  int? roleId;
  bool isLoading = true;

  final Color primaryColor = const Color(0xFF9E4E27);

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  Future<void> loadRole() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      roleId = prefs.getInt('roleId');
      isLoading = false;
    });
  }

  List<Widget> get pages {
    switch (roleId) {
      case 1: // ADMIN
        return const [
          NavigationPlaceholder(title: 'Home Admin'),
          NavigationPlaceholder(title: 'Tambah Produk'),
          NavigationPlaceholder(title: 'Layanan Grooming'),
          NavigationPlaceholder(title: 'Tambah Grooming'),
          NavigationPlaceholder(title: 'Profile'),
        ];

      case 2: // KARYAWAN
        return const [
          NavigationPlaceholder(title: 'Home Karyawan'),
          NavigationPlaceholder(title: 'Booking'),
          NavigationPlaceholder(title: 'Profile'),
        ];

      case 3: // USER
        return const [
          Homepage(),
          NavigationPlaceholder(title: 'Grooming'),
          NavigationPlaceholder(title: 'Tambah Hewan'),
          NavigationPlaceholder(title: 'Keranjang'),
          NavigationPlaceholder(title: 'Profile'),
        ];

      default:
        return const [
          NavigationPlaceholder(title: 'Role tidak ditemukan'),
        ];
    }
  }

  List<SalomonBottomBarItem> get navigationItems {
    switch (roleId) {
      case 1: // ADMIN
        return [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_box_outlined),
            title: const Text('Produk'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.pets_outlined),
            title: const Text('Grooming'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_circle_outline),
            title: const Text('Tambah'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            selectedColor: primaryColor,
          ),
        ];

      case 2: // KARYAWAN
        return [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.assignment_outlined),
            title: const Text('Booking'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            selectedColor: primaryColor,
          ),
        ];

      case 3: // USER
        return [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.pets_outlined),
            title: const Text('Grooming'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_circle_outline),
            title: const Text('Hewan'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Keranjang'),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            selectedColor: primaryColor,
          ),
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (roleId == null || ![1, 2, 3].contains(roleId)) {
      return const Scaffold(
        body: Center(child: Text('Role tidak ditemukan')),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        selectedColorOpacity: 0.12,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        itemPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        items: navigationItems,
      ),
    );
  }
}

class NavigationPlaceholder extends StatelessWidget {
  final String title;

  const NavigationPlaceholder({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
