import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'features/auth/auth_provider.dart';
import 'features/auth/welcome_screen.dart';
import 'features/home/providers/home_provider.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'widgets/main_navigation.dart';
import 'features/home/screens/custom_theme.dart';
import 'features/home/screens/theme_provider.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SplashApp());
}

class SplashApp extends StatefulWidget {
  const SplashApp({Key? key}) : super(key: key);

  @override
  State<SplashApp> createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  bool _showMain = false;
  Locale? _deviceLocale;

  @override
  void initState() {
    super.initState();
    // Başlangıçta splash gösterilecek, devam butonuna basınca geçilecek
  }

  Future<void> _continue() async {
    _deviceLocale = await getLocaleByLocation();
    setState(() {
      _showMain = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_showMain) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) => WelcomeScreen(
            key: const ValueKey('welcome'),
          ),
        ),
        navigatorObservers: [
          _SplashNavObserver(onPop: _continue),
        ],
      );
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(lightCustomTheme)),
      ],
      child: MyApp(deviceLocale: _deviceLocale ?? const Locale('en')),
    );
  }
}

class _SplashNavObserver extends NavigatorObserver {
  final VoidCallback onPop;
  _SplashNavObserver({required this.onPop});
  @override
  void didPop(Route route, Route? previousRoute) {
    onPop();
    super.didPop(route, previousRoute);
  }
}

Future<Locale> getLocaleByLocation() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return const Locale('en');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return const Locale('en');
    }
    if (permission == LocationPermission.deniedForever) return const Locale('en');

  Position position = await Geolocator.getCurrentPosition();
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    var country = placemarks.first.country ?? '';
    if (country.toLowerCase().contains('turkey') || country.toLowerCase().contains('türkiye')) {
      return const Locale('tr');
    }
  } catch (_) {}
  return const Locale('en');
}

class MyApp extends StatelessWidget {
  final Locale deviceLocale;
  const MyApp({super.key, required this.deviceLocale});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) => MaterialApp(
        title: 'Case App',
        theme: themeProvider.themeData,
        locale: deviceLocale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/main': (context) {
            final token = Provider.of<AuthProvider>(context, listen: false).token;
            if (token == null) {
              return const LoginScreen();
            }
            return MainNavigation(token: token!);
          },
        },
      ),
    );
  }
}