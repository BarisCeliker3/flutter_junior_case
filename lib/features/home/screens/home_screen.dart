import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:case_app/models/movie.dart';
import 'custom_theme_button.dart';
import 'theme_provider.dart';
import 'custom_theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Movie> movies;

  @override
  void initState() {
    super.initState();
    movies = [
      Movie(
        posterUrl: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=500&q=80",
        title: "Aşk, Ekstasi, Hayaller",
        overview: "Adam Toprak",
        liked: true,
      ),
      Movie(
        posterUrl: "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=500&q=80",
        title: "Yolculuk",
        overview: "Bir macera filmi",
      ),
      Movie(
        posterUrl: "https://images.unsplash.com/photo-1517602302552-471fe67acf66?auto=format&fit=crop&w=500&q=80",
        title: "Gece",
        overview: "Karanlığın hikayesi",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: const Text(
          "Filmler",
          style: TextStyle(
            
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload",
              style: TextStyle(
               
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 10),
            const _UploadPhotoSection(),
            const SizedBox(height: 26),
            const Text(
              "Filmler",
              style: TextStyle(
                  
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            CustomThemeButton(
              text: isDark ? "Açık Tema" : "Koyu Tema",
              onPressed: () {
                // Tema değiştir!
                if (isDark) {
                  themeProvider.setTheme(lightCustomTheme);
                } else {
                  themeProvider.setTheme(darkCustomTheme);
                }
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.06),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: GridView.builder(
                  key: ValueKey(movies.map((e) => e.liked).toList()), // Animasyon için
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.71,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, idx) {
                    final movie = movies[idx];
                    return AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: 1,
                      child: _MovieCard(
                        movie: movie,
                        onLike: () {
                          setState(() {
                            movie.liked = !movie.liked;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _UploadPhotoSection ve _MovieCard kodların aynı şekilde devam edebilir (sende zaten var!)

class _UploadPhotoSection extends StatefulWidget {
  const _UploadPhotoSection();

  @override
  State<_UploadPhotoSection> createState() => _UploadPhotoSectionState();
}

class _UploadPhotoSectionState extends State<_UploadPhotoSection> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // "+" kutusu
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF18181B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE50914), // Figma kırmızı
                width: 1.5,
              ),
              // Kutuya shadow isteğe bağlı eklenebilir
            ),
            child: const Center(
              child: Icon(Icons.add, size: 44, color: Colors.white38),
            ),
          ),
        ),
        // Fotoğraf kutusu
        if (_selectedImage != null)
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF18181B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE50914), // Figma kırmızı
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                ),
              ),
              // Kapat X butonu
              Positioned(
                bottom: 6,
                left: 6,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedImage = null),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white24,
                        width: 1.2,
                      ),
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

// ---- Figma Liked Card Style ----
class _MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onLike;

  const _MovieCard({
    required this.movie,
    required this.onLike,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: const Color(0xFF232326),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white12,
          width: 1.5,
        ),
        boxShadow: movie.liked
            ? [
                BoxShadow(
                  color: const Color(0xFFE11D48).withOpacity(0.13),
                  blurRadius: 12,
                  offset: const Offset(0, 7),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              movie.posterUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                height: 120,
                color: Colors.black26,
                child: const Icon(Icons.broken_image,
                    color: Colors.red, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  movie.overview,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _LikeButton(
                      liked: movie.liked,
                      onTap: onLike,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final bool liked;
  final VoidCallback onTap;
  const _LikeButton({required this.liked, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: liked ? const Color(0xFF18181B) : const Color(0xFF232326),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: liked ? const Color(0xFFE11D48) : Colors.white24,
              width: 1.7,
            ),
          ),
          child: Icon(
            liked ? Icons.favorite : Icons.favorite_border,
            color: liked ? const Color(0xFFE11D48) : Colors.white38,
            size: 21,
          ),
        ),
      ),
    );
  }
}