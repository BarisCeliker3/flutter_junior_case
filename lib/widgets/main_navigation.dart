import 'package:flutter/material.dart';
import '../features/home/screens/home_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import 'limited_offer_bottom_sheet.dart';
import 'package:case_app/models/movie.dart'; // SADECE BUNU KULLAN!

class MainNavigation extends StatefulWidget {
  final String token;
  const MainNavigation({Key? key, required this.token}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _offerShown = false;
  late final List<Movie> movies;
  late final List<Widget> _screens;
  late final List<GlobalKey<NavigatorState>> _navigatorKeys;

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
    _screens = [
      HomeScreen(token: widget.token),
      ProfileScreen(
        token: widget.token,
        allMovies: movies,
      ),
    ];
    _navigatorKeys = [
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_offerShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const LimitedOfferBottomSheet(),
        );
      });
      _offerShown = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: _screens[_currentIndex],
        layoutBuilder: (currentChild, previousChildren) => currentChild!,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavBarItem(
                icon: Icons.home,
                label: 'Anasayfa',
                selected: _currentIndex == 0,
                onTap: () {
                  if (_currentIndex != 0) {
                    setState(() {
                      _currentIndex = 0;
                    });
                  }
                },
              ),
              _NavBarItem(
                icon: Icons.person,
                label: 'Profil',
                selected: _currentIndex == 1,
                onTap: () {
                  if (_currentIndex != 1) {
                    setState(() {
                      _currentIndex = 1;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF18181B),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Figma: Radial Gradient için bir workaround - Linear ile en azından iki rengi veriyoruz
    final gradient = selected
        ? const LinearGradient(
            colors: [Color(0xFFE50914), Color(0xFF7F050B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : null;
    final bgColor = selected ? null : const Color(0xFF18181B);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.ease,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            gradient: gradient,
            borderRadius: BorderRadius.circular(42), // Figma: 42px radius
            border: Border.all(
              color: Colors.white.withOpacity(0.16), // Figma'da 1px border
              width: 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: const Color(0xFFE50914).withOpacity(0.14),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : Colors.white54,
                size: 22,
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white54,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                  fontSize: selected ? 14 : 13,
                  letterSpacing: 0.14,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}