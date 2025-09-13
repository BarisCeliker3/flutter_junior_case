import 'package:flutter/material.dart';
import 'profile_photo_picker.dart';
import 'package:case_app/models/movie.dart';
import '../../../l10n/app_localizations.dart'; // <-- Lokalizasyonu ekle

class ProfileScreen extends StatefulWidget {
  final String token;
  final List<Movie> allMovies; // HomeScreen'deki filmler listesi

  const ProfileScreen({
    Key? key,
    required this.token,
    required this.allMovies,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _profilePhotoPath;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context); // Lokalizasyon nesnesi
    // Sadece beğenilen filmleri filtrele
    final likedMovies = widget.allMovies.where((m) => m.liked).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(loc.profile, style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor ?? Colors.white)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? const Color(0xFF18181B),
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).appBarTheme.foregroundColor ?? Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfilePhotoPicker(
                onImageSelected: (path) {
                  setState(() {
                    _profilePhotoPath = path;
                  });
                  // API'ye yükleme işlemi burada yapılabilir
                },
              ),
              const SizedBox(height: 34),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  loc.likedMovies, // <-- Lokalize başlık
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.95) ?? Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              likedMovies.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Text(
                        loc.noLikedMovies, // <-- Lokalize uyarı
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5) ?? Colors.black38,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: likedMovies.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 22,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.70,
                      ),
                      itemBuilder: (context, idx) {
                        final movie = likedMovies[idx];
                        return _ProfileMovieCard(movie: movie);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileMovieCard extends StatelessWidget {
  final Movie movie;

  const _ProfileMovieCard({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white12,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE11D48).withOpacity(0.13),
            blurRadius: 12,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  movie.overview,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ?? Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.favorite,
                  color: Color(0xFFE11D48),
                  size: 21,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}