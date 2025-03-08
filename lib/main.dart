import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_magic/core/services/auth_checker.dart';
import 'core/services/connection_service.dart';
import 'firebase_options.dart';
import 'models/movie.dart';
import 'models/nowplaying.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(NowPlayingAdapter());
  await Hive.openBox<Movie>('trendingMoviesBox');
  await Hive.openBox<NowPlaying>('playingMoviesBox');
  await Hive.openBox<Movie>('upcomingMoviesBox');
  runApp(const MovieMagic());
}

class MovieMagic extends StatelessWidget {
  const MovieMagic({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Magic',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'ProductSanReg',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 10, 1, 21),
        primaryColor: const Color(0xFF6200EE),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6200EE),
          secondary: Color(0xFF03DAC6),
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const AuthChecker(),
      initialBinding: BindingsBuilder(() {
        Get.put(ConnectivityService());
      }),
    );
  }
}
