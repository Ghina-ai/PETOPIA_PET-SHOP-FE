import 'package:flutter/material.dart';
import '../services/api.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  int selectedCategory = 0;

  bool isLoadingCategories = true;

  List<Map<String, dynamic>> categories = [];

  final Color orange = const Color(0xFFF28C52);
  final Color darkOrange = const Color(0xFF9E4E27);
  final Color lightOrange = const Color(0xFFFFF1E7);

  // FOTO KATEGORI MANUAL
  final Map<String, String> categoryImages = {
    'food': 'assets/category/food.jpg',
    'care': 'assets/category/Kit Banho A Seco Hidratante E Limpa Patas, Orelhas e Lágrimas.jpg',
    'accessories': 'assets/category/download (76).jpg',
    'toys': 'assets/category/Anna Averianova - Pet & Product Photographer _ Outdoor Lifestyle & Brand Visuals in Podgorica, Montenegro.jpg',
    'equipment': 'assets/category/Lovely Pets.jpg',
  };

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  // GET CATEGORIES FROM BACKEND
  Future<void> fetchCategories() async {
    try {
      final response = await ApiServices.get('/categories');

      if (response['success'] == true) {
        final categoryData = response['data'];

        final List<dynamic> categoryList = categoryData is List
            ? categoryData
            : categoryData is Map
            ? categoryData['categories'] ?? []
            : [];

        if (!mounted) return;

        setState(() {
          categories = categoryList
              .map((item) => Map<String, dynamic>.from(item))
              .toList();

          isLoadingCategories = false;
        });
      } else {
        if (!mounted) return;

        setState(() {
          isLoadingCategories = false;
        });
      }
    } catch (e) {
      debugPrint('Error mengambil kategori: $e');

      if (!mounted) return;

      setState(() {
        isLoadingCategories = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF6),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFC49E), Color(0xFFFFE6D5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LOCATION & ICONS
                    Row(
                      children: [
                        _circleButton(Icons.location_on_outlined, () {}),

                        const SizedBox(width: 10),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery Location',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF80543D),
                                ),
                              ),

                              Row(
                                children: [
                                  Text(
                                    'Choose your location',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF754326),
                                    ),
                                  ),

                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18,
                                    color: Color(0xFF754326),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        _circleButton(Icons.shopping_cart_outlined, () {}),

                        const SizedBox(width: 10),

                        _circleButton(Icons.notifications_none, () {}),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // TITLE
                    const Text(
                      'For Your Lovely Pets',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF754326),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // SEARCH BAR
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),

                          SizedBox(width: 10),

                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search products, grooming...',
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // CATEGORIES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF754326),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman semua kategori
                      },
                      child: const Row(
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              color: Color(0xFFF28C52),
                              fontSize: 12,
                            ),
                          ),

                          Icon(
                            Icons.chevron_right,
                            color: Color(0xFFF28C52),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // CATEGORY LIST
              SizedBox(
                height: 65,
                child: isLoadingCategories
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFF28C52),
                        ),
                      )
                    : categories.isEmpty
                    ? const Center(
                        child: Text(
                          'Kategori belum tersedia',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,

                        separatorBuilder: (_, __) => const SizedBox(width: 10),

                        itemBuilder: (context, index) {
                          final category = categories[index];

                          final String name =
                              category['name']?.toString() ?? '';

                          final String imagePath =
                              categoryImages[name.toLowerCase()] ?? '';

                          final bool isSelected = selectedCategory == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                              });
                            },

                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 6,
                              ),

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? darkOrange
                                    : const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(35),
                              ),

                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 43,
                                      height: 43,
                                      color: Colors.white,

                                      child: imagePath.isNotEmpty
                                          ? Image.asset(
                                              imagePath,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) {
                                                return const Icon(
                                                  Icons.pets,
                                                  color: Color(0xFFF28C52),
                                                );
                                              },
                                            )
                                          : const Icon(
                                              Icons.pets,
                                              color: Color(0xFFF28C52),
                                            ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF754326),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 20),

              // GROOMING BANNER
              _sectionTitle('Grooming Services'),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [orange, const Color(0xFFFFB783)],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Keep Your Pets Clean!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 7),

                            Text(
                              'Give your lovely pets the best grooming care.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              'Explore Services →',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.pets, color: Colors.white, size: 65),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // PET DATA
              _sectionTitle('Your Lovely Pets'),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFFFE2CF)),
                  ),

                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,

                        decoration: BoxDecoration(
                          color: lightOrange,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Icon(Icons.add, color: orange, size: 28),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Your Pet',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF754326),
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Save your pet information here',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: orange,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Produk',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.cut_outlined),
            label: 'Grooming',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.pets_outlined),
            label: 'Data Hewan',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // CIRCLE BUTTON
  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),

      child: Container(
        width: 43,
        height: 43,

        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),

        child: Icon(icon, color: const Color(0xFFE98245), size: 22),
      ),
    );
  }

  // SECTION TITLE
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFF754326),
        ),
      ),
    );
  }
}
