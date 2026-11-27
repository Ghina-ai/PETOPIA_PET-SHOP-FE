import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  final List<String> animalImages = const [
    'assets/Animals wallpaper iPhone.jpg',
    'assets/Beautiful Guinea Pig, Guinea, Pig, Pet PNG Transparent Image and Clipart for Free Download.jpg',
    'assets/download (72).jpg',
    'assets/download (73).jpg',
    'assets/download (74).jpg',
    'assets/download (75).jpg',
    'assets/Scavenger Hunt.jpg',
    'assets/토끼.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF28C52),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),

                // Kolase foto hewan
                Expanded(
                  flex: 7,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: animalImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          animalImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.white.withOpacity(0.7),
                              child: const Icon(
                                Icons.pets,
                                color: Color(0xFFE98245),
                                size: 35,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // Nama aplikasi
                const Text(
                  'Petopia',
                  style: TextStyle(
                    fontSize: 43,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: Color(0xFF9E4E27),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'A happy place for your lovely pets',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF80543D),
                  ),
                ),

                const Spacer(),

                // Tombol Get Started
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF8F2),
                      foregroundColor: const Color(0xFFB85F32),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
