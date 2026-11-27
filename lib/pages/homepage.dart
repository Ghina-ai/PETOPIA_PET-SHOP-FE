import 'package:flutter/material.dart';
import '../services/api.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  int? selectedCategory;

  bool isLoadingCategories = true;

  List<Map<String, dynamic>> categories = [];

  final Color orange = const Color(0xFFF28C52);
  final Color darkOrange = const Color(0xFF9E4E27);
  final Color lightOrange = const Color(0xFFFFFFFF);

  // FOTO KATEGORI MANUAL
  final Map<String, String> categoryImages = {
    'food': 'assets/category/food.jpg',
    'care':'assets/category/Kit Banho A Seco Hidratante E Limpa Patas, Orelhas e Lágrimas.jpg',
    'accessories': 'assets/category/download (76).jpg',
    'toys':'assets/category/Anna Averianova - Pet & Product Photographer _ Outdoor Lifestyle & Brand Visuals in Podgorica, Montenegro.jpg',
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

      debugPrint('RESPONSE CATEGORIES: $response');

      if (response is Map && response['success'] == true) {
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

        debugPrint('JUMLAH KATEGORI: ${categories.length}');
      } else {
        throw Exception('Format response kategori tidak sesuai');
      }
    } catch (e) {
      debugPrint('ERROR CATEGORIES: $e');

      if (!mounted) return;

      setState(() {
        isLoadingCategories = false;
        categories = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightOrange,
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
                    colors: [Color(0xFFEDB894), Color(0xFFFFDFC9)],
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
                    // BAGIAN ATAS HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none,
                            color: Color(0xFF754326),
                          ),
                        ),
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
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // CATEGORIES HEADER
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

                          BoxDecoration(
                            color: isSelected ? darkOrange : Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(
                              color: const Color(0xFFEEEEEE)),
                          );

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
                                color: isSelected ? darkOrange : Colors.white,
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                  color: const Color(0xFFEEEEEE),
                                ),
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
                                              errorBuilder:
                                                  (context, error, stackTrace) {
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
            ],
          ),
        ),
      ),
    );
  }
}
